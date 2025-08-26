import 'package:adventure_app/core/utils/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adventure_app/core/utils/style/app_fonts.dart';
import '../../../../../../../core/utils/style/app_colors.dart';
import '../controller/add_members_controller.dart';

class AddMembersPage extends StatelessWidget {
  final String teamName;

  const AddMembersPage({super.key, required this.teamName});

  @override
  Widget build(BuildContext context) {

    final AddMembersController controller = Get.put(AddMembersController());
    final TextEditingController emailTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          teamName,
          style: const TextStyle(
            fontFamily: AppFonts.interRegular,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200], // background color
            ),
            child: const Icon(size: 15, Icons.arrow_back, color: AppColors.black),
          ),
        ),

        actions: [
          Obx(() => IconButton(
            onPressed: controller.emails.isEmpty
                ? null
                : () {
              controller.sendInvites();
            },
            icon: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.emails.isEmpty
                    ? Colors.grey.shade200 // disabled state
                    : Colors.black, // active state background
              ),
              child: Icon(
                size: 15,
                Icons.done,
                color: controller.emails.isEmpty
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          )),
        ],

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "To",
                style: TextStyle(
                  fontFamily: AppFonts.interBold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailTextController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter their email address.",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                onSubmitted: (email) {
                  if (controller.validateEmail(email)) {
                    controller.addEmail(email);
                    emailTextController.clear();
                  } else {
                    Get.snackbar(
                      "Invalid Email",
                      "Please enter a valid email address.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              Obx(() => Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: controller.emails.map((email) {
                  return Chip(
                    label: Text(email),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.black, width: 1.5),
                    ),
                    onDeleted: () {
                      controller.removeEmail(email);
                    },
                    deleteIcon: const Icon(Icons.close, size: 16),
                  );
                }).toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
