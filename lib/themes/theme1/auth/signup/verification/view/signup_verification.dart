import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/constant/app_labels.dart';
import '../../../../../../core/utils/style/app_colors.dart';
import '../../../../../../core/utils/style/app_fonts.dart';
import '../controller/signup_verification_controller.dart';

class SignupVerificationScreen extends StatelessWidget {
  final String title;
  final bool isForgotPasswordFlow;

  const SignupVerificationScreen({
    super.key,
    required this.title,
    this.isForgotPasswordFlow = false,
  });

  @override
  Widget build(BuildContext context) {
    // argument
    final SignupVerificationController controller = Get.put(
      SignupVerificationController(isForgotPasswordFlow: isForgotPasswordFlow),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    for (var c in controller.controllers) {
                      c.clear();
                    }
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: AppFonts.interBold,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  AppLabels.verificationPrompt,
                  style: const TextStyle(
                    fontFamily: AppFonts.interRegular,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),
                // OTP input fields...
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: controller.isOtpCorrect.value ? Colors.transparent : Colors.red,
                          width: 2.0,
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          controller: controller.controllers[index],
                          focusNode: controller.focusNodes[index],
                          onChanged: (value) {
                            if (value.length == 1) {
                              if (index < 3) {
                                controller.focusNodes[index + 1].requestFocus();
                              } else {
                                controller.focusNodes[index].unfocus();
                              }
                            }
                            String currentOtp = "";
                            for (var c in controller.controllers) {
                              currentOtp += c.text;
                            }
                            controller.otp.value = currentOtp;
                            controller.isOtpCorrect.value = true;
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                          ),
                        ),
                      ),
                    );
                  }),
                )),
                const SizedBox(height: 5),
                Obx(() => controller.showMessage.value
                    ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    controller.messageText.value,
                    style: TextStyle(
                      color: controller.isOtpCorrect.value ? Colors.green : Colors.red,
                    ),
                  ),
                )
                    : const SizedBox.shrink()),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't receive the code?",
                        style: TextStyle(
                          fontFamily: AppFonts.interRegular,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Obx(() {
                        if (controller.resendTimer.value > 0) {
                          return Text(
                            "You can resend code in ${controller.resendTimer.value} s",
                            style: const TextStyle(
                              fontFamily: AppFonts.interRegular,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          );
                        } else {
                          return TextButton(
                            onPressed: controller.resendCode,
                            child: const Text(
                              "Resend",
                              style: TextStyle(
                                fontFamily: AppFonts.interBold,
                                color: AppColors.black,
                              ),
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.confirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: const Text(
                    "Confirm",
                    style: TextStyle(
                      fontFamily: AppFonts.interBold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
