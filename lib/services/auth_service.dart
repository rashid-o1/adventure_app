import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:get/get.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> signIn({required String email, required String password, required String role}) async {
    try {
      print('Attempting to sign in with email: $email, role: $role');

      QuerySnapshot userSnapshot = await _firestore
          .collection(role == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers')
          .where('email', isEqualTo: email)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        var userDoc = userSnapshot.docs.first;
        if (!userDoc['isApproved']) {
          print('User found but not approved: ${userDoc.data()}');
          return 'Your account is not approved by admin';
        }
      } else if (role != 'admin') {
        print('User not found in ${role == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers'} collection');
        return 'Account is not approved yet';
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      print('Firebase Auth successful, UID: $uid');

      // Persist role and signUpId in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selectedRole', role);
      await prefs.setBool('isFirstTime', false);
      print('Stored role in SharedPreferences: $role');

      // Fetch and store signUpId
      String? signUpId;
      if (role == 'admin') {
        QuerySnapshot adminSnapshot = await _firestore.collection('admins').where('userId', isEqualTo: uid).get();
        if (adminSnapshot.docs.isNotEmpty && adminSnapshot.docs.first['signUpId'] != null) {
          signUpId = adminSnapshot.docs.first['signUpId'].toString();
          print('Admin signUpId: $signUpId');
        }
      } else if (role == 'TeamLeader') {
        DocumentSnapshot leaderDoc = await _firestore.collection('TeamLeaders').doc(uid).get();
        if (leaderDoc.exists && leaderDoc['signUpId'] != null) {
          signUpId = leaderDoc['signUpId'].toString();
          print('TeamLeader signUpId: $signUpId');
        }
      } else if (role == 'TeamMember') {
        DocumentSnapshot memberDoc = await _firestore.collection('TeamMembers').doc(uid).get();
        if (memberDoc.exists && memberDoc['signUpId'] != null) {
          signUpId = memberDoc['signUpId'].toString();
          print('TeamMember signUpId: $signUpId');
        }
      }
      if (signUpId != null) {
        await prefs.setString('signUpId', signUpId);
        print('Stored signUpId in SharedPreferences: $signUpId');
      } else {
        print('No signUpId found for role: $role, uid: $uid');
      }

      if (role.toLowerCase() == 'admin') {
        QuerySnapshot adminSnapshot = await _firestore.collection('admins').where('userId', isEqualTo: uid).get();
        if (adminSnapshot.docs.isNotEmpty) {
          print('Admin found: ${adminSnapshot.docs.first.data()}');
          return null;
        }
        print('Admin not found for UID: $uid');
        return 'Admin not found';
      } else if (role == 'TeamLeader' || role == 'TeamMember') {
        DocumentSnapshot userDoc = await _firestore.collection(role == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers').doc(uid).get();
        if (userDoc.exists && userDoc['isApproved']) {
          print('$role found: ${userDoc.data()}');
          return null;
        }
        print('$role not found or not approved: ${userDoc.exists ? userDoc.data() : 'No document'}');
        return userDoc.exists ? 'Your account is not approved by admin' : 'Account is not approved yet';
      }
      print('Invalid role: $role');
      return 'Invalid role';
    } catch (e) {
      print('Sign-in error: $e');
      if (e.toString().contains('user-not-found') || e.toString().contains('wrong-password')) {
        QuerySnapshot userSnapshot = await _firestore
            .collection(role == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers')
            .where('email', isEqualTo: email)
            .get();
        if (userSnapshot.docs.isNotEmpty) {
          return 'Account is not approved yet';
        }
        return 'Invalid credentials';
      } else if (e.toString().contains('PERMISSION_DENIED')) {
        return 'Permission denied. Please check Firebase configuration.';
      }
      return e.toString();
    }
  }

  Future<bool> isUserApproved(String uid, String role) async {
    try {
      if (role.toLowerCase() == 'admin') {
        DocumentSnapshot adminDoc = await _firestore.collection('admins').doc(uid).get();
        if (adminDoc.exists) {
          print('Admin found: ${adminDoc.data()}');
          return true;
        }
        QuerySnapshot adminSnapshot = await _firestore.collection('admins').where('userId', isEqualTo: uid).get();
        return adminSnapshot.docs.isNotEmpty;
      } else if (role == 'TeamLeader' || role == 'TeamMember') {
        DocumentSnapshot userDoc = await _firestore.collection(role == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers').doc(uid).get();
        if (userDoc.exists) {
          print('$role document found: ${userDoc.data()}');
          return userDoc['isApproved'] == true;
        }
        print('$role document not found for UID: $uid');
        return false;
      }
      print('Invalid role for approval check: $role');
      return false;
    } catch (e) {
      print('Error checking approval status: $e');
      return false;
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

      QuerySnapshot existingUser = await _firestore
          .collection(role == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers')
          .where('email', isEqualTo: email)
          .get();
      print('Existing user query result: ${existingUser.docs.isNotEmpty ? existingUser.docs.map((doc) => doc.data()).toList() : 'No existing users'}');
      if (existingUser.docs.isNotEmpty) {
        print('Email already registered: $email');
        return 'Email already registered';
      }

      bool isValidId = await _validateId(id, role);
      if (!isValidId) {
        print('ID validation failed');
        return role == 'TeamLeader' ? 'Invalid Admin ID' : 'Invalid Leader ID';
      }
      print('ID validation successful');

      String tempId = _firestore.collection('RegistrationRequests').doc().id;
      print('Generated tempId: $tempId');

      String passwordHex = sha256.convert(utf8.encode(password)).toString();
      print('Password converted to hex: $passwordHex');

      Map<String, dynamic> userData = {
        'id': tempId,
        'email': email,
        'passwordHex': passwordHex,
        'name': name.isEmpty ? 'Unknown' : name,
        'countryCode': countryCode.isEmpty ? '' : countryCode,
        'mobileNumber': mobileNumber.isEmpty ? '' : mobileNumber,
        'signUpId': int.parse(signupId),
        'userId': tempId,
        'profilePicture': '',
        'profileThumbnail': '',
        'isApproved': false,
        'createdOn': FieldValue.serverTimestamp(),
      };

      if (role == 'TeamLeader') {
        userData['byAdminId'] = int.parse(id);
      } else if (role == 'TeamMember') {
        userData['byLeaderId'] = int.parse(id);
      }

      Map<String, dynamic> requestData = {
        'userId': tempId,
        'email': email,
        'password': password,
        'passwordHex': passwordHex,
        'name': name.isEmpty ? 'Unknown' : name,
        'countryCode': countryCode.isEmpty ? '' : countryCode,
        'mobileNumber': mobileNumber.isEmpty ? '' : mobileNumber,
        'signUpId': int.parse(signupId),
        'role': role,
        'status': 'pending',
        'timestamp': FieldValue.serverTimestamp(),
      };

      if (role == 'TeamLeader') {
        requestData['adminId'] = int.parse(id);
      } else if (role == 'TeamMember') {
        requestData['leaderId'] = int.parse(id);
      }

      WriteBatch batch = _firestore.batch();
      batch.set(_firestore.collection(role == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers').doc(tempId), userData);
      batch.set(_firestore.collection('RegistrationRequests').doc(tempId), requestData);

      print('Storing user data in ${role == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers'} and RegistrationRequests: $tempId');
      await batch.commit();

      print('Signup request submitted successfully for tempId: $tempId');
      return null;
    } catch (e) {
      print('Signup error: $e');
      if (e.toString().contains('PERMISSION_DENIED')) {
        print('Permission denied during signup. Check Firestore rules for ${role == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers'} read access.');
        return 'Permission denied. Please check Firebase configuration.';
      }
      return e.toString();
    }
  }

  Future<bool> _validateId(String id, String role) async {
    try {
      int idNum = int.parse(id);
      if (role == 'TeamLeader') {
        print('Validating adminId: $idNum in admins collection');
        QuerySnapshot adminSnapshot = await _firestore.collection('admins').where('signUpId', isEqualTo: idNum).get();
        adminSnapshot.docs.forEach((doc) => print('Found admin doc: ${doc.data()}'));
        print('Admin ID validation result: ${adminSnapshot.docs.isNotEmpty ? 'Found' : 'Not found'}');
        return adminSnapshot.docs.isNotEmpty;
      } else if (role == 'TeamMember') {
        print('Validating leaderId: $idNum in TeamLeaders collection');
        QuerySnapshot leaderSnapshot = await _firestore.collection('TeamLeaders').where('signUpId', isEqualTo: idNum).get();
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
      QuerySnapshot adminSnapshot = await _firestore.collection('admins').where('userId', isEqualTo: uid).get();
      if (adminSnapshot.docs.isNotEmpty) {
        print('User is admin: ${adminSnapshot.docs.first.data()}');
        return 'admin';
      }
      DocumentSnapshot leaderDoc = await _firestore.collection('TeamLeaders').doc(uid).get();
      if (leaderDoc.exists && leaderDoc['isApproved']) {
        print('User is TeamLeader: ${leaderDoc.data()}');
        return 'TeamLeader';
      }
      DocumentSnapshot memberDoc = await _firestore.collection('TeamMembers').doc(uid).get();
      if (memberDoc.exists && memberDoc['isApproved']) {
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('selectedRole');
      await prefs.remove('signUpId');
      print('Cleared SharedPreferences');

      await _auth.signOut();
      print('Firebase Auth sign out successful');

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

  Future<void> approveRequest(String tempId, String requestRole) async {
    int maxRetries = 3;
    int retryCount = 0;
    Exception? lastError;
    UserCredential? userCredential;

    while (retryCount < maxRetries) {
      try {
        print('Approving request for tempId: $tempId, role: $requestRole, attempt: ${retryCount + 1}');
        String currentUserUid = _auth.currentUser!.uid;
        print('Current user UID: $currentUserUid');

        DocumentSnapshot requestDoc = await _firestore.collection('RegistrationRequests').doc(tempId).get();
        if (!requestDoc.exists) {
          print('Registration request not found for tempId: $tempId');
          throw 'Registration request not found';
        }
        Map<String, dynamic> requestData = requestDoc.data() as Map<String, dynamic>;
        print('Registration request data: $requestData');

        String passwordHex = sha256.convert(utf8.encode(requestData['password'])).toString();
        if (passwordHex != requestData['passwordHex']) {
          print('Password hex verification failed for tempId: $tempId');
          throw 'Invalid password hash';
        }

        userCredential = await _auth.createUserWithEmailAndPassword(
          email: requestData['email'],
          password: requestData['password'],
        );
        String newUserUid = userCredential.user!.uid;
        print('Firebase Auth user created, UID: $newUserUid');

        DocumentSnapshot userDoc = await _firestore
            .collection(requestRole == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers')
            .doc(tempId)
            .get();
        if (!userDoc.exists) {
          print('User document not found for tempId: $tempId');
          throw 'User document not found';
        }
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        print('Existing user data: $userData');

        String? currentUserRole = await getUserRole(currentUserUid);
        dynamic signUpId;
        if (currentUserRole == 'admin') {
          QuerySnapshot adminSnapshot = await _firestore.collection('admins').where('userId', isEqualTo: currentUserUid).get();
          if (!adminSnapshot.docs.isNotEmpty) {
            print('No admin document found for UID: $currentUserUid');
            throw 'No admin document found';
          }
          signUpId = adminSnapshot.docs.first['signUpId'];
          print('Current user is admin, signUpId: $signUpId');
        } else if (currentUserRole == 'TeamLeader') {
          DocumentSnapshot leaderDoc = await _firestore.collection('TeamLeaders').doc(currentUserUid).get();
          if (!leaderDoc.exists) {
            print('No TeamLeader document found for UID: $currentUserUid');
            throw 'No TeamLeader document found';
          }
          signUpId = leaderDoc['signUpId'];
          print('Current user is TeamLeader, signUpId: $signUpId');
        } else {
          print('Current user has no valid role: $currentUserRole');
          throw 'Current user has no valid role';
        }

        if (signUpId == null) {
          print('No signUpId found for current user');
          throw 'No signUpId found for current user';
        }

        if (requestRole == 'TeamLeader' && requestData['adminId'] != signUpId) {
          print('Permission denied: adminId ${requestData['adminId']} does not match signUpId $signUpId');
          throw 'Permission denied: Not authorized to approve this request';
        } else if (requestRole == 'TeamMember' && requestData['leaderId'] != signUpId) {
          print('Permission denied: leaderId ${requestData['leaderId']} does not match signUpId $signUpId');
          throw 'Permission denied: Not authorized to approve this request';
        }

        Map<String, dynamic> newUserData = {
          ...userData,
          'id': newUserUid,
          'userId': newUserUid,
          'isApproved': true,
          'approvedTimestamp': FieldValue.serverTimestamp(),
          'byAdminId': requestRole == 'TeamLeader' ? signUpId : userData['byAdminId'],
          'byLeaderId': requestRole == 'TeamMember' ? signUpId : userData['byLeaderId'] ?? null,
        };

        Map<String, dynamic> requestUpdates = {
          'status': 'approved',
          'uid': newUserUid,
          'password': FieldValue.delete(),
          'passwordHex': FieldValue.delete(),
          'approvedTimestamp': FieldValue.serverTimestamp(),
        };

        WriteBatch batch = _firestore.batch();
        batch.set(
          _firestore.collection(requestRole == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers').doc(newUserUid),
          newUserData,
          SetOptions(merge: true),
        );
        batch.update(_firestore.collection('RegistrationRequests').doc(tempId), requestUpdates);
        batch.delete(_firestore.collection(requestRole == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers').doc(tempId));

        print('Committing batch write for approveRequest, tempId: $tempId, new UID: $newUserUid, updates: $newUserData, $requestUpdates');
        await batch.commit();

        // Store signUpId for the approved user
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('signUpId', userData['signUpId'].toString());
        print('Stored signUpId for approved user: ${userData['signUpId']}');

        print('Request approved successfully for tempId: $tempId, new UID: $newUserUid');
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
        return;
      } catch (e) {
        print('Error approving request on attempt ${retryCount + 1}: $e');
        lastError = e as Exception;
        if (userCredential != null) {
          try {
            await userCredential.user!.delete();
            print('Cleaned up Firebase Auth user due to failed approval');
          } catch (deleteError) {
            print('Failed to delete Firebase Auth user: $deleteError');
          }
        }
        if (e.toString().contains('UNAVAILABLE') || e.toString().contains('UnknownHostException')) {
          retryCount++;
          await Future.delayed(Duration(seconds: 2));
          continue;
        }
        Get.snackbar(
          'Error',
          'Failed to approve request: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
        );
        throw e;
      }
    }
    print('Max retries reached for approveRequest: $lastError');
    throw lastError ?? Exception('Failed to approve request after $maxRetries attempts');
  }

  Future<void> rejectRequest(String tempId, String requestRole) async {
    int maxRetries = 3;
    int retryCount = 0;
    Exception? lastError;

    while (retryCount < maxRetries) {
      try {
        print('Rejecting request for tempId: $tempId, role: $requestRole, attempt: ${retryCount + 1}');
        String currentUserUid = _auth.currentUser!.uid;
        String? currentUserRole = await getUserRole(currentUserUid);
        dynamic signUpId;

        if (currentUserRole == 'admin') {
          QuerySnapshot adminSnapshot = await _firestore.collection('admins').where('userId', isEqualTo: currentUserUid).get();
          if (!adminSnapshot.docs.isNotEmpty) {
            print('No admin document found for UID: $currentUserUid');
            throw 'No admin document found';
          }
          signUpId = adminSnapshot.docs.first['signUpId'];
          print('Current user is admin, signUpId: $signUpId');
        } else if (currentUserRole == 'TeamLeader') {
          DocumentSnapshot leaderDoc = await _firestore.collection('TeamLeaders').doc(currentUserUid).get();
          if (!leaderDoc.exists) {
            print('No TeamLeader document found for UID: $currentUserUid');
            throw 'No TeamLeader document found';
          }
          signUpId = leaderDoc['signUpId'];
          print('Current user is TeamLeader, signUpId: $signUpId');
        } else {
          print('Current user has no valid role: $currentUserRole');
          throw 'Current user has no valid role';
        }

        if (signUpId == null) {
          print('No signUpId found for current user');
          throw 'No signUpId found for current user';
        }

        DocumentSnapshot requestDoc = await _firestore.collection('RegistrationRequests').doc(tempId).get();
        if (!requestDoc.exists) {
          print('Registration request not found for tempId: $tempId');
          throw 'Registration request not found';
        }
        Map<String, dynamic> requestData = requestDoc.data() as Map<String, dynamic>;
        print('Registration request data: $requestData');

        if (requestData['adminId'] != signUpId && requestData['leaderId'] != signUpId) {
          print('Permission denied: User signUpId $signUpId does not match request adminId ${requestData['adminId']} or leaderId ${requestData['leaderId']}');
          throw 'Permission denied: You are not authorized to reject this request';
        }

        WriteBatch batch = _firestore.batch();
        batch.update(_firestore.collection('RegistrationRequests').doc(tempId), {
          'status': 'rejected',
          'password': FieldValue.delete(),
          'passwordHex': FieldValue.delete(),
          'rejectedTimestamp': FieldValue.serverTimestamp(),
        });
        batch.delete(_firestore.collection(requestRole == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers').doc(tempId));

        print('Committing batch write for rejectRequest, tempId: $tempId');
        await batch.commit();
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
        return;
      } catch (e) {
        print('Error rejecting request on attempt ${retryCount + 1}: $e');
        lastError = e as Exception;
        if (e.toString().contains('UNAVAILABLE') || e.toString().contains('UnknownHostException')) {
          retryCount++;
          await Future.delayed(Duration(seconds: 2));
          continue;
        }
        Get.snackbar(
          'Error',
          'Failed to reject request: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
        );
        throw e;
      }
    }
    print('Max retries reached for rejectRequest: $lastError');
    throw lastError ?? Exception('Failed to reject request after $maxRetries attempts');
  }
}



