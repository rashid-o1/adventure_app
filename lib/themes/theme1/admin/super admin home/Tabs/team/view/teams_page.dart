import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../core/utils/style/app_fonts.dart';
import '../controller/team_controller.dart';
import 'team_chat_page.dart';

class TeamsPage extends StatelessWidget {
  const TeamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TeamController teamsController = Get.put(TeamController());

    return Obx(() {
      if (teamsController.teams.isNotEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                      borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black, width: 1.8), // 👈 black border on input
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                itemCount: teamsController.teams.length,
                itemBuilder: (context, index) {
                  final teamData = teamsController.teams[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // Pass the team data to the chat page
                          Get.to(() => TeamChatPage(teamData: teamData));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Image.network(
                                  teamData['avatar'] ??
                                      'https://via.placeholder.com/150',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      teamData['name'] ?? 'N/A',
                                      style: const TextStyle(
                                        fontFamily: AppFonts.interBold,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
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
                              // "Add to favorites" & Pop-up Menu
                              PopupMenuButton<String>(
                                onSelected: (String result) {
                                  if (result == 'favorites') {
                                  } else if (result == 'mute') {
                                  }
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
                                          fontFamily: AppFonts.interRegular),
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
                      const Divider(height: 1), // 👈 divider after each item (including last one)
                    ],
                  );
                },
              ),
            ),
          ],
        );
      } else {
        // Placeholder UI
        return Column(
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "Invite team members by entering their email addresses and start collaborating instantly.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppFonts.interRegular,
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}
