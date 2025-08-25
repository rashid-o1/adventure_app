import 'package:adventure_app/core/utils/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../core/utils/style/app_fonts.dart';
import '../controller/team_controller.dart';
import 'add_member_page.dart';
import 'pinned_files_page.dart';

class TeamViewPage extends StatelessWidget {
  final Map<String, String> teamData;

  final TeamController controller = Get.find();

  TeamViewPage({super.key, required this.teamData}) {
    controller.processMembers(teamData['name'] ?? "Team");
  }

  // Helper widget to build each member's list tile
  Widget _buildMemberTile(Map<String, String> member, TeamController controller) {
    return ListTile(
      onLongPress: () {
        controller.showMemberOptionsDialog(member);
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(member["avatar"]!),
      ),
      title: Text(
        member["name"]!,
        style: const TextStyle(
          fontFamily: AppFonts.interRegular,
          fontSize: 14,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: member["role"] == "Admin" ? Colors.black : Colors.white,
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          member["role"]!,
          style: TextStyle(
            fontFamily: AppFonts.interRegular,
            color: member["role"] == "Admin" ? Colors.white : Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String teamName = teamData['name'] ?? "Team";

    if (!controller.isMuted.containsKey(teamName)) {
      controller.isMuted[teamName] = false;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "$teamName Info",
          style: const TextStyle(
            fontFamily: AppFonts.interBold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: Colors.black,
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  teamName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: AppFonts.interRegular,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            trailing: const Icon(Icons.email_outlined),
            title: const Text("Post message via email",
                style: TextStyle(fontFamily: AppFonts.interRegular)),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            dense: true,
            trailing: const Icon(Icons.attach_file),
            title: const Text("Pinned files & media",
                style: TextStyle(fontFamily: AppFonts.interRegular, fontSize: 16)),
            onTap: () {
              Get.to(() => PinnedFilesPage(teamName: '$teamName'));
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Mute conversation",
                    style: TextStyle(fontFamily: AppFonts.interRegular, fontSize: 16)),
                Obx(() => Switch(
                  value: controller.isMuted[teamName] ?? false,
                  onChanged: (val) {
                    controller.isMuted[teamName] = val;
                  },
                  activeColor: Colors.white,
                  activeTrackColor: Colors.black,
                  inactiveTrackColor: Colors.white,
                  inactiveThumbColor: Colors.black,
                )),
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Members",
              style: TextStyle(
                fontFamily: AppFonts.interBold,
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.black,
              child: Icon(Icons.add, color: Colors.white),
            ),
            title: const Text("Add Members",
                style: TextStyle(fontFamily: AppFonts.interRegular)),
            onTap: () {
              Get.to(() => AddMembersPage(teamName: '$teamName'));
            },
          ),
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: controller.members.length,
                itemBuilder: (context, index) {
                  final member = controller.members[index];
                  return _buildMemberTile(member, controller);
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
