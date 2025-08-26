import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/utils/constant/app_labels.dart';
import '../../../../../core/utils/style/app_fonts.dart';
import '../controller/create_task_controller.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateTaskController controller = Get.put(CreateTaskController());
    final media = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: const Text(
            AppLabels.newtask,
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
          padding: EdgeInsets.all(media.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppLabels.tasktitle,
                style: TextStyle(
                  fontFamily: AppFonts.interBold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: media.height * 0.01),
              TextFormField(
                controller: controller.taskNameController,
                decoration: const InputDecoration(
                  hintText: AppLabels.nametaskhint,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),
                ),
              ),
              SizedBox(height: media.height * 0.015),

              const Text(
                AppLabels.instructiontitle,
                style: TextStyle(
                  fontFamily: AppFonts.interBold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: media.height * 0.01),
              TextFormField(
                controller: controller.instructionsController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: AppLabels.instructionhint,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),
                ),
              ),
              SizedBox(height: media.height * 0.025),

              Row(
                children: [
                  Expanded(
                    child: _buildDateTimePicker(
                      context,
                      label: "Select Date",
                      icon: Icons.keyboard_arrow_down,
                      onTap: () => controller.selectDate(context),
                      displayValue: controller.selectedDate,
                      isDate: true,
                    ),
                  ),
                  SizedBox(width: media.width * 0.04),
                  Expanded(
                    child: _buildDateTimePicker(
                      context,
                      label: "Select Time",
                      icon: Icons.keyboard_arrow_down,
                      onTap: () => controller.selectTime(context),
                      displayValue: controller.selectedTime,
                      isDate: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: media.height * 0.025),

              const Text(
                "Location",
                style: TextStyle(
                  fontFamily: AppFonts.interBold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: media.height * 0.01),
              TextFormField(
                controller: controller.locationController,
                decoration: const InputDecoration(
                  hintText: "XYYZZ",
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),
                ),
              ),
              SizedBox(height: media.height * 0.015),
              GestureDetector(
                onTap: controller.useCurrentLocation,
                child: const Row(
                  children: [
                    Icon(Icons.add_location_alt_outlined, size: 20),
                    SizedBox(width: 8),
                    Text(
                      AppLabels.currentlocation,
                      style: TextStyle(
                        fontFamily: AppFonts.interRegular,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: media.height * 0.05),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: media.height * 0.02),
                    minimumSize: Size(double.infinity, media.height * 0.07),
                    side: const BorderSide(color: Colors.black, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Upload PDF",
                    style: TextStyle(
                      fontFamily: AppFonts.interBold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: media.height * 0.02),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.confirmAndNext,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, media.height * 0.07),
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: media.height * 0.02),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker(
      BuildContext context, {
        required String label,
        required IconData icon,
        required VoidCallback onTap,
        required Rx<dynamic> displayValue,
        required bool isDate,
      }) {
    final media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Obx(
            () => Container(
          padding: EdgeInsets.symmetric(
            vertical: media.height * 0.022,
            horizontal: media.width * 0.04,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  displayValue.value != null
                      ? (isDate
                      ? DateFormat('MMM : dd : yyyy')
                      .format(displayValue.value as DateTime)
                      : (displayValue.value as TimeOfDay).format(context))
                      : label,
                  style: TextStyle(
                    fontFamily: AppFonts.interRegular,
                    fontSize: 16,
                    color: displayValue.value != null
                        ? Colors.black
                        : Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              Icon(icon, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
