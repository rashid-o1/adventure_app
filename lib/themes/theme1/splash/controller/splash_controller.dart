import 'package:get/get.dart';

class SplashController extends GetxController {
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 10));
    isLoading.value = false; // Update the observable
    Get.offNamed('/login'); // Replace '/login' with your login route
  }

  @override
  void onClose() {
    super.onClose();
  }
}