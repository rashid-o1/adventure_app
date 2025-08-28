import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import '../../../../../../services/auth_service.dart';
import '../../verification/view/signup_verification.dart';

class SignupController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final idController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isRepeatPasswordVisible = false.obs;
  var isLoading = false.obs;
  var emailError = ''.obs;
  var idError = ''.obs;
  var passwordError = ''.obs;
  var repeatPasswordError = ''.obs;
  var selectedRole = ''.obs;

  final AuthService _authService = AuthService();

  @override
  void onInit() async {
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    selectedRole.value = prefs.getString('selectedRole') ?? '';
  }

  void validateInputs() {
    emailError.value = '';
    idError.value = '';
    passwordError.value = '';
    repeatPasswordError.value = '';

    if (usernameController.text.trim().isEmpty) {
      emailError.value = 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(usernameController.text.trim())) {
      emailError.value = 'Invalid email format';
    }

    if (idController.text.trim().isEmpty) {
      idError.value = selectedRole.value == 'TeamLeader' ? 'Admin ID is required' : 'Leader ID is required';
    } else if (!RegExp(r'^\d{7}$').hasMatch(idController.text.trim())) {
      idError.value = 'ID must be exactly 7 digits';
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password is required';
    } else if (passwordController.text.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
    }

    if (repeatPasswordController.text.isEmpty) {
      repeatPasswordError.value = 'Please repeat your password';
    } else if (repeatPasswordController.text != passwordController.text) {
      repeatPasswordError.value = 'Passwords do not match';
    }
  }

  Future<void> signup() async {
    validateInputs();
    if (emailError.value.isNotEmpty ||
        idError.value.isNotEmpty ||
        passwordError.value.isNotEmpty ||
        repeatPasswordError.value.isNotEmpty) {
      Get.snackbar(
        'Error',
        'Please fix the input errors',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
      return;
    }

    isLoading.value = true;
    try {
      // Generate random 7-digit signupId
      String signupId = Random().nextInt(9999999).toString().padLeft(7, '0');

      String? result = await _authService.signUp(
        email: usernameController.text.trim(),
        password: passwordController.text,
        name: '',
        countryCode: '',
        mobileNumber: '',
        id: idController.text.trim(),
        signupId: signupId,
        role: selectedRole.value,
      );

      if (result == null) {
        Get.offAll(() => const SignupVerificationScreen(title: 'Registration Request'));
        Get.snackbar(
          'Success',
          'Signup request submitted successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Error',
          result,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Signup failed: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    idController.dispose();
    super.onClose();
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// class SignupController extends GetxController {
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();
//   final repeatPasswordController = TextEditingController();
//   var isPasswordVisible = false.obs;
//   var isRepeatPasswordVisible = false.obs;
//
//   @override
//   void onClose() {
//     usernameController.dispose();
//     passwordController.dispose();
//     repeatPasswordController.dispose();
//     super.onClose();
//   }
// }