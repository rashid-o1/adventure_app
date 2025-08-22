import 'package:adventure_app/core/utils/constant/app_labels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/style/app_fonts.dart';
import '../controller/create_event_controller.dart';
import 'package:intl/intl.dart';

class CreateEventPage extends StatelessWidget {
  const CreateEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateEventController controller = Get.put(CreateEventController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          AppLabels.newevent,
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
            // Event Name
            const Text(
              AppLabels.eventtitle,
              style: TextStyle(
                fontFamily: AppFonts.interBold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.eventNameController,
              decoration: const InputDecoration(
                hintText: "Team Sha79",
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

            // Description
            const Text(
              AppLabels.eventdescriptiontitle,
              style: TextStyle(
                fontFamily: AppFonts.interBold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: AppLabels.eventdescriptionhint,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Instructions
            const Text(
              AppLabels.instructiontitle,
              style: TextStyle(
                fontFamily: AppFonts.interBold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
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
            const SizedBox(height: 20),

            // Select Date & Time
            Row(
              children: [
                Expanded(
                  child: _buildDateTimePicker(
                    context,
                    label: "Select Date",
                    icon: Icons.keyboard_arrow_down,
                    onTap: () => controller.selectDate(context),
                    displayValue: controller.selectedDate,
                    isDate: true, // New parameter
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDateTimePicker(
                    context,
                    label: "Select Time",
                    icon: Icons.keyboard_arrow_down,
                    onTap: () => controller.selectTime(context),
                    displayValue: controller.selectedTime,
                    isDate: false, // New parameter
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Location
            const Text(
              "Location",
              style: TextStyle(
                fontFamily: AppFonts.interBold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
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
            const SizedBox(height: 10),
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
            const SizedBox(height: 40),

            // Upload PDF Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  minimumSize: const Size(double.infinity, 55),
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
            const SizedBox(height: 16),

            // Confirm & Next Button
            SizedBox(
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
          ],
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
        required bool isDate, // New parameter to differentiate date and time
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
            () => Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  displayValue.value != null
                      ? (isDate
                      ? DateFormat('MMM : dd : yyyy').format(displayValue.value as DateTime)
                      : (displayValue.value as TimeOfDay).format(context))
                      : label,
                  style: TextStyle(
                    fontFamily: AppFonts.interRegular,
                    fontSize: 16,
                    color: displayValue.value != null ? Colors.black : Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis,
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
