import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../services/auth_service.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var selectedRole = ''.obs;

  final AuthService _authService = AuthService();

  @override
  void onInit() async {
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    selectedRole.value = prefs.getString('selectedRole') ?? 'admin'; // Fallback to 'Admin' if unset
    print('LoginController initialized with role: ${selectedRole.value}');
  }

  void validateInputs() {
    emailError.value = '';
    passwordError.value = '';

    if (usernameController.text.trim().isEmpty) {
      emailError.value = 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(usernameController.text.trim())) {
      emailError.value = 'Invalid email format';
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password is required';
    } else if (passwordController.text.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
    }
  }

  Future<void> login() async {
    validateInputs();
    if (emailError.value.isNotEmpty || passwordError.value.isNotEmpty) {
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
      String? result = await _authService.signIn(
        email: usernameController.text.trim(),
        password: passwordController.text,
        role: selectedRole.value,
      );
      if (result == null) {
        // Show success Snackbar
        Get.snackbar(
          'Success',
          'Logged in successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          duration: const Duration(seconds: 2),
        );
        // Delay navigation slightly to ensure Snackbar is visible
        await Future.delayed(const Duration(seconds: 2));
        String normalizedRole = selectedRole.value.toLowerCase() == 'admin' ? 'admin' : selectedRole.value;
        switch (normalizedRole) {
          case 'admin':
            Get.offAllNamed('/superAdminHome');
            break;
          case 'TeamLeader':
            Get.offAllNamed('/teamLeaderDashboard');
            break;
          case 'TeamMember':
            Get.offAllNamed('/teamMemberDashboard');
            break;
        }
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
        'Login failed: $e',
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
    super.onClose();
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// class LoginController extends GetxController {
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();
//   var isPasswordVisible = false.obs;
//
//   @override
//   void onClose() {
//     usernameController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
// }