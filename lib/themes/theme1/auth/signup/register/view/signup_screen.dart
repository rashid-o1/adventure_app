import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/constant/app_labels.dart';
import '../../../../../core/utils/style/app_colors.dart';
import '../../../../../core/utils/style/app_fonts.dart';
import '../controller/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.put(SignupController());
    final RxBool isRemembered = false.obs; // Manage checkbox state directly

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
                    Get.back();
                  }
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      AppLabels.helloThere,
                      style: const TextStyle(
                        fontFamily: AppFonts.interBold,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  AppLabels.pleaseEnterCredentials,
                  style: const TextStyle(
                    fontFamily: AppFonts.interRegular,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Username/Email",
                  style: TextStyle(
                    fontFamily: AppFonts.interBold,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8), // Space between text and textfield
                TextField(
                  controller: controller.usernameController,
                  decoration: const InputDecoration(
                    hintText: 'e.g ... yourmail@yourdomain.com',
                    hintStyle: TextStyle(
                      fontFamily: AppFonts.interRegular,
                      color: Colors.grey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Password",
                  style: TextStyle(
                    fontFamily: AppFonts.interBold,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8), // Space between text and textfield
                Obx(() => TextField(
                  controller: controller.passwordController,
                  obscureText: !controller.isPasswordVisible.value,
                  decoration: InputDecoration(
                    hintText: 'Enter password',
                    hintStyle: const TextStyle(
                      fontFamily: AppFonts.interRegular,
                      color: Colors.grey,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        controller.isPasswordVisible.toggle();
                      },
                    ),
                  ),
                )),
                const SizedBox(height: 20),
                const Text(
                  "Repeat Password",
                  style: TextStyle(
                    fontFamily: AppFonts.interBold,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8), // Space between text and textfield
                Obx(() => TextField(
                  controller: controller.repeatPasswordController,
                  obscureText: !controller.isRepeatPasswordVisible.value, // Assuming a second visibility state
                  decoration: InputDecoration(
                    hintText: 'Enter password again',
                    hintStyle: const TextStyle(
                      fontFamily: AppFonts.interRegular,
                      color: Colors.grey,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isRepeatPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        controller.isRepeatPasswordVisible.toggle();
                      },
                    ),
                  ),
                )),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Obx(() => Checkbox(
                      value: isRemembered.value,
                      activeColor: AppColors.black,
                      onChanged: (value) {
                        isRemembered.value = value ?? false;
                      },
                    )),
                    const Text(
                      AppLabels.rememberMe,
                      style: TextStyle(
                        fontFamily: AppFonts.interRegular,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                /// Divider with text
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("or continue with"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _socialButton("assets/images/google.png"),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _socialButton("assets/images/apple.png"),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _socialButton("assets/images/fb.png"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontFamily: AppFonts.interBold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLabels.signInPrompt,
                      style: const TextStyle(
                        fontFamily: AppFonts.interRegular,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offNamed('/login');
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontFamily: AppFonts.interBold,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Social Button Widget
  Widget _socialButton(String assetPath) {
    return Container(
      height: 50,
      child: Center(
        child: Image.asset(
          assetPath,
          height: 28,
        ),
      ),
    );
  }
}