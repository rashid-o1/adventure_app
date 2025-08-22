import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../view/create_team_page2.dart';


class CreateTeamController extends GetxController {
  final TextEditingController teamNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final RxList<String> invitedEmails = <String>[].obs;

  @override
  void onClose() {
    teamNameController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void addEmail() {
    final email = emailController.text.trim();
    if (email.isNotEmpty && GetUtils.isEmail(email)) {
      // Check if the email already exists in the list
      if (!invitedEmails.contains(email)) {
        invitedEmails.add(email);
        emailController.clear();
        print("Added email: $email");
      } else {
        Get.snackbar(
          "Duplicate Email",
          "This email has already been added.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email address.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void removeEmail(String email) {
    invitedEmails.remove(email);
  }

  void confirmAndNext() {
    // Handle form submission and navigation
    if (teamNameController.text.isEmpty) {
      Get.snackbar(
        "Team Name Required",
        "Please enter a team name to continue.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      print("Confirm & Next button pressed.");
      print("Team Name: ${teamNameController.text}");
      Get.to(() => const CreateTeamPage2());
    }
  }

  void sendInvites() {
    print("Sending invites...");
    print("Team Name: ${teamNameController.text}");
    print("Invited Emails: ${invitedEmails.join(', ')}");

    Get.snackbar(
      "Success",
      "Invites sent to given team members.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
