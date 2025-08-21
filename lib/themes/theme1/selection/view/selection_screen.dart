import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/style/app_fonts.dart';// Import your new AppFonts class

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'Hello there 👋',
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
                  '4x4 Adventures Admin',
                      () {
                    Get.offNamed('/superAdminHome'); // Replace with your admin home route
                  },
                ),
                const SizedBox(height: 15),
                // Team Lead Button
                _buildSelectionButton(
                  context,
                  'Team Lead',
                      () {
                    Get.offNamed('/login'); // Replace with your team lead login route
                  },
                ),
                const SizedBox(height: 15),
                // Team Member Button
                _buildSelectionButton(
                  context,
                  'Team Member',
                      () {
                    Get.offNamed('/login'); // Replace with your team member login route
                  },
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
      BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: AppFonts.interMedium,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}