import 'package:adventure_app/core/utils/style/app_colors.dart';
import 'package:adventure_app/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/forgot_password_controller.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController controller = Get.find();

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
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Text(
                      "Create New Password ",
                      style: TextStyle(
                        fontFamily: AppFonts.interBold,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.lock),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter your new password. If you forget it, then you have to do forgot password.",
                  style: TextStyle(
                    fontFamily: AppFonts.interRegular,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),
                // Password Text Field
                const Text("Password", style: TextStyle(fontFamily: AppFonts.interRegular, fontSize: 16)),
                const SizedBox(height: 8),
                Obx(() => TextField(
                  controller: controller.passwordController,
                  obscureText: !controller.showPassword.value,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.showPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        controller.showPassword.value = !controller.showPassword.value;
                      },
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                )),
                const SizedBox(height: 20),
                //confirm password
                const Text("Repeat Password", style: TextStyle(fontFamily: AppFonts.interRegular, fontSize: 16)),
                const SizedBox(height: 8),
                Obx(() => TextField(
                  controller: controller.repeatPasswordController,
                  obscureText: !controller.showRepeatPassword.value,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.showRepeatPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        controller.showRepeatPassword.value = !controller.showRepeatPassword.value;
                      },
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                )),
                const SizedBox(height: 20),
                // Remember Me Checkbox
                Row(
                  children: [
                    Obx(() => Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (bool? newValue) {
                        controller.rememberMe.value = newValue!;
                      },
                      activeColor: Colors.black,
                    )),
                    const Text("Remember me", style: TextStyle(fontFamily: AppFonts.interRegular, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 30),

                // continue btton
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.onContinuePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    child: Obx(() => controller.isLoading.value
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
                      style: TextStyle(
                        fontFamily: AppFonts.interBold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )),
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