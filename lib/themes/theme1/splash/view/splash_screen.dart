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
          Center(
            child:Image.asset('assets/images/appImages/splash.png',
                width: MediaQuery.of(context).size.width,
                height: 300,
                fit: BoxFit.contain,)
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