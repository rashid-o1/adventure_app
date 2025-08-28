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
    final SignupVerificationController controller = Get.put(
      SignupVerificationController(isForgotPasswordFlow: isForgotPasswordFlow),
    );
    final mq = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => controller.status.value != 'pending', // Disable back button when pending
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false, // Remove default back button
          actions: [
            if (controller.status.value != 'pending')
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  if (controller.status.value == 'rejected') {
                    Get.offAllNamed('/selection');
                  } else if (controller.status.value == 'approved') {
                    Get.offAllNamed('/login');
                  }
                },
              ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: AppFonts.interBold,
                      fontSize: mq.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Obx(() => Column(
                    children: [
                      Icon(
                        controller.status.value == 'pending'
                            ? Icons.hourglass_empty
                            : controller.status.value == 'approved'
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: controller.status.value == 'pending'
                            ? Colors.grey
                            : controller.status.value == 'approved'
                            ? Colors.green
                            : Colors.red,
                        size: mq.width * 0.15,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        controller.status.value == 'pending'
                            ? 'Your request is submitted.\nPlease wait up to 30 minutes.'
                            : controller.status.value == 'approved'
                            ? 'Registration Approved by ${controller.selectedRole.value == 'TeamLeader' ? 'Admin' : 'Team Leader'}'
                            : 'Registration Rejected',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppFonts.interRegular,
                          fontSize: mq.width * 0.045,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(height: 40),
                  Obx(() => controller.status.value == 'pending'
                      ? const SizedBox.shrink()
                      : ElevatedButton(
                    onPressed: () {
                      if (controller.status.value == 'approved') {
                        Get.offAllNamed('/login');
                      } else if (controller.status.value == 'rejected') {
                        Get.offAllNamed('/selection');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.status.value == 'approved' ? Colors.green : AppColors.black,
                      minimumSize: Size(mq.width * 0.6, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      controller.status.value == 'approved' ? 'Proceed' : 'Go Back',
                      style: TextStyle(
                        fontFamily: AppFonts.interBold,
                        color: Colors.white,
                        fontSize: mq.width * 0.045,
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}