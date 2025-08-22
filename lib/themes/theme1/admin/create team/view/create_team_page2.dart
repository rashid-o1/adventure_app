import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/constant/app_labels.dart';
import '../../../../../core/utils/style/app_fonts.dart';
import '../controller/create_team_controller.dart';

class CreateTeamPage2 extends StatelessWidget {
  const CreateTeamPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateTeamController controller = Get.find<CreateTeamController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          AppLabels.newteam,
          style: TextStyle(
            fontFamily: AppFonts.interRegular,
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email Input
            const Text(
              AppLabels.Email,
              style: TextStyle(
                fontFamily: AppFonts.interBold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (value) {
                controller.addEmail();
              },
              decoration: const InputDecoration(
                hintText: AppLabels.emailhint,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Display of added emails as chips
            Obx(
                  () => Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: controller.invitedEmails.map((email) {
                  return Chip(
                    label: Text(email),
                    onDeleted: () => controller.removeEmail(email),
                    deleteIcon: const Icon(Icons.close),
                    backgroundColor: Colors.grey[200],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),

            // Terms and Conditions text
            const Text(
              "By creating a team, I accept the term of service and its mandatory arbitration provision and acknowledge the privacy notice and acceptable use policy.",
              style: TextStyle(
                fontFamily: AppFonts.interRegular,
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.sendInvites,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 55),
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Send",
              style: TextStyle(
                fontFamily: AppFonts.interBold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
