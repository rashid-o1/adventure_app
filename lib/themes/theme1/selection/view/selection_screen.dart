import 'package:adventure_app/core/utils/constant/app_labels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adventure_app/themes/theme1/selection/controller/selection_controller.dart';
import '../../../../core/utils/style/app_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectionController());
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
            child: Container(
              width: mq.width,
              height: mq.height,
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: mq.height * 0.12),
                  Text(
                    '${AppLabels.helloThere} 👋',
                    style: TextStyle(
                      fontFamily: AppFonts.interBold,
                      color: Colors.white,
                      fontSize: mq.width * 0.075,
                    ),
                  ),
                  SizedBox(height: mq.height * 0.01),
                  Text(
                    'Please Select who you are using 4x4 Adventures.',
                    style: TextStyle(
                      fontFamily: AppFonts.interRegular,
                      color: Colors.white70,
                      fontSize: mq.width * 0.04,
                    ),
                  ),
                  const Spacer(),
                  _buildSelectionButton(
                    context,
                    controller,
                    0,
                    AppLabels.adminselectionbtntext,
                    'admin',
                    '/login',
                  ),
                  SizedBox(height: mq.height * 0.015),
                  _buildSelectionButton(
                    context,
                    controller,
                    1,
                    AppLabels.teamleadbtntext,
                    'TeamLeader',
                    '/login',
                  ),
                  SizedBox(height: mq.height * 0.015),
                  _buildSelectionButton(
                    context,
                    controller,
                    2,
                    AppLabels.teammemberbtntext,
                    'TeamMember',
                    '/login',
                  ),
                  SizedBox(height: mq.height * 0.08),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionButton(
      BuildContext context,
      SelectionController controller,
      int index,
      String text,
      String role,
      String routeName,
      ) {
    final mq = MediaQuery.of(context).size;

    return Obx(() {
      final isLoading = controller.loadingStates[index].value;
      return Center(
        child: SizedBox(
          width: mq.width * 0.65,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isLoading ? Colors.transparent : Colors.white,
              padding: EdgeInsets.symmetric(vertical: mq.height * 0.012),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(mq.width * 0.09),
                side: isLoading
                    ? const BorderSide(color: Colors.white, width: 2)
                    : BorderSide.none,
              ),
            ),
            onPressed: () => controller.handleButtonTap(index, role, routeName),
            child: isLoading
                ? SizedBox(
              width: mq.width * 0.05,
              height: mq.width * 0.05,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
                : Text(
              text,
              style: TextStyle(
                fontFamily: AppFonts.interMedium,
                color: isLoading ? Colors.white : Colors.black,
                fontSize: mq.width * 0.04,
              ),
            ),
          ),
        ),
      );
    });
  }
}

// import 'package:adventure_app/core/utils/constant/app_labels.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:adventure_app/themes/theme1/selection/controller/selection_controller.dart';
// import '../../../../core/utils/style/app_fonts.dart';
//
// class SelectionScreen extends StatelessWidget {
//   const SelectionScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(SelectionController());
//     final mq = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           // 🔹 Background full screen (SafeArea ke bahar)
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
//           // 🔹 Foreground content SafeArea ke andar
//           SafeArea(
//             child: Container(
//               width: mq.width,
//               height: mq.height,
//               padding: EdgeInsets.symmetric(horizontal: mq.width * 0.06),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: mq.height * 0.12),
//                   Text(
//                     '${AppLabels.helloThere} 👋',
//                     style: TextStyle(
//                       fontFamily: AppFonts.interBold,
//                       color: Colors.white,
//                       fontSize: mq.width * 0.075,
//                     ),
//                   ),
//                   SizedBox(height: mq.height * 0.01),
//                   Text(
//                     'Please Select who you are using 4x4 Adventures.',
//                     style: TextStyle(
//                       fontFamily: AppFonts.interRegular,
//                       color: Colors.white70,
//                       fontSize: mq.width * 0.04,
//                     ),
//                   ),
//                   const Spacer(),
//
//                   // 🔹 Buttons
//                   _buildSelectionButton(
//                     context,
//                     controller,
//                     0,
//                     AppLabels.adminselectionbtntext,
//                     '/superAdminHome',
//                   ),
//                   SizedBox(height: mq.height * 0.015),
//
//                   _buildSelectionButton(
//                     context,
//                     controller,
//                     1,
//                     AppLabels.teamleadbtntext,
//                     '/login',
//                   ),
//                   SizedBox(height: mq.height * 0.015),
//
//                   _buildSelectionButton(
//                     context,
//                     controller,
//                     2,
//                     AppLabels.teammemberbtntext,
//                     '/login',
//                   ),
//                   SizedBox(height: mq.height * 0.08),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSelectionButton(
//       BuildContext context,
//       SelectionController controller,
//       int index,
//       String text,
//       String routeName,
//       ) {
//     final mq = MediaQuery.of(context).size;
//
//     return Obx(() {
//       final isLoading = controller.loadingStates[index].value;
//       return Center(
//         child: SizedBox(
//           width: mq.width * 0.65,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: isLoading ? Colors.transparent : Colors.white,
//               padding: EdgeInsets.symmetric(vertical: mq.height * 0.012),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(mq.width * 0.09),
//                 side: isLoading
//                     ? const BorderSide(color: Colors.white, width: 2)
//                     : BorderSide.none,
//               ),
//             ),
//             onPressed: () => controller.handleButtonTap(index, routeName),
//             child: isLoading
//                 ? SizedBox(
//               width: mq.width * 0.05,
//               height: mq.width * 0.05,
//               child: const CircularProgressIndicator(
//                 color: Colors.white,
//                 strokeWidth: 2,
//               ),
//             )
//                 : Text(
//               text,
//               style: TextStyle(
//                 fontFamily: AppFonts.interMedium,
//                 color: isLoading ? Colors.white : Colors.black,
//                 fontSize: mq.width * 0.04,
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
