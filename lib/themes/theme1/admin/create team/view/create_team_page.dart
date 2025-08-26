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
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: mq.width * 0.07),
          onPressed: () => Get.back(),
        ),
        title: Text(
          AppLabels.newteam,
          style: TextStyle(
            fontFamily: AppFonts.interRegular,
            fontSize: mq.width * 0.05,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(mq.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Team Name
              Text(
                AppLabels.teamtitle,
                style: TextStyle(
                  fontFamily: AppFonts.interBold,
                  fontSize: mq.width * 0.042,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: mq.height * 0.01),
              TextFormField(
                controller: controller.teamNameController,
                decoration: InputDecoration(
                  hintText: AppLabels.teamnamehint,
                  hintStyle: TextStyle(
                    fontSize: mq.width * 0.04,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: mq.height * 0.018),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),
                ),
                style: TextStyle(fontSize: mq.width * 0.043),
              ),
              SizedBox(height: mq.height * 0.02),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(mq.width * 0.05),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.confirmAndNext,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, mq.height * 0.065),
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: mq.height * 0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(mq.width * 0.08),
                ),
              ),
              child: Text(
                AppLabels.confirmnext,
                style: TextStyle(
                  fontFamily: AppFonts.interBold,
                  color: Colors.white,
                  fontSize: mq.width * 0.045,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
