import 'package:adventure_app/core/utils/constant/app_labels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/style/app_fonts.dart';
import '../controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController controller = Get.put(ForgotPasswordController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                   AppLabels.forgotPass,
                    style: const TextStyle(
                      fontFamily: AppFonts.interBold,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ],
              ),
              const SizedBox(height: 10),
              const Text(
                AppLabels.enteremail,
                style: TextStyle(
                  fontFamily: AppFonts.interRegular,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                AppLabels.Email,
                style: TextStyle(
                  fontFamily: AppFonts.interRegular,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              // Email input field
              Obx(() => TextField(
                controller: controller.emailController,
                onChanged: (value) => controller.isEmailValid.value = true,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontFamily: AppFonts.interRegular,
                ),
                decoration: InputDecoration(
                  hintText: AppLabels.emailhint,
                  hintStyle: TextStyle(
                    fontFamily: AppFonts.interRegular,
                    color: Colors.grey,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: controller.isEmailValid.value ? Colors.black54 : Colors.red,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: controller.isEmailValid.value ? Colors.black54 : Colors.red,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: controller.isEmailValid.value ? Colors.black : Colors.red,
                      width: 2.0,
                    ),
                  ),
                ),
              )),
              const Spacer(),
              // Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.continueProcess,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontFamily: AppFonts.interBold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
