import 'package:adventure_app/themes/theme1/admin/create%20events/view/create_event_page.dart';
import 'package:adventure_app/themes/theme1/admin/create%20team/view/create_team_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/style/app_fonts.dart';
import '../../../../auth/request_status/view/registration_requests_page.dart';
import '../../../create%20tasks/view/create_task_page.dart';
import '../../Tabs/task/view/tasks_page.dart';
import '../../Tabs/team/view/teams_page.dart';
import '../controller/super_admin_home_controller.dart';
import '../../Tabs/equipment/view/equipment_page.dart';
import '../../Tabs/event/view/events_page.dart';
import '../../../../../../services/auth_service.dart';

class SuperAdminHome extends StatelessWidget {
  const SuperAdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final SuperAdminHomeController controller = Get.put(SuperAdminHomeController());
    final AuthService authService = AuthService();

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final List<Widget> pages = [
      const EventsPage(),
      const TeamsPage(),
      const TasksPage(),
      const EquipmentPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          controller.currentTitle,
          style: TextStyle(
            fontFamily: AppFonts.interBold,
            fontSize: width * 0.055,
            color: Colors.white,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) async {
              if (value == 'logout') {
                await authService.signOut();
              } else if (value == 'register_requests') {
                Get.to(() => const RegistrationRequestsPage());
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'logout',
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontFamily: AppFonts.interRegular,
                    fontSize: width * 0.04,
                    color: Colors.black,
                  ),
                ),
              ),
              PopupMenuItem<String>(
                value: 'register_requests',
                child: Text(
                  'Register Requests',
                  style: TextStyle(
                    fontFamily: AppFonts.interRegular,
                    fontSize: width * 0.04,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        top: false, // ✅ exclude AppBar area from SafeArea
        child: Stack(
          children: [
            Column(
              children: [
                // Tabs Row
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.012),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTab(context, controller, "Events", 0, width),
                      _buildTab(context, controller, "Teams", 1, width),
                      _buildTab(context, controller, "Tasks", 2, width),
                      _buildTab(context, controller, "Equipment", 3, width),
                    ],
                  ),
                ),

                // Pages content
                Expanded(
                  child: Obx(() {
                    if (controller.hasContent[controller.selectedTabIndex.value] == false) {
                      return const EventsPage();
                    } else {
                      return pages[controller.selectedTabIndex.value];
                    }
                  }),
                ),

                // Bottom Placeholder for Events Tab
                Obx(() => controller.selectedTabIndex.value == 0 && !controller.hasContent[0]
                    ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.025),
                  child: Column(
                    children: [
                      Text(
                        "All you need is their email address.",
                        style: TextStyle(
                          fontFamily: AppFonts.interRegular,
                          fontSize: width * 0.037,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: height * 0.012),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.inviteAdmins,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white54,
                            padding: EdgeInsets.symmetric(vertical: height * 0.022),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: const BorderSide(color: Colors.black),
                            ),
                          ),
                          child: Text(
                            "Invite Admins",
                            style: TextStyle(
                              fontFamily: AppFonts.interBold,
                              color: Colors.black,
                              fontSize: width * 0.042,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
                    : const SizedBox.shrink()),
              ],
            ),

            // FAB overlay background
            Obx(() => controller.isFabExpanded.value
                ? GestureDetector(
              onTap: controller.toggleFab,
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            )
                : const SizedBox.shrink()),

            // FAB Menu Items
            Obx(() {
              final double bottomPosition = controller.selectedTabIndex.value == 0 && !controller.hasContent[0]
                  ? height * 0.22
                  : height * 0.13;
              return Positioned(
                bottom: bottomPosition,
                right: width * 0.04,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (controller.isFabExpanded.value) ...[
                      _buildFabMenuItem("Create Event", Icons.group, () => Get.to(() => const CreateEventPage()), width),
                      SizedBox(height: height * 0.012),
                      _buildFabMenuItem("Create Task", Icons.assignment, () => Get.to(() => const CreateTaskPage()), width),
                      SizedBox(height: height * 0.012),
                      _buildFabMenuItem("Team Invite", Icons.person_add, () => Get.to(() => const CreateTeamPage()), width),
                      SizedBox(height: height * 0.012),
                      _buildFabMenuItem("New message", Icons.chat_bubble_outline, () {}, width),
                    ],
                  ],
                ),
              );
            }),

            // Main FAB Button
            Obx(() {
              final double bottomPosition = controller.selectedTabIndex.value == 0 && !controller.hasContent[0]
                  ? height * 0.13
                  : height * 0.05;
              return Positioned(
                bottom: bottomPosition,
                right: width * 0.04,
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
                      size: width * 0.07,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // 🔹 Build Tab
  Widget _buildTab(BuildContext context, SuperAdminHomeController controller, String title, int index, double width) {
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
            ),
          )
              : null,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontFamily: isSelected ? AppFonts.interBold : AppFonts.interRegular,
              fontSize: isSelected ? width * 0.048 : width * 0.045,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.grey[600],
            ),
            child: Text(title),
          ),
        ),
      );
    });
  }

  // 🔹 Build FAB Menu
  Widget _buildFabMenuItem(String label, IconData icon, VoidCallback onTap, double width) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.025, vertical: width * 0.012),
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
              style: TextStyle(
                fontFamily: AppFonts.interRegular,
                fontSize: width * 0.04,
              ),
            ),
          ),
          SizedBox(width: width * 0.02),
          Container(
            padding: EdgeInsets.all(width * 0.03),
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
            child: Icon(icon, color: Colors.black, size: width * 0.055),
          )
        ],
      ),
    );
  }
}