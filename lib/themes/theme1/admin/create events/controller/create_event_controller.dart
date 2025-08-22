import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateEventController extends GetxController {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  // observable for the selected date and time
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);

  @override
  void onClose() {
    eventNameController.dispose();
    descriptionController.dispose();
    instructionsController.dispose();
    locationController.dispose();
    super.onClose();
  }

  // Cupertino-style Date Picker
  Future<void> selectDate(BuildContext context) async {
    DateTime initialDate = selectedDate.value ?? DateTime.now();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext builder) {
        DateTime tempPickedDate = initialDate;
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      initialDateTime: initialDate,
                      mode: CupertinoDatePickerMode.date,
                      minimumDate: DateTime(2000),
                      maximumDate: DateTime(2101),
                      onDateTimeChanged: (DateTime newDate) {
                        tempPickedDate = newDate;
                      },
                    ),
                  ),
                  CupertinoButton(
                    child: const Text("Done"),
                    onPressed: () {
                      selectedDate.value = tempPickedDate;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// Cupertino-style Time Picker
  Future<void> selectTime(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime initialDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.value?.hour ?? now.hour,
      selectedTime.value?.minute ?? now.minute,
    );

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext builder) {
        DateTime tempPickedTime = initialDateTime;
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      initialDateTime: initialDateTime,
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: false,
                      onDateTimeChanged: (DateTime newTime) {
                        tempPickedTime = newTime;
                      },
                    ),
                  ),
                  CupertinoButton(
                    child: const Text("Done"),
                    onPressed: () {
                      selectedTime.value = TimeOfDay.fromDateTime(tempPickedTime);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  // Method to use the current location.
  Future<void> useCurrentLocation() async {
    print("Fetching current location...");
    locationController.text = "Fetching location...";

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("Error", "Location permissions are denied.");
          locationController.text = "Permission denied.";
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        Get.snackbar("Error",
            "Location permissions are permanently denied, we cannot request permissions.");
        locationController.text = "Permission denied permanently.";
        return;
      }
      Position position =
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      locationController.text = "${position.latitude}, ${position.longitude}";
      Get.snackbar("Success", "Your current location has been fetched.");
    } catch (e) {
      Get.snackbar("Error", "Could not get location: $e");
      locationController.text = "Error getting location.";
    }

    await Future.delayed(const Duration(seconds: 2));
    locationController.text = "24.8607° N, 67.0011° E"; // Example coordinates
    Get.snackbar(
      "Location",
      "Your current location has been used.",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void confirmAndNext() {
    print("Confirm & Next button pressed.");
    print("Event Name: ${eventNameController.text}");
    print("Description: ${descriptionController.text}");
    print("Instructions: ${instructionsController.text}");
    print("Date: ${selectedDate.value}");
    print("Time: ${selectedTime.value}");
    print("Location: ${locationController.text}");
    Get.snackbar(
      "Success",
      "Event details have been submitted.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
