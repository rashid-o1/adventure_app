import 'package:adventure_app/themes/theme1/admin/super%20admin%20home/Tabs/team/view/team_view_page.dart';
import 'package:adventure_app/themes/theme1/admin/super%20admin%20home/Tabs/team/view/view_tabs/team_image_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../core/utils/style/app_fonts.dart';
import '../controller/team_controller.dart';
import 'package:intl/intl.dart';

class _DateHeader extends StatelessWidget {
  final String date;

  const _DateHeader({required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            date,
            style: TextStyle(
              fontFamily: AppFonts.interRegular,
              fontSize: 12,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ),
    );
  }
}

class TeamChatPage extends StatelessWidget {
  final Map<String, String> teamData;

  const TeamChatPage({super.key, required this.teamData});

  // Helper function to format the date
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final aDate = DateTime(date.year, date.month, date.day);

    if (aDate == today) {
      return "Today";
    } else if (aDate == yesterday) {
      return "Yesterday";
    } else {
      return DateFormat('MMMM d, y').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TeamController teamsController = Get.find();

    teamsController.isSearching.value = false;
    teamsController.searchQuery.value = "";

    final List<Map<String, dynamic>> chatMessages =
        teamsController.chatMessages[teamData['name']] ?? [];

    //  Sort messages by timestamp to ensure correct chronological order
    chatMessages.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

    // Group messages by date for display
    final List<Widget> groupedMessagesWidgets = [];
    DateTime? lastDate;

    for (var message in chatMessages) {
      final messageDate = message['timestamp'] as DateTime;
      final currentDate = DateTime(
          messageDate.year, messageDate.month, messageDate.day);

      if (lastDate == null || currentDate != lastDate) {
        groupedMessagesWidgets.add(_DateHeader(date: _formatDate(currentDate)));
        lastDate = currentDate;
      }
      groupedMessagesWidgets.add(ChatMessage(message: message));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          teamData['name'] ?? "Team Chat",
          style: const TextStyle(fontFamily: AppFonts.interRegular),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "Search") {
                teamsController.isSearching.value = true;
              } else if (value == "View") {
                Get.to(() => TeamViewPage(teamData: teamData));
              } else if (value == "Pinned files") {

              }
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
                      child: Text(
                        items[i],
                        style: const TextStyle(fontFamily: AppFonts.interRegular),
                      ),
                    ),
                  ),
                );
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
          // Search bar / Get Started label
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: teamsController.isSearching.value
                  ? Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  onChanged: (value) =>
                  teamsController.searchQuery.value = value,
                  decoration: InputDecoration(
                    hintText: "Search here!",
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () {
                        teamsController.isSearching.value = false;
                        teamsController.searchQuery.value = "";
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Colors.grey, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Colors.black, width: 1.8),
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
              )
                  : const Text(
                "Get Started",
                style: TextStyle(
                  fontFamily: AppFonts.interBold,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
          const Divider(),
          // Chat list
          Expanded(
            child: Obx(() {
              final query = teamsController.searchQuery.value.toLowerCase();
              final filteredMessages = query.isEmpty
                  ? groupedMessagesWidgets
                  : groupedMessagesWidgets
                  .where((widget) {
                if (widget is ChatMessage) {
                  final message = widget.message;
                  return (message['message'] ?? '')
                      .toLowerCase()
                      .contains(query) ||
                      (message['sender'] ?? '')
                          .toLowerCase()
                          .contains(query);
                }
                return false;
              }).toList();

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: filteredMessages.length,
                itemBuilder: (context, index) {
                  final item = filteredMessages[index];
                  return Column(
                    children: [
                      item,
                      if (item is ChatMessage)
                        Divider(thickness: 1.0, color: Colors.grey.shade200),
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

class ChatMessage extends StatelessWidget {
  final Map<String, dynamic> message;

  const ChatMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // Access the TeamController to handle the long press logic
    final TeamController teamsController = Get.find();

    final String? type = message['contentType'];
    final DateTime timestamp = message['timestamp'] as DateTime;
    final String formattedTime = DateFormat('h:mm a').format(timestamp);

    return Obx(() {
      final isSelected = teamsController.selectedMessage.value != null &&
          teamsController.selectedMessage.value!['timestamp'] == message['timestamp'] &&
          teamsController.selectedMessage.value!['message'] == message['message'];
      return GestureDetector(
        onTap: () {
          // if (teamsController.selectedMessage.value != null) {
          //   teamsController.clearSelection();
          // }

        },
        onLongPress: () {
          teamsController.selectMessage(message);
          teamsController.showChatOptions(context, message);
        },

        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 8),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.grey.shade300 : Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  ClipOval(
                    child: Image.network(
                      message['avatar'] ?? 'https://via.placeholder.com/150',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sender + timestamp
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                message['sender'] ?? 'Unknown',
                                style: const TextStyle(
                                  fontFamily: AppFonts.interBold,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              formattedTime,
                              style: TextStyle(
                                fontFamily: AppFonts.interRegular,
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),

                        // Message type handling
                        if (type == null || type == 'text') ...[
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
                        ] else if (type == 'photo') ...[
                          GestureDetector(
                            onTap: () {
                              Get.to(() =>
                                  TeamImageDetailPage(imageUrl: message['message']));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                message['message'] ?? '',
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 200,
                                    height: 200,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.broken_image,
                                        color: Colors.red),
                                  );
                                },
                              ),
                            ),
                          ),
                        ] else if (type == 'link') ...[
                          GestureDetector(
                            onTap: () {

                            },
                            child: Text(
                              message['message'] ?? '',
                              style: const TextStyle(
                                fontFamily: AppFonts.interRegular,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ] else if (type == 'document') ...[
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.insert_drive_file, color: Colors.blue),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message['fileName'] ?? 'Unknown file',
                                        style: const TextStyle(
                                          fontFamily: AppFonts.interBold,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        message['fileSize'] ?? '',
                                        style: const TextStyle(
                                          fontFamily: AppFonts.interRegular,
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
