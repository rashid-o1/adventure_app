import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupVerificationController extends GetxController {
  var status = 'pending'.obs;
  var selectedRole = ''.obs;
  final bool isForgotPasswordFlow;

  SignupVerificationController({this.isForgotPasswordFlow = false});

  @override
  void onInit() async {
    super.onInit();
    if (!isForgotPasswordFlow) {
      final prefs = await SharedPreferences.getInstance();
      selectedRole.value = prefs.getString('selectedRole') ?? '';
      _listenToRegistrationStatus();
    }
  }

  void _listenToRegistrationStatus() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('RegistrationRequests').doc(uid).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        status.value = snapshot.data()!['status'] ?? 'pending';
        print('Registration status updated: ${status.value}');
      } else {
        status.value = 'pending';
        print('No registration request found for UID: $uid');
      }
    }, onError: (e) {
      print('Error listening to registration status: $e');
      Get.snackbar(
        'Error',
        'Failed to fetch registration status: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}