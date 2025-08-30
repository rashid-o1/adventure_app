import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../services/auth_service.dart';

class SplashController extends GetxController {
  final isLoading = true.obs;
  final AuthService _authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    _navigateBasedOnState();
  }

  Future<void> _navigateBasedOnState() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      final prefs = await SharedPreferences.getInstance();
      String? selectedRole = prefs.getString('selectedRole');
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print('No user logged in, navigating to SelectionScreen');
        Get.offAllNamed('/selection');
        return;
      }

      print('User is logged in: ${user.uid}');
      String? userRole = selectedRole ?? await _authService.getUserRole(user.uid);
      if (userRole == null) {
        print('No role found, navigating to SelectionScreen');
        Get.offAllNamed('/selection');
        return;
      }

      bool isApproved = await _authService.isUserApproved(user.uid, userRole);
      if (!isApproved) {
        print('User is not approved, navigating to SelectionScreen');
        Get.offAllNamed('/selection');
        return;
      }

      String normalizedRole = userRole.toLowerCase() == 'admin' ? 'admin' : userRole;
      print('Role found and approved: $normalizedRole');
      await prefs.setString('selectedRole', normalizedRole);
      await prefs.setBool('isFirstTime', false); // Set isFirstTime to false after successful role check
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
    } catch (e) {
      print('Error in SplashController: $e');
      Get.snackbar(
        'Error',
        'Failed to initialize: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
      Get.offAllNamed('/selection');
    } finally {
      isLoading.value = false;
    }
  }
}

// import 'package:get/get.dart';
//
// class SplashController extends GetxController {
//   final isLoading = true.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _navigateToSelectionScreen();
//   }
//
//   void _navigateToSelectionScreen() async {
//     // Ensure the loading indicator shows for at least 2 seconds.
//     await Future.delayed(const Duration(seconds: 2));
//
//     // After the minimum duration, you can perform any other async tasks
//     // like fetching data, etc., if needed.
//     await Future.delayed(const Duration(seconds: 3));
//
//     isLoading.value = false;
//     Get.offNamed('/selection'); // Navigate to the new selection screen route
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
// }