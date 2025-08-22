import 'package:adventure_app/core/utils/constant/app_labels.dart';
import 'package:adventure_app/core/utils/style/app_fonts.dart';
import 'package:adventure_app/themes/theme1/auth/forgot/view/create_new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class SignupVerificationController extends GetxController {
  RxList<TextEditingController> controllers = RxList.generate(4, (_) => TextEditingController());
  RxList<FocusNode> focusNodes = RxList.generate(4, (_) => FocusNode());

  RxString otp = ''.obs;
  RxInt resendTimer = 0.obs;
  late Timer timer;

  RxBool isOtpCorrect = true.obs;
  RxString messageText = ''.obs;
  RxBool showMessage = false.obs;
  Timer? messageTimer;

  // property to determine the flow type
  final bool isForgotPasswordFlow;

  SignupVerificationController({this.isForgotPasswordFlow = false});

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    if (timer.isActive) {
      timer.cancel();
    }
    if (messageTimer != null && messageTimer!.isActive) {
      messageTimer!.cancel();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void startTimer() {
    resendTimer.value = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value = resendTimer.value - 1;
      } else {
        timer.cancel();
      }
    });

    messageText.value = isForgotPasswordFlow
        ? "Password reset code sent successfully."
        : "Verification code sent successfully.";
    showMessage.value = true;
    if (messageTimer != null && messageTimer!.isActive) {
      messageTimer!.cancel();
    }
    messageTimer = Timer(const Duration(seconds: 5), () {
      showMessage.value = false;
    });
  }

  void showSuccessDialog() {
    RxBool isLoading = false.obs;
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                  "Verification Successful!",
                  style: TextStyle(
                    fontFamily: AppFonts.interBold,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  AppLabels.verifiedsuccessful,
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
                        Get.offNamed('/language');
                      } finally {
                        isLoading.value = false;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                      "Continue",
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

  void confirm() {
    if (otp.value.length == 4) {
      if (otp.value == '1234') {
        isOtpCorrect.value = true;
        showMessage.value = false;
        if (isForgotPasswordFlow) {
          Get.off(CreateNewPasswordScreen());
        } else {
          showSuccessDialog();
        }
      } else {
        isOtpCorrect.value = false;
        messageText.value = "Invalid Code";
        showMessage.value = true;
      }
    } else {
      isOtpCorrect.value = false;
      messageText.value = "Please enter the 4-digit code.";
      showMessage.value = true;
    }
  }

  void resendCode() {
    if (resendTimer.value == 0) {
      startTimer();
      for (var c in controllers) {
        c.clear();
      }
      otp.value = '';
      isOtpCorrect.value = true;
    }
  }
}
