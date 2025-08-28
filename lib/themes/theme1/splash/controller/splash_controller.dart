import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

      if (isFirstTime) {
        print('First time launch, signing out and navigating to SelectionScreen');
        // Clear any existing Firebase Auth session
        await _authService.signOut();
        // Reset SharedPreferences
        await prefs.setBool('isFirstTime', false);
        await prefs.remove('selectedRole');
        Get.offAllNamed('/selection');
        return;
      }

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print('User is logged in: ${user.uid}');
        String? role = await _authService.getUserRole(user.uid);
        if (role != null) {
          String normalizedRole = role.toLowerCase() == 'admin' ? 'admin' : role;
          print('Role found: $normalizedRole');
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
          print('No role found, navigating to SelectionScreen');
          Get.offAllNamed('/selection');
        }
      } else {
        print('No user logged in, navigating to SelectionScreen');
        Get.offAllNamed('/selection');
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