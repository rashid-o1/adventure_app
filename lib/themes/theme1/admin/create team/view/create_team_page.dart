import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/constant/app_labels.dart';
import '../../../../../core/utils/style/app_fonts.dart';
import '../controller/create_team_controller.dart';

class CreateTeamPage extends StatelessWidget {
  const CreateTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateTeamController controller = Get.put(CreateTeamController());

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
            // Team Name
            const Text(
              AppLabels.teamtitle,
              style: TextStyle(
                fontFamily: AppFonts.interBold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.teamNameController,
              decoration: const InputDecoration(
                hintText: AppLabels.teamnamehint,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.confirmAndNext,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 55),
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              AppLabels.confirmnext,
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
