import 'package:get/get.dart';

class SplashController extends GetxController {
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _navigateToSelectionScreen();
  }

  void _navigateToSelectionScreen() async {
    // Ensure the loading indicator shows for at least 2 seconds.
    await Future.delayed(const Duration(seconds: 2));

    // After the minimum duration, you can perform any other async tasks
    // like fetching data, etc., if needed.
    await Future.delayed(const Duration(seconds: 3));

    isLoading.value = false;
    Get.offNamed('/selection'); // Navigate to the new selection screen route
  }

  @override
  void onClose() {
    super.onClose();
  }
}