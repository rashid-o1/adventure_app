import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/utils/constant/app_labels.dart';
import '../../../../../../core/utils/style/app_colors.dart';
import '../../../../../../core/utils/style/app_fonts.dart';
import '../controller/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.put(SignupController());
    final RxBool isRemembered = false.obs;

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
                  AppLabels.usernameEmail,
                  style: TextStyle(
                    fontFamily: AppFonts.interBold,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
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
                ),
                const SizedBox(height: 20),
                Obx(() => Text(
                  controller.selectedRole.value == 'TeamLeader' ? 'Admin ID' : 'Leader ID',
                  style: const TextStyle(
                    fontFamily: AppFonts.interBold,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )),
                const SizedBox(height: 8),
                TextField(
                  controller: controller.idController,
                  keyboardType: TextInputType.number,
                  maxLength: 7,
                  decoration: InputDecoration(
                    hintText: controller.selectedRole.value == 'TeamLeader' ? 'Enter 7-digit Admin ID' : 'Enter 7-digit Leader ID',
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
                    errorText: controller.idError.value.isEmpty ? null : controller.idError.value,
                  ),
                ),
                const SizedBox(height: 20),
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
                        controller.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
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
                  AppLabels.repeatPassword,
                  style: TextStyle(
                    fontFamily: AppFonts.interBold,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => TextField(
                  controller: controller.repeatPasswordController,
                  obscureText: !controller.isRepeatPasswordVisible.value,
                  decoration: InputDecoration(
                    hintText: AppLabels.repeatpasswordhint,
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
                    errorText: controller.repeatPasswordError.value.isEmpty ? null : controller.repeatPasswordError.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isRepeatPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
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
                Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                    controller.signup();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontFamily: AppFonts.interBold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )),
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


// import 'package:adventure_app/themes/theme1/auth/signup/verification/view/signup_otp_verification.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../../core/utils/constant/app_labels.dart';
// import '../../../../../../core/utils/style/app_colors.dart';
// import '../../../../../../core/utils/style/app_fonts.dart';
// import '../controller/signup_controller.dart';
//
// class SignupScreen extends StatelessWidget {
//   const SignupScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final SignupController controller = Get.put(SignupController());
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
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   }
//                 ),
//                 const SizedBox(height: 15),
//                 Row(
//                   children: [
//                     Text(
//                       AppLabels.helloThere,
//                       style: const TextStyle(
//                         fontFamily: AppFonts.interBold,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   AppLabels.pleaseEnterCredentials,
//                   style: const TextStyle(
//                     fontFamily: AppFonts.interRegular,
//                     fontSize: 16,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 const Text(
//                   AppLabels.usernameEmail,
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
//                 const SizedBox(height: 20),
//                 const Text(
//                   AppLabels.repeatPassword,
//                   style: TextStyle(
//                     fontFamily: AppFonts.interBold,
//                     color: AppColors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Obx(() => TextField(
//                   controller: controller.repeatPasswordController,
//                   obscureText: !controller.isRepeatPasswordVisible.value,
//                   decoration: InputDecoration(
//                     hintText: AppLabels.repeatpasswordhint,
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
//                         controller.isRepeatPasswordVisible.value
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: Colors.black,
//                       ),
//                       onPressed: () {
//                         controller.isRepeatPasswordVisible.toggle();
//                       },
//                     ),
//                   ),
//                 )),
//                 const SizedBox(height: 10),
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
//                 ElevatedButton(
//                   onPressed: () {
//                   //  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupVerificationScreen()));
//                    Get.to(SignupVerificationScreen(title: AppLabels.verificationTitle,));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.black,
//                     minimumSize: const Size(double.infinity, 55),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       AppLabels.signInPrompt,
//                       style: const TextStyle(
//                         fontFamily: AppFonts.interRegular,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Get.offNamed('/login');
//                       },
//                       child: Text(
//                         "Sign In",
//                         style: TextStyle(
//                           fontFamily: AppFonts.interBold,
//                           color: AppColors.black,
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