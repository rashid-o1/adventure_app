import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController splashController = Get.put(SplashController());
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: mq.width,
            height: mq.height,
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
          SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/appImages/splash.png',
                    width: mq.width * 0.45,
                    height: mq.width * 0.45,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: mq.height * 0.05,
                  child: Obx(() {
                    return splashController.isLoading.value
                        ? const SpinKitThreeBounce(
                      color: Colors.white,
                      size: 25.0,
                    )
                        : const SizedBox.shrink();
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import '../controller/splash_controller.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final SplashController splashController = Get.put(SplashController());
//
//     final mq = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           // 🔹 Background image full screen (including status bar)
//           Container(
//             width: mq.width,
//             height: mq.height,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/appImages/splash_back.png'),
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                   Colors.black54,
//                   BlendMode.darken,
//                 ),
//               ),
//             ),
//           ),
//
//           // 🔹 Foreground content inside SafeArea
//           SafeArea(
//             child: Stack(
//               children: [
//                 // Center splash logo
//                 Center(
//                   child: Image.asset(
//                     'assets/images/appImages/splash.png',
//                     width: mq.width * 0.45,
//                     height: mq.width * 0.45,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//
//                 // Loading indicator at bottom
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   bottom: mq.height * 0.05,
//                   child: Obx(() {
//                     return splashController.isLoading.value
//                         ? const SpinKitThreeBounce(
//                       color: Colors.white,
//                       size: 25.0,
//                     )
//                         : const SizedBox.shrink();
//                   }),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
