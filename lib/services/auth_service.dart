import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:get/get.dart';
import '../models/admin_model.dart';
import '../models/team_leader_model.dart';
import '../models/team_member_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> signIn({required String email, required String password, required String role}) async {
    try {
      print('Attempting to sign in with email: $email, role: $role');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      print('Firebase Auth successful, UID: $uid');

      if (role.toLowerCase() == 'admin') {
        print('Checking admins collection for UID: $uid');
        DocumentSnapshot adminDoc = await _firestore.collection('admins').doc(uid).get();
        if (adminDoc.exists) {
          print('Admin found: ${adminDoc.data()}');
          return null; // Success
        }
        print('Admin not found in admins collection for UID: $uid, trying userId: $uid');
        QuerySnapshot adminSnapshot = await _firestore.collection('admins').where('userId', isEqualTo: uid).get();
        if (adminSnapshot.docs.isNotEmpty) {
          print('Admin found by userId: ${adminSnapshot.docs.first.data()}');
          return null; // Success
        }
        print('Admin not found in admins collection');
        DocumentSnapshot leaderDoc = await _firestore.collection('TeamLeaders').doc(uid).get();
        DocumentSnapshot memberDoc = await _firestore.collection('TeamMembers').doc(uid).get();
        if (leaderDoc.exists) {
          print('User found in TeamLeaders collection: ${leaderDoc.data()}');
          return 'Invalid credentials for Admin role';
        }
        if (memberDoc.exists) {
          print('User found in TeamMembers collection: ${memberDoc.data()}');
          return 'Invalid credentials for Admin role';
        }
        return 'Admin not found';
      } else if (role == 'TeamLeader') {
        print('Checking TeamLeaders collection for UID: $uid');
        DocumentSnapshot leaderDoc = await _firestore.collection('TeamLeaders').doc(uid).get();
        if (leaderDoc.exists && leaderDoc['status'] == 'approved') {
          print('Team Leader found: ${leaderDoc.data()}');
          return null; // Success
        }
        print('Team Leader not found or not approved: ${leaderDoc.exists ? leaderDoc.data() : 'No document'}');
        return leaderDoc.exists ? 'Registration not approved' : 'Team Leader not found';
      } else if (role == 'TeamMember') {
        print('Checking TeamMembers collection for UID: $uid');
        DocumentSnapshot memberDoc = await _firestore.collection('TeamMembers').doc(uid).get();
        if (memberDoc.exists && memberDoc['status'] == 'approved') {
          print('Team Member found: ${memberDoc.data()}');
          return null; // Success
        }
        print('Team Member not found or not approved: ${memberDoc.exists ? memberDoc.data() : 'No document'}');
        return memberDoc.exists ? 'Registration not approved' : 'Team Member not found';
      }
      print('Invalid role: $role');
      return 'Invalid role';
    } catch (e) {
      print('Sign-in error: $e');
      return e.toString();
    }
  }

  Future<String?> signUp({
    required String email,
    required String password,
    required String name,
    required String countryCode,
    required String mobileNumber,
    required String id,
    required String signupId,
    required String role,
  }) async {
    try {
      print('Attempting signup for email: $email, role: $role, id: $id');
      // Validate ID
      bool isValidId = await _validateId(id, role);
      if (!isValidId) {
        print('ID validation failed');
        return role == 'TeamLeader' ? 'Invalid Admin ID' : 'Invalid Leader ID';
      }
      print('ID validation successful');

      // Create user in Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      print('Firebase Auth signup successful, UID: $uid');

      // Prepare user data
      Map<String, dynamic> userData = {
        'id': uid,
        'email': email,
        'name': name.isEmpty ? 'Unknown' : name,
        'countryCode': countryCode.isEmpty ? '' : countryCode,
        'mobileNumber': mobileNumber.isEmpty ? '' : mobileNumber,
        'signupId': signupId,
        'userId': uid,
        'profilePicture': '',
        'profileThumbnail': '',
        'status': 'pending',
      };

      // Add role-specific fields
      if (role == 'TeamLeader') {
        userData['byAdminId'] = id;
      } else if (role == 'TeamMember') {
        userData['byLeaderId'] = id;
      }

      // Store in Firestore
      if (role == 'TeamLeader') {
        print('Storing TeamLeader data: $userData');
        await _firestore.collection('TeamLeaders').doc(uid).set(userData);
        // Create registration request
        print('Creating registration request for TeamLeader, adminId: $id');
        await _firestore.collection('RegistrationRequests').doc(uid).set({
          'userId': uid,
          'role': role,
          'adminId': id,
          'status': 'pending',
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else if (role == 'TeamMember') {
        print('Storing TeamMember data: $userData');
        await _firestore.collection('TeamMembers').doc(uid).set(userData);
        // Create registration request
        print('Creating registration request for TeamMember, leaderId: $id');
        await _firestore.collection('RegistrationRequests').doc(uid).set({
          'userId': uid,
          'role': role,
          'leaderId': id,
          'status': 'pending',
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        print('Invalid role for signup: $role');
        return 'Invalid role';
      }

      print('Signup successful for UID: $uid');
      return null; // Success
    } catch (e) {
      print('Signup error: $e');
      // Cleanup on failure
      if (_auth.currentUser != null) {
        await _auth.currentUser!.delete();
        print('Deleted Firebase Auth user due to signup failure');
      }
      return e.toString();
    }
  }

  Future<bool> _validateId(String id, String role) async {
    try {
      if (role == 'TeamLeader') {
        print('Validating adminId: $id in admins collection');
        QuerySnapshot adminSnapshot = await _firestore.collection('admins').where('signupId', isEqualTo: id).get();
        print('Admin ID validation result: ${adminSnapshot.docs.isNotEmpty ? 'Found' : 'Not found'}');
        return adminSnapshot.docs.isNotEmpty;
      } else if (role == 'TeamMember') {
        print('Validating leaderId: $id in TeamLeaders collection');
        QuerySnapshot leaderSnapshot = await _firestore.collection('TeamLeaders').where('signupId', isEqualTo: id).get();
        print('Leader ID validation result: ${leaderSnapshot.docs.isNotEmpty ? 'Found' : 'Not found'}');
        return leaderSnapshot.docs.isNotEmpty;
      }
      print('Invalid role for ID validation: $role');
      return false;
    } catch (e) {
      print('ID validation error: $e');
      return false;
    }
  }

  Future<String?> getUserRole(String uid) async {
    try {
      print('Checking user role for UID: $uid');
      DocumentSnapshot adminDoc = await _firestore.collection('admins').doc(uid).get();
      if (adminDoc.exists) {
        print('User is Admin: ${adminDoc.data()}');
        return 'admin';
      }
      print('Admin not found for UID: $uid, trying userId: $uid');
      QuerySnapshot adminSnapshot = await _firestore.collection('admins').where('userId', isEqualTo: uid).get();
      if (adminSnapshot.docs.isNotEmpty) {
        print('User is Admin: ${adminSnapshot.docs.first.data()}');
        return 'admin';
      }
      DocumentSnapshot leaderDoc = await _firestore.collection('TeamLeaders').doc(uid).get();
      if (leaderDoc.exists && leaderDoc['status'] == 'approved') {
        print('User is TeamLeader: ${leaderDoc.data()}');
        return 'TeamLeader';
      }
      DocumentSnapshot memberDoc = await _firestore.collection('TeamMembers').doc(uid).get();
      if (memberDoc.exists && memberDoc['status'] == 'approved') {
        print('User is TeamMember: ${memberDoc.data()}');
        return 'TeamMember';
      }
      print('No valid role found for UID: $uid');
      return null;
    } catch (e) {
      print('Error fetching user role: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      print('Attempting to sign out');
      // Clear SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('selectedRole');
      await prefs.setBool('isFirstTime', true); // Reset for SelectionScreen
      print('Cleared SharedPreferences');

      // Sign out from Firebase Auth
      await _auth.signOut();
      print('Firebase Auth sign out successful');

      // Navigate to SelectionScreen
      Get.offAllNamed('/selection');
      Get.snackbar(
        'Success',
        'Logged out successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Sign-out error: $e');
      Get.snackbar(
        'Error',
        'Logout failed: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
    }
  }

  Future<void> approveRequest(String userId, String requestRole) async {
    try {
      print('Approving request for userId: $userId, role: $requestRole');
      await _firestore.collection('RegistrationRequests').doc(userId).update({
        'status': 'approved',
        'approvedTimestamp': FieldValue.serverTimestamp(),
      });
      final collection = requestRole == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers';
      await _firestore.collection(collection).doc(userId).update({
        'status': 'approved',
      });
      print('Request approved successfully');
      Get.snackbar(
        'Success',
        'Request approved',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error approving request: $e');
      Get.snackbar(
        'Error',
        'Failed to approve request: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
    }
  }

  Future<void> rejectRequest(String userId, String requestRole) async {
    try {
      print('Rejecting request for userId: $userId, role: $requestRole');
      await _firestore.collection('RegistrationRequests').doc(userId).update({
        'status': 'rejected',
        'rejectedTimestamp': FieldValue.serverTimestamp(),
      });
      final collection = requestRole == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers';
      await _firestore.collection(collection).doc(userId).delete();
      print('Deleted Firestore document for userId: $userId in $collection');
      // Delete Firebase Auth user
      try {
        await _auth.currentUser?.delete(); // Note: This assumes the approving user has permissions
      } catch (authError) {
        print('Error deleting Firebase Auth user: $authError');
        // If deletion fails due to permissions, the user must manually delete their account
      }
      print('Request rejected successfully');
      Get.snackbar(
        'Success',
        'Request rejected',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error rejecting request: $e');
      Get.snackbar(
        'Error',
        'Failed to reject request: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
    }
  }
}