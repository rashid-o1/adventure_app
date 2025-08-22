import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController splashController = Get.put(SplashController());

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Background image with dull effect
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/appImages/splash_back.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black54,
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          // Centered splash image with clear visibility
          Center(
            child: Image.asset(
              'assets/images/appImages/splash.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
              colorBlendMode: BlendMode.dst,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Obx(() {
              return splashController.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const SizedBox.shrink();
            }),
          ),
        ],
      ),
    );
  }
}