import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/style/app_fonts.dart';
import '../../../../../../core/utils/style/app_colors.dart';
import '../controller/signup_verification_controller.dart';

class SignupVerificationScreen extends StatelessWidget {
  final String title;

  const SignupVerificationScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    // Check if controller exists, fallback if not
    SignupVerificationController? controller;
    try {
      controller = Get.find<SignupVerificationController>(tag: 'signup_verification');
      print('SignupVerificationController found with tag: signup_verification');
    } catch (e) {
      print('Error finding SignupVerificationController: $e');
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                size: width * 0.15,
                color: Colors.red,
              ),
              SizedBox(height: height * 0.02),
              Text(
                'Error loading verification. Please try again.',
                style: TextStyle(
                  fontFamily: AppFonts.interBold,
                  fontSize: width * 0.045,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.02),
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed('/selection');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: height * 0.015),
                ),
                child: Text(
                  'Go Back',
                  style: TextStyle(
                    fontFamily: AppFonts.interBold,
                    fontSize: width * 0.04,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          title,
          style: TextStyle(
            fontFamily: AppFonts.interBold,
            fontSize: width * 0.055,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: Obx(() {
            if (controller!.status.value == 'pending') {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.hourglass_empty,
                    size: width * 0.15,
                    color: Colors.grey,
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    'Your request is submitted. Please wait up to 30 minutes.',
                    style: TextStyle(
                      fontFamily: AppFonts.interRegular,
                      fontSize: width * 0.04,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            } else if (controller.status.value == 'approved') {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: width * 0.15,
                    color: Colors.green,
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    'Registration Approved by ${controller.role.value == 'TeamLeader' ? 'Admin' : 'Team Leader'}',
                    style: TextStyle(
                      fontFamily: AppFonts.interBold,
                      fontSize: width * 0.045,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: height * 0.015),
                    ),
                    child: Text(
                      'Proceed',
                      style: TextStyle(
                        fontFamily: AppFonts.interBold,
                        fontSize: width * 0.04,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            } else if (controller.status.value == 'rejected') {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cancel,
                    size: width * 0.15,
                    color: Colors.red,
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    'Registration Rejected',
                    style: TextStyle(
                      fontFamily: AppFonts.interBold,
                      fontSize: width * 0.045,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed('/selection');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: height * 0.015),
                    ),
                    child: Text(
                      'Go Back',
                      style: TextStyle(
                        fontFamily: AppFonts.interBold,
                        fontSize: width * 0.04,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: width * 0.15,
                    color: Colors.red,
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    'Request not found. Please try signing up again.',
                    style: TextStyle(
                      fontFamily: AppFonts.interBold,
                      fontSize: width * 0.045,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed('/selection');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: height * 0.015),
                    ),
                    child: Text(
                      'Go Back',
                      style: TextStyle(
                        fontFamily: AppFonts.interBold,
                        fontSize: width * 0.04,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}