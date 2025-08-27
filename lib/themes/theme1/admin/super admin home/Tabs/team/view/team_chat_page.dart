import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:adventure_app/core/utils/style/app_fonts.dart';
import 'package:adventure_app/themes/theme1/admin/super%20admin%20home/Tabs/team/view/team_view_page.dart';
import 'package:adventure_app/themes/theme1/admin/super%20admin%20home/Tabs/team/view/view_tabs/team_image_detail_page.dart';
import 'package:adventure_app/themes/theme1/admin/super%20admin%20home/Tabs/team/controller/team_controller.dart';


class TeamChatPage extends StatelessWidget {
  final Map<String, String> teamData;
  final TextEditingController _messageController = TextEditingController();

  TeamChatPage({super.key, required this.teamData});

  @override
  Widget build(BuildContext context) {
    final TeamController teamsController = Get.find();
    final width = MediaQuery.of(context).size.width;

    // Reset searching state when entering the page
    teamsController.isSearching.value = false;
    teamsController.searchQuery.value = "";

    return Scaffold(
      appBar: _buildAppBar(context, teamsController, width),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchOrTitle(context, teamsController, width),
            Divider(thickness: 1, color: Colors.grey.shade300),
            _buildChatMessages(teamsController, width),
            _buildMessageInput(context, teamsController, _messageController, width),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  AppBar _buildAppBar(BuildContext context, TeamController teamsController, double width) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        teamData['name'] ?? "Team Chat",
        style: TextStyle(
          fontFamily: AppFonts.interRegular,
          fontSize: width * 0.045,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, size: width * 0.06),
        onPressed: () => Get.back(),
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == "Search") {
              teamsController.isSearching.value = true;
            } else if (value == "View") {
              Get.to(() => TeamViewPage(teamData: teamData));
            }
          },
          color: Colors.grey[100],
          itemBuilder: (BuildContext context) {
            final items = ['View', 'Search', 'Pinned files'];
            return items.map((item) {
              return PopupMenuItem<String>(
                value: item,
                height: width * 0.1,
                child: SizedBox(
                  width: width * 0.35,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontFamily: AppFonts.interRegular,
                      fontSize: width * 0.04,
                    ),
                  ),
                ),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  Widget _buildSearchOrTitle(BuildContext context, TeamController teamsController, double width) {
    return Padding(
      padding: EdgeInsets.all(width * 0.04),
      child: Obx(() {
        return teamsController.isSearching.value
            ? _buildSearchBar(teamsController, width)
            : Text(
          "Get Started",
          style: TextStyle(
            fontFamily: AppFonts.interBold,
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        );
      }),
    );
  }

  Widget _buildSearchBar(TeamController teamsController, double width) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(width * 0.05),
      ),
      child: TextField(
        onChanged: (value) => teamsController.searchQuery.value = value,
        decoration: InputDecoration(
          hintText: "Search here!",
          hintStyle: TextStyle(color: Colors.grey, fontSize: width * 0.04),
          suffixIcon: IconButton(
            icon: Icon(Icons.close, color: Colors.grey, size: width * 0.05),
            onPressed: () {
              teamsController.isSearching.value = false;
              teamsController.searchQuery.value = "";
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.05),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.05),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.05),
            borderSide: BorderSide(color: Colors.black, width: 1.8),
          ),
          contentPadding: EdgeInsets.all(width * 0.04),
        ),
      ),
    );
  }

  Widget _buildChatMessages(TeamController teamsController, double width) {
    final List<Map<String, dynamic>> chatMessages =
        teamsController.chatMessages[teamData['name']] ?? [];

    chatMessages.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

    final List<Widget> groupedMessagesWidgets = [];
    DateTime? lastDate;

    for (var message in chatMessages) {
      final messageDate = message['timestamp'] as DateTime;
      final currentDate = DateTime(messageDate.year, messageDate.month, messageDate.day);

      if (lastDate == null || currentDate != lastDate) {
        groupedMessagesWidgets.add(_DateHeader(date: teamsController.formatDate(currentDate)));
        lastDate = currentDate;
      }
      groupedMessagesWidgets.add(ChatMessage(message: message));
    }

    return Expanded(
      child: Obx(() {
        final query = teamsController.searchQuery.value.toLowerCase();
        final filteredMessages = query.isEmpty
            ? groupedMessagesWidgets
            : groupedMessagesWidgets.where((widget) {
          if (widget is ChatMessage) {
            final message = widget.message;
            return (message['message'] ?? '').toLowerCase().contains(query) ||
                (message['sender'] ?? '').toLowerCase().contains(query);
          }
          return false;
        }).toList();

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: width * 0.02),
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
    );
  }

  Widget _buildMessageInput(BuildContext context, TeamController teamsController, TextEditingController textController, double width) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1.0)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.attach_file, color: Colors.black, size: width * 0.06),
            onPressed: () {
              teamsController.showAttachBottomSheet(context);
            },
          ),
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: "Message...",
                hintStyle: TextStyle(
                    fontFamily: AppFonts.interRegular,
                    fontSize: width * 0.04,
                    color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * 0.05),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: width * 0.02),
              ),
              onSubmitted: (text) {
                // Add message sending logic here
                textController.clear();
              },
            ),
          ),
          SizedBox(width: width * 0.02),
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: width * 0.06,
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white, size: width * 0.05),
              onPressed: () {
                // Corrected code: Check for null and use the value
                if (teamsController.imagePath.value != null) {
                  teamsController.sendImagePreview(teamsController.imagePath.value!, teamData['name']!);
                } else {
                  // Handle the case where imagePath is null, e.g., send a text message
                  // teamsController.sendMessage(textController.text, teamData['name']!);
                  Get.snackbar("Error", "Please select an image or video to send.");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DateHeader extends StatelessWidget {
  final String date;
  const _DateHeader({required this.date});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final fontSize = width * 0.035;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.03),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: width * 0.015),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(width * 0.05),
          ),
          child: Text(
            date,
            style: TextStyle(
              fontFamily: AppFonts.interRegular,
              fontSize: fontSize,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final Map<String, dynamic> message;

  const ChatMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final TeamController teamsController = Get.find();
    final width = MediaQuery.of(context).size.width;

    final String? type = message['contentType'];
    final DateTime timestamp = message['timestamp'] as DateTime;
    final String formattedTime = DateFormat('h:mm a').format(timestamp);

    return Obx(() {
      final isSelected = teamsController.selectedMessage.value != null &&
          teamsController.selectedMessage.value!['timestamp'] ==
              message['timestamp'] &&
          teamsController.selectedMessage.value!['message'] ==
              message['message'];
      return GestureDetector(
        onTap: () {},
        onLongPress: () {
          teamsController.selectMessage(message);
          teamsController.showChatOptions(context, message);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.grey.shade300 : Colors.white,
              borderRadius: BorderRadius.circular(width * 0.025),
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.025),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.network(
                      message['avatar'] ?? 'https://via.placeholder.com/150',
                      width: width * 0.1,
                      height: width * 0.1,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: width * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                message['sender'] ?? 'Unknown',
                                style: TextStyle(
                                  fontFamily: AppFonts.interBold,
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.04,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: width * 0.02),
                            Text(
                              formattedTime,
                              style: TextStyle(
                                fontFamily: AppFonts.interRegular,
                                fontSize: width * 0.03,
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(height: width * 0.015),
                        if (type == null || type == 'text') ...[
                          Text(
                            message['message'] ?? '',
                            style: TextStyle(
                              fontFamily: AppFonts.interRegular,
                              fontSize: width * 0.04,
                            ),
                          ),
                          Text(
                            "See translation",
                            style: TextStyle(
                              fontFamily: AppFonts.interRegular,
                              fontSize: width * 0.025,
                              color: Colors.blue.shade600,
                            ),
                          ),
                        ] else if (type == 'photo') ...[
                          GestureDetector(
                            onTap: () {
                              Get.to(() => TeamImageDetailPage(
                                  imageUrl: message['message']));
                            },
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.circular(width * 0.02),
                              child: Image.network(
                                message['message'] ?? '',
                                width: width * 0.55,
                                height: width * 0.55,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: width * 0.55,
                                    height: width * 0.55,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.broken_image,
                                        color: Colors.red, size: width * 0.1),
                                  );
                                },
                              ),
                            ),
                          ),
                        ] else if (type == 'link') ...[
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              message['message'] ?? '',
                              style: TextStyle(
                                fontFamily: AppFonts.interRegular,
                                fontSize: width * 0.04,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ] else if (type == 'document') ...[
                          Container(
                            padding: EdgeInsets.all(width * 0.03),
                            margin: EdgeInsets.only(top: width * 0.015),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                              BorderRadius.circular(width * 0.02),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.insert_drive_file,
                                    color: Colors.blue, size: width * 0.06),
                                SizedBox(width: width * 0.02),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message['fileName'] ??
                                            'Unknown file',
                                        style: TextStyle(
                                          fontFamily: AppFonts.interBold,
                                          fontWeight: FontWeight.bold,
                                          fontSize: width * 0.04,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        message['fileSize'] ?? '',
                                        style: TextStyle(
                                          fontFamily: AppFonts.interRegular,
                                          fontSize: width * 0.03,
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