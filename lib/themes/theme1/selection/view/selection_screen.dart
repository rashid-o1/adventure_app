import 'package:adventure_app/core/utils/constant/app_labels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adventure_app/themes/theme1/selection/controller/selection_controller.dart';
import '../../../../core/utils/style/app_fonts.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject the controller
    final controller = Get.put(SelectionController());

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
          // Content with "Hello there" text and buttons
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(
                  '${AppLabels.helloThere}  👋',
                  style: TextStyle(
                    fontFamily: AppFonts.interBold,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please Select who you are using 4x4 Adventures.',
                  style: TextStyle(
                    fontFamily: AppFonts.interRegular,
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                // Admin Button
                _buildSelectionButton(
                  context,
                  controller,
                  0, // Index for the button
                  AppLabels.adminselectionbtntext,
                  '/superAdminHome',
                ),
                const SizedBox(height: 15),
                // Team Lead Button
                _buildSelectionButton(
                  context,
                  controller,
                  1, // Index for the button
                  AppLabels.teamleadbtntext,
                  '/login',
                ),
                const SizedBox(height: 15),
                // Team Member Button
                _buildSelectionButton(
                  context,
                  controller,
                  2, // Index for the button
                  AppLabels.teammemberbtntext,
                  '/login',
                ),
                const SizedBox(height: 70),
              ],
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
      String routeName) {
    return Obx(() {
      final isLoading = controller.loadingStates[index].value;
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isLoading ? Colors.transparent : Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: isLoading
                  ? const BorderSide(color: Colors.white, width: 2)
                  : BorderSide.none,
            ),
          ),
          onPressed: () => controller.handleButtonTap(index, routeName),
          child: isLoading
              ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
              : Text(
            text,
            style: TextStyle(
              fontFamily: AppFonts.interMedium,
              color: isLoading ? Colors.white : Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      );
    });
  }
}