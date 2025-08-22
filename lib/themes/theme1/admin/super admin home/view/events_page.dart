import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/style/app_fonts.dart';
import '../controller/super_admin_home_controller.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SuperAdminHomeController controller = Get.find();

    return Obx(() {
      // Check if there is content for the Events tab
      if (controller.hasContent[0]) {
        return const Center(
          child: Text("Events Content Here"),
        );
      } else {
        // Show placeholder and button if no events exist
        return Column(
          children: [
            // Center part
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Add a New Event!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFonts.interBold,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      "Invite the New Location Admins to their new Event and Management App",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFonts.interRegular,
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom part
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "All you need is their email address.",
                    style: TextStyle(
                      fontFamily: AppFonts.interRegular,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.inviteAdmins,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: const BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                      child: const Text(
                        "Invite Admins",
                        style: TextStyle(
                          fontFamily: AppFonts.interBold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    });
  }
}