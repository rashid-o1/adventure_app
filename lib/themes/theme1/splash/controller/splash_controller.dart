import 'package:get/get.dart';

class SplashController extends GetxController {
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _navigateToSelectionScreen();
  }

  void _navigateToSelectionScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    isLoading.value = false;
    Get.offNamed('/selection'); // Navigate to the new selection screen route
  }

  @override
  void onClose() {
    super.onClose();
  }
}