import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../../../core/utils/style/app_fonts.dart';
import '../controller/team_controller.dart';
import 'team_chat_page.dart';

class TeamsPage extends StatelessWidget {
  const TeamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    final TeamController teamsController = Get.put(TeamController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (teamsController.teams.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search here!",
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixIcon: const Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                          const BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                          const BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                          const BorderSide(color: Colors.black, width: 1.8),
                        ),
                        contentPadding:
                        EdgeInsets.all(screenWidth * 0.04),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02),
                    itemCount: teamsController.teams.length,
                    itemBuilder: (context, index) {
                      final teamData = teamsController.teams[index];
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => TeamChatPage(teamData: teamData));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.01,
                                horizontal: screenWidth * 0.02,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: Image.network(
                                      teamData['avatar'] ??
                                          'https://via.placeholder.com/150',
                                      width: screenWidth * 0.12,
                                      height: screenWidth * 0.12,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.04),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          teamData['name'] ?? 'N/A',
                                          style: const TextStyle(
                                            fontFamily: AppFonts.interBold,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.005),
                                        Text(
                                          teamData['description'] ??
                                              'No description',
                                          style: TextStyle(
                                            fontFamily: AppFonts.interRegular,
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    onSelected: (String result) {
                                      if (result == 'favorites') {
                                      } else if (result == 'mute') {}
                                    },
                                    color: Colors.grey[100],
                                    itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        height: 20,
                                        value: 'favorites',
                                        child: Text(
                                          'Add to favorites',
                                          style: TextStyle(
                                              fontFamily:
                                              AppFonts.interRegular),
                                        ),
                                      ),
                                      const PopupMenuDivider(),
                                      const PopupMenuItem<String>(
                                        height: 20,
                                        value: 'mute',
                                        child: SizedBox(
                                            width: 120,
                                            child: Text(
                                              'Mute',
                                              style: TextStyle(
                                                  fontFamily:
                                                  AppFonts.interRegular),
                                            )),
                                      ),
                                    ],
                                    icon: const Icon(Icons.more_vert,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(height: 1),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Add a New Team!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFonts.interBold,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "Invite team members by entering their email addresses and start collaborating instantly.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFonts.interRegular,
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}