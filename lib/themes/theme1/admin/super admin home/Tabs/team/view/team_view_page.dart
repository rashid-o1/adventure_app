import 'package:adventure_app/core/utils/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Widget _buildMemberTile(Map<String, String> member, TeamController controller, double width) {
    return ListTile(
      onLongPress: () {
        controller.showMemberOptionsDialog(member);
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(member["avatar"]!),
        radius: width * 0.05,
      ),
      title: Text(
        member["name"]!,
        style: TextStyle(
          fontFamily: AppFonts.interRegular,
          fontSize: width * 0.035,
        ),
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(
          vertical: width * 0.01,
          horizontal: width * 0.025,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.05),
          color: member["role"] == "Admin" ? Colors.black : Colors.white,
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          member["role"]!,
          style: TextStyle(
            fontFamily: AppFonts.interRegular,
            color: member["role"] == "Admin" ? Colors.white : Colors.black,
            fontSize: width * 0.03,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));

    final String teamName = teamData['name'] ?? "Team";
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    if (!controller.isMuted.containsKey(teamName)) {
      controller.isMuted[teamName] = false;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "$teamName Info",
          style: TextStyle(
            fontFamily: AppFonts.interBold,
            fontSize: width * 0.045,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: width * 0.06),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.black,
              padding: EdgeInsets.only(left: width * 0.04, top: height * 0.02, bottom: height * 0.02, right: width * 0.0125),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    teamName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.05,
                      fontFamily: AppFonts.interRegular,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.03),
                    child: Container(
                      padding: EdgeInsets.all(width * 0.015),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.message,
                          color: Colors.white,
                          size: width * 0.05,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              trailing: Icon(Icons.email_outlined, size: width * 0.06),
              title: Text(
                "Post message via email",
                style: TextStyle(
                  fontFamily: AppFonts.interRegular,
                  fontSize: width * 0.04,
                ),
              ),
              onTap: () {
                controller.showEmailOptionsBottomSheet();
              },
            ),
            const Divider(),
            ListTile(
              dense: true,
              trailing: Icon(Icons.attach_file, size: width * 0.06),
              title: Text(
                "Pinned files & media",
                style: TextStyle(
                  fontFamily: AppFonts.interRegular,
                  fontSize: width * 0.04,
                ),
              ),
              onTap: () {
                Get.to(() => PinnedFilesPage(teamName: '$teamName'));
              },
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mute conversation",
                    style: TextStyle(
                      fontFamily: AppFonts.interRegular,
                      fontSize: width * 0.04,
                    ),
                  ),
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
            Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: Text(
                "Members",
                style: TextStyle(
                  fontFamily: AppFonts.interBold,
                  fontSize: width * 0.04,
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.black,
                radius: width * 0.05,
                child: Icon(Icons.add, color: Colors.white, size: width * 0.05),
              ),
              title: Text(
                "Add Members",
                style: TextStyle(
                  fontFamily: AppFonts.interRegular,
                  fontSize: width * 0.04,
                ),
              ),
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
                    return _buildMemberTile(member, controller, width);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
