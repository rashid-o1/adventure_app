import 'package:adventure_app/core/utils/constant/app_labels.dart';
import 'package:adventure_app/themes/theme1/auth/signup/verification/view/signup_verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adventure_app/core/utils/style/app_fonts.dart';

class ForgotPasswordController extends GetxController {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();

  RxBool isEmailValid = true.obs;
  RxBool isLoading = false.obs;
  RxBool showPassword = false.obs;
  RxBool showRepeatPassword = false.obs;
  RxBool rememberMe = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.onClose();
  }

  void showSuccessDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 50),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Reset Password Successful!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFonts.interBold,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your password has been successfully changed.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFonts.interRegular,
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      isLoading.value = true;
                      try {
                        await Future.delayed(const Duration(seconds: 1));
                        Get.back();
                        Get.offAllNamed('/');
                      } finally {
                        isLoading.value = false;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: isLoading.value
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      "Go back to home",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  // Validates email , handles the "Continue" button logic
  void continueProcess() {
    final email = emailController.text.trim();
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      isEmailValid.value = false;
      Get.snackbar(
        "Error",
        "Please enter a valid email address.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      isEmailValid.value = true;
      print("Sending OTP to: $email");
      Get.snackbar(
        "Success",
        "OTP has been sent to your email.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );

      // Clear the email field before navigating
      emailController.clear();

      Get.to(SignupVerificationScreen(title: AppLabels.mailed, isForgotPasswordFlow: true,));
    }
  }


  //continuw password
  void onContinuePassword() {
    showSuccessDialog();
  }
}