import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuperAdminHomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxInt selectedTabIndex = 0.obs;
  RxBool isFabExpanded = false.obs;

  // This list tracks if each tab (Events, Teams, Tasks, Equipment) has content
  // Initially, only the Events tab is empty to show the placeholder content.
  final hasContent = [false, true, true, true].obs;

  final String tabTitle = "Messages"; // Always same

  String get currentTitle => tabTitle;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void selectTab(int index) {
    selectedTabIndex.value = index;
    print("Tab selected: $index");
  }

  void inviteAdmins() {
    print("Invite Admins button pressed.");
    Get.snackbar(
      "Success",
      "Invite Admins button was pressed.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void toggleFab() {
    isFabExpanded.value = !isFabExpanded.value;
  }
}