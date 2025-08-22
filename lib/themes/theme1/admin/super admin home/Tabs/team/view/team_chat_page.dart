// File: lib/themes/theme1/admin/super admin home/Tabs/team/view/team_chat_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../core/utils/style/app_fonts.dart';
import '../controller/team_controller.dart';

class TeamChatPage extends StatelessWidget {
  final Map<String, String> teamData;

  const TeamChatPage({super.key, required this.teamData});

  @override
  Widget build(BuildContext context) {
    final TeamController teamsController = Get.find();
    final List<Map<String, String>> chatMessages = teamsController.chatMessages[teamData['name']] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(teamData['name'] ?? "Team Chat", style: const TextStyle(fontFamily: AppFonts.interRegular)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // handle selected action
            },
            color: Colors.grey[100],
            itemBuilder: (BuildContext context) {
              final items = ['View', 'Search', 'Pinned files'];
              List<PopupMenuEntry<String>> menuItems = [];

              for (int i = 0; i < items.length; i++) {
                menuItems.add(
                  PopupMenuItem<String>(
                    value: items[i],
                    height: 30,
                    child: SizedBox(
                      width: 120,
                      child: Text(items[i], style: TextStyle(
                          fontFamily: AppFonts.interRegular
                      ),),
                    ),
                  ),
                );
                // add divider except for last item
                if (i != items.length - 1) {
                  menuItems.add(const PopupMenuDivider());
                }
              }

              return menuItems;
            },
          ),
        ],

      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Get Started",
              style: TextStyle(
                fontFamily: AppFonts.interBold,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16),
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                return Column(
                  children: [
                    ChatMessage(message: message),
                    // Add divider after each message
                    if (index < chatMessages.length - 1)
                      const Divider(height: 1),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

class ChatMessage extends StatelessWidget {
  final Map<String, String> message;

  const ChatMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.network(
              message['avatar'] ?? 'https://via.placeholder.com/150',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      message['sender'] ?? 'Unknown',
                      style: const TextStyle(
                        fontFamily: AppFonts.interBold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      message['timestamp'] ?? '',
                      style: TextStyle(
                        fontFamily: AppFonts.interRegular,
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  message['message'] ?? '',
                  style: const TextStyle(fontFamily: AppFonts.interRegular),
                ),
                Text(
                  "See translation",
                  style: TextStyle(
                    fontFamily: AppFonts.interRegular,
                    fontSize: 10,
                    color: Colors.blue.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}