import 'package:adventure_app/themes/theme1/auth/forgot/view/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/utils/constant/app_labels.dart';
import '../../../../../core/utils/style/app_colors.dart';
import '../../../../../core/utils/style/app_fonts.dart';
import '../controller/login_controller.dart';// Ensure this import exists or update path

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate controller only if not already present
    final LoginController controller = Get.put(LoginController(), permanent: true);
    final RxBool isRemembered = false.obs;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                /// Heading
                Row(
                  children: [
                    Text(
                      AppLabels.helloThere,
                      style: const TextStyle(
                        fontFamily: AppFonts.interBold,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  AppLabels.pleaseEnterCredentials,
                  style: const TextStyle(
                    fontFamily: AppFonts.interRegular,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),

                /// Username Field
                const Text(
                  AppLabels.usernameEmail,
                  style: TextStyle(
                    fontFamily: AppFonts.interBold,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => TextField(
                  controller: controller.usernameController,
                  decoration: InputDecoration(
                    hintText: AppLabels.emailhint,
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
                    errorText: controller.emailError.value.isEmpty ? null : controller.emailError.value,
                  ),
                  enabled: !controller.isLoading.value, // Disable during loading
                )),
                const SizedBox(height: 20),

                /// Password Field
                const Text(
                  AppLabels.password,
                  style: TextStyle(
                    fontFamily: AppFonts.interBold,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => TextField(
                  controller: controller.passwordController,
                  obscureText: !controller.isPasswordVisible.value,
                  decoration: InputDecoration(
                    hintText: AppLabels.passwordhint,
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
                    errorText: controller.passwordError.value.isEmpty ? null : controller.passwordError.value,
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
                  enabled: !controller.isLoading.value, // Disable during loading
                )),

                const SizedBox(height: 10),

                /// Remember me
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
                const SizedBox(height: 5),

                /// Forgot Password
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                    },
                    child: const Text(
                      AppLabels.forgotPassword,
                      style: TextStyle(
                        fontFamily: AppFonts.interBold,
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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

                /// Social Buttons
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

                /// Sign In Button
                Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                    controller.login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "Sign In",
                    style: TextStyle(
                      fontFamily: AppFonts.interBold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )),
                const SizedBox(height: 20),

                /// Sign Up prompt (Hide for Admin)
                Obx(() => controller.selectedRole.value != 'admin'
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      AppLabels.signUpPrompt,
                      style: TextStyle(
                        fontFamily: AppFonts.interRegular,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/signup");
                      },
                      child: Text(
                        " Sign up",
                        style: TextStyle(
                          fontFamily: AppFonts.interBold,
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
                    : const SizedBox.shrink()),
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

// import 'package:adventure_app/themes/theme1/auth/forgot/view/forgot_password_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../core/utils/constant/app_labels.dart';
// import '../../../../../core/utils/style/app_colors.dart';
// import '../../../../../core/utils/style/app_fonts.dart';
// import '../controller/login_controller.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final LoginController controller = Get.put(LoginController());
//     final RxBool isRemembered = false.obs; // manage checkbox state
//
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 50),
//
//                 /// Heading
//                 Row(
//                   children: [
//                     Text(
//                       AppLabels.helloThere,
//                       style: const TextStyle(
//                         fontFamily: AppFonts.interBold,
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   AppLabels.pleaseEnterCredentials,
//                   style: const TextStyle(
//                     fontFamily: AppFonts.interRegular,
//                     fontSize: 15,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//
//                 /// Username Field
//                 const Text(
//                    AppLabels.usernameEmail,
//                   style: TextStyle(
//                     fontFamily: AppFonts.interBold,
//                     color: AppColors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: controller.usernameController,
//                   decoration: const InputDecoration(
//                     hintText: AppLabels.emailhint,
//                     hintStyle: TextStyle(
//                       fontFamily: AppFonts.interRegular,
//                       color: Colors.grey,
//                     ),
//                     enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                     ),
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black, width: 2),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 /// Password Field
//                 const Text(
//                   AppLabels.password,
//                   style: TextStyle(
//                     fontFamily: AppFonts.interBold,
//                     color: AppColors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Obx(() => TextField(
//                   controller: controller.passwordController,
//                   obscureText: !controller.isPasswordVisible.value,
//                   decoration: InputDecoration(
//                     hintText: AppLabels.passwordhint,
//                     hintStyle: const TextStyle(
//                       fontFamily: AppFonts.interRegular,
//                       color: Colors.grey,
//                     ),
//                     enabledBorder: const UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                     ),
//                     focusedBorder: const UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black, width: 2),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         controller.isPasswordVisible.value
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: Colors.black,
//                       ),
//                       onPressed: () {
//                         controller.isPasswordVisible.toggle();
//                       },
//                     ),
//                   ),
//                 )),
//
//                 const SizedBox(height: 10),
//
//                 /// Remember me
//                 Row(
//                   children: [
//                     Obx(() => Checkbox(
//                       value: isRemembered.value,
//                       activeColor: AppColors.black,
//                       onChanged: (value) {
//                         isRemembered.value = value ?? false;
//                       },
//                     )),
//                     const Text(
//                       AppLabels.rememberMe,
//                       style: TextStyle(
//                         fontFamily: AppFonts.interRegular,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//
//                 /// Forgot Password
//                 Align(
//                   alignment: Alignment.center,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
//
//                     },
//                     child: const Text(
//                       AppLabels.forgotPassword,
//                       style: TextStyle(
//                         fontFamily: AppFonts.interBold,
//                         color: AppColors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//
//                 /// Divider with text
//                 Row(
//                   children: const [
//                     Expanded(child: Divider()),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8),
//                       child: Text("or continue with"),
//                     ),
//                     Expanded(child: Divider()),
//                   ],
//                 ),
//                 const SizedBox(height: 15),
//
//                 /// Social Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: _socialButton("assets/images/google.png"),
//                     ),
//                     const SizedBox(width: 15),
//                     Expanded(
//                       child: _socialButton("assets/images/apple.png"),
//                     ),
//                     const SizedBox(width: 15),
//                     Expanded(
//                       child: _socialButton("assets/images/fb.png"),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//
//                 /// Sign In Button
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     minimumSize: const Size(double.infinity, 55),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: const Text(
//                     "Sign In",
//                     style: TextStyle(
//                       fontFamily: AppFonts.interBold,
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 /// Sign Up prompt
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       AppLabels.signUpPrompt,
//                       style: TextStyle(
//                         fontFamily: AppFonts.interRegular,
//                         fontSize: 14,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Get.toNamed("/signup");
//                       },
//                       child: Text(
//                         " Sign up",
//                         style: TextStyle(
//                           fontFamily: AppFonts.interBold,
//                           color: AppColors.black,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// Social Button Widget
//   Widget _socialButton(String assetPath) {
//     return Container(
//       height: 50,
//       child: Center(
//         child: Image.asset(
//           assetPath,
//           height: 28,
//         ),
//       ),
//     );
//   }
// }