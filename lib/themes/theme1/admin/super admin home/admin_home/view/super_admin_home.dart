import 'package:adventure_app/themes/theme1/admin/create%20events/view/create_event_page.dart';
import 'package:adventure_app/themes/theme1/admin/create%20team/view/create_team_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/style/app_fonts.dart';
import '../../../create tasks/view/create_task_page.dart';
import '../../Tabs/task/view/tasks_page.dart';
import '../../Tabs/team/view/teams_page.dart';
import '../controller/super_admin_home_controller.dart';
import '../../Tabs/equipment/view/equipment_page.dart';
import '../../Tabs/event/view/events_page.dart';

class SuperAdminHome extends StatelessWidget {
  const SuperAdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final SuperAdminHomeController controller = Get.put(SuperAdminHomeController());

    final List<Widget> pages = [
      const EventsPage(),
      const TeamsPage(),
      const TasksPage(),
      const EquipmentPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // AppBar Section (Black Background)
                Container(
                  color: Colors.black,
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.currentTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: AppFonts.interRegular,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // IconButton(
                      //   icon: const Icon(Icons.search, color: Colors.white),
                      //   onPressed: () {},
                      // ),
                      // IconButton(
                      //   icon: const Icon(Icons.add, color: Colors.white),
                      //   onPressed: () {},
                      // ),
                    ],
                  ),
                ),
                // Tab Bar Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTab(context, controller, "Events", 0),
                      _buildTab(context, controller, "Teams", 1),
                      _buildTab(context, controller, "Tasks", 2),
                      _buildTab(context, controller, "Equipment", 3),
                    ],
                  ),
                ),

                // Main Content Area (Dynamic based on selected tab and hasContent)
                Expanded(
                  child: Obx(() {
                    if (controller.hasContent[controller.selectedTabIndex.value] == false) {
                      return const EventsPage();
                    } else {
                      return pages[controller.selectedTabIndex.value];
                    }
                  }),
                ),
                // "Invite Admins" button (Conditional)
                Obx(() => controller.selectedTabIndex.value == 0 && !controller.hasContent[0]
                    ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        "All you need is their email address.",
                        style: TextStyle(
                          fontFamily: AppFonts.interRegular,
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.inviteAdmins,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white54,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: const BorderSide(color: Colors.black),
                            ),
                          ),
                          child: const Text(
                            "Invite Admins",
                            style: TextStyle(
                              fontFamily: AppFonts.interBold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),)
                    ],
                  ),
                )
                    : const SizedBox.shrink()),
              ],
            ),
          ),
          // Floating Action Button Menu Overlay
          Obx(() => controller.isFabExpanded.value
              ? GestureDetector(
            onTap: controller.toggleFab,
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          )
              : const SizedBox.shrink()),
          // Floating Action Button Menu
          Obx(() {
            final double bottomPosition =
            controller.selectedTabIndex.value == 0 && !controller.hasContent[0]
                ? 180.0 // Adjusted for when "Invite Admins" is shown
                : 110.0; // Regular position
            return Positioned(
              bottom: bottomPosition,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (controller.isFabExpanded.value) ...[
                    _buildFabMenuItem(
                        "Create Event", Icons.group, () => Get.to(() => CreateEventPage())),
                    const SizedBox(height: 10),
                    _buildFabMenuItem(
                        "Create Task", Icons.assignment, () => Get.to(() => CreateTaskPage())),
                    const SizedBox(height: 10),
                    _buildFabMenuItem(
                        "Team Invite", Icons.person_add, () => Get.to(() =>  CreateTeamPage())),
                    const SizedBox(height: 10),
                    _buildFabMenuItem(
                        "New message", Icons.chat_bubble_outline, () => Get.to(() => ())),
                  ],
                ],
              ),
            );
          }),
          // Main Floating Action Button
          Obx(() {
            final double bottomPosition =
            controller.selectedTabIndex.value == 0 && !controller.hasContent[0]
                ? 110.0 // Adjusted for when "Invite Admins" is shown
                : 40.0; // Regular position
            return Positioned(
              bottom: bottomPosition,
              right: 16,
              child: FloatingActionButton(
                onPressed: controller.toggleFab,
                backgroundColor: Colors.black,
                shape: const CircleBorder(),
                child: AnimatedRotation(
                  turns: controller.isFabExpanded.value ? 0.25 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    controller.isFabExpanded.value ? Icons.close : Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, SuperAdminHomeController controller, String title, int index) {
    return Obx(() {
      final isSelected = controller.selectedTabIndex.value == index;
      return GestureDetector(
        onTap: () => controller.selectTab(index),
        child: Container(
          decoration: isSelected
              ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ) )
              : null,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontFamily: isSelected ? AppFonts.interBold : AppFonts.interRegular,
              fontSize: isSelected ? 19 : 18,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.grey[600],
            ),
            child: Text(title),
          ),
        ),
      );
    });
  }

  Widget _buildFabMenuItem(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: AppFonts.interRegular,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.black),
          )
        ],
      ),
    );
  }
}


