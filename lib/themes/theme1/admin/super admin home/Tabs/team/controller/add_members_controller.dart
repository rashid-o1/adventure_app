import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMembersController extends GetxController {

  final emails = <String>[].obs;

  // Add a new email to the list.
  void addEmail(String email) {
    if (emails.contains(email)) {
      Get.snackbar("Duplicate Email", "This email has already been added.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white);
      return;
    }
    emails.add(email);
  }

  // Remove an email from the list.
  void removeEmail(String email) {
    emails.remove(email);
  }

  // Validate the email format using a simple regex.
  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Simulate sending invites.
  void sendInvites() {

    print("Sending invites to: ${emails.toList()}");


    emails.clear();

    Get.snackbar(
      "Invites Sent",
      "Invites have been sent successfully!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
