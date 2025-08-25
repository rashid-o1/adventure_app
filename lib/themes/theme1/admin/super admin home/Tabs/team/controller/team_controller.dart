import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adventure_app/core/utils/style/app_fonts.dart';

class TeamController extends GetxController {
  final isSearching = false.obs;
  final searchQuery = "".obs;
  final RxMap<String, bool> isMuted = <String, bool>{}.obs;
  final RxList<Map<String, String>> members = <Map<String, String>>[].obs;
  final Rx<Map<String, dynamic>?> selectedMessage = Rx<Map<String, dynamic>?>(null);


  final RxList<Map<String, String>> teams = <Map<String, String>>[
    {
      'name': 'Team 01',
      'description': 'Zohaib create a team',
      'avatar':
      'https://4kwallpapers.com/images/wallpapers/atlanta-falcons-2560x1440-23570.jpg',
    },
    {
      'name': 'Team 02',
      'description': 'Ali create a team',
      'avatar':
      'https://tse2.mm.bing.net/th/id/OIP.NiVj66aYfZKqb6xwVKBbMwAAAA?rs=1&pid=ImgDetMain&o=7&rm=3',
    },
    {
      'name': 'Team 03',
      'description': 'Jawad create a team',
      'avatar':
      'https://4kwallpapers.com/images/wallpapers/atlanta-falcons-2560x1440-23570.jpg',
    },
    {
      'name': 'Team 04',
      'description': 'Hassan create a team',
      'avatar':
      'https://tse1.mm.bing.net/th/id/OIP.PMSG8Y2QcHx8nimCQobztgHaH1?rs=1&pid=ImgDetMain&o=7&rm=3',
    },
  ].obs;

  final Map<String, List<Map<String, dynamic>>> chatMessages = {
    'Team 01': [
      {
        'sender': 'Zohaib',
        'message': 'Hello Paul. How are you?',
        'timestamp': DateTime(2025, 8, 20, 21, 45),
        'avatar': 'https://randomuser.me/api/portraits/men/1.jpg',
      },
      {
        'sender': 'Zohaib',
        'message': 'Are you available today?',
        'timestamp': DateTime(2025, 8, 21, 23, 06),
        'avatar': 'https://randomuser.me/api/portraits/men/1.jpg',
      },
      {
        'sender': 'Paul',
        'message': "Hi Zohaib, I'm good!",
        'timestamp': DateTime(2025, 8, 21, 23, 09),
        'avatar': 'https://randomuser.me/api/portraits/men/5.jpg',
      },
      {
        'sender': 'Paul',
        'message': "Yeah, I'm available.",
        'timestamp': DateTime(2025, 8, 21, 23, 09),
        'avatar': 'https://randomuser.me/api/portraits/men/5.jpg',
      },
      {
        'sender': 'Zohaib',
        'message': "Great, let's meet at 3 PM.",
        'timestamp': DateTime(2025, 8, 22, 22, 15),
        'avatar': 'https://randomuser.me/api/portraits/men/1.jpg',
      },
      {
        'sender': 'Hafsa',
        'message': "I'm also available at that time.",
        'timestamp': DateTime(2025, 8, 22, 23, 19),
        'avatar': 'https://randomuser.me/api/portraits/women/17.jpg',
      },
    ],
    'Team 02': [
      {
        'sender': 'Ali',
        'message': 'Meeting is at 2 PM.',
        'timestamp': DateTime(2025, 8, 23, 10, 00),
        'avatar': 'https://randomuser.me/api/portraits/men/9.jpg',
      },
      {
        'sender': 'Faraz',
        'message': "Got it. I'll be there.",
        'timestamp': DateTime(2025, 8, 23, 10, 06),
        'avatar': 'https://randomuser.me/api/portraits/men/6.jpg',
      },
      {
        'sender': 'Ali',
        'message': "Today, Don't be late!",
        'timestamp': DateTime(2025, 8, 25, 11, 09),
        'avatar': 'https://randomuser.me/api/portraits/men/9.jpg',
      },
      {
        'sender': 'Iqra',
        'message': "I won't. See you soon.",
        'timestamp': DateTime(2025, 8, 25, 11, 10),
        'avatar': 'https://randomuser.me/api/portraits/women/11.jpg',
      },
      {
        'sender': 'Faraz',
        'message': "Perfect.",
        'timestamp': DateTime(2025, 8, 25, 11, 14),
        'avatar': 'https://randomuser.me/api/portraits/men/6.jpg',
      },
    ],
    'Team 03': [
      {
        'sender': 'Jawad',
        'message': 'Project deadline is tomorrow.',
        'timestamp': DateTime(2025, 8, 22, 09, 00),
        'avatar': 'https://randomuser.me/api/portraits/men/3.jpg',
      },
      {
        'sender': 'Raheem',
        'message': "Working on it now.",
        'timestamp': DateTime(2025, 8, 22, 09, 05),
        'avatar': 'https://randomuser.me/api/portraits/men/7.jpg',
      },
      {
        'sender': 'Jawad',
        'message': "Let me know if you need any help.",
        'timestamp': DateTime(2025, 8, 24, 09, 10),
        'avatar': 'https://randomuser.me/api/portraits/men/3.jpg',
      },
      {
        'sender': 'Raheem',
        'message': "Thanks! I'm almost done.",
        'timestamp': DateTime(2025, 8, 24, 09, 20),
        'avatar': 'https://randomuser.me/api/portraits/men/7.jpg',
      },
      {
        'sender': 'Areeba',
        'message': "Good to hear.",
        'timestamp': DateTime(2025, 8, 25, 09, 25),
        'avatar': 'https://randomuser.me/api/portraits/women/19.jpg',
      },
    ],
    'Team 04': [
      {
        'sender': 'Hassan',
        'message': 'Report submitted.',
        'timestamp': DateTime(2025, 8, 21, 13, 00),
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
      },
      {
        'sender': 'Hassan',
        'message': "Let's start on the next task.",
        'timestamp': DateTime(2025, 8, 22, 13, 05),
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
      },
      {
        'sender': 'Hassan',
        'message': "Anyone online?",
        'timestamp': DateTime(2025, 8, 24, 13, 07),
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
      },
      {
        'sender': 'Huma Noor',
        'message': "I'm here.",
        'timestamp': DateTime(2025, 8, 24, 13, 14),
        'avatar': 'https://randomuser.me/api/portraits/women/8.jpg',
      },
      {
        'sender': 'Hassan',
        'message': "I guess I'll start myself.",
        'timestamp': DateTime(2025, 8, 24, 13, 15),
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
      },
      {
        'sender': 'Hassan',
        'contentType': 'photo',
        'message':
        'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
        'timestamp': DateTime(2025, 8, 25, 13, 20),
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
      },
      {
        'sender': 'Hassan',
        'contentType': 'photo',
        'message':
        'https://images.unsplash.com/photo-1549880338-65ddcdfd017b?ixlib=rb-1.2.1&q=80&fm=jpg',
        'timestamp': DateTime(2025, 8, 17, 13, 21),
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
      },
      {
        'sender': 'Hassan',
        'contentType': 'photo',
        'message':
        'https://images.unsplash.com/photo-1549880338-65ddcdfd017b?ixlib=rb-1.2.1&q=80&fm=jpg',
        'timestamp': DateTime(2025, 8, 18, 13, 21),
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
      },
      {
        'sender': 'Hassan',
        'contentType': 'photo',
        'message':
        'https://images.unsplash.com/photo-1549880338-65ddcdfd017b?ixlib=rb-1.2.1&q=80&fm=jpg',
        'timestamp': DateTime(2025, 8, 23, 13, 21),
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
      },
      {
        'sender': 'Hassan',
        'contentType': 'photo',
        'message':
        'https://tse4.mm.bing.net/th/id/OIP.qDvAlhidTBzXiGyDfq_O0gHaE7?rs=1&pid=ImgDetMain',
        'timestamp': DateTime(2025, 8, 25, 13, 22),
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
      },
      {
        'sender': 'Huma Noor',
        'contentType': 'document',
        'fileName': 'Tour Guide.pdf',
        'fileSize': '1.2 MB',
        'timestamp': DateTime(2025, 8, 25, 13, 25),
        'avatar': 'https://randomuser.me/api/portraits/women/8.jpg',
      },
      {
        'sender': 'Hassan',
        'contentType': 'document',
        'fileName': 'Meeting Notes.docx',
        'fileSize': '250 KB',
        'timestamp': DateTime(2025, 8, 25, 13, 26),
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
      },
      {
        'sender': 'Huma Noor',
        'contentType': 'link',
        'message': 'https://flutter.dev/',
        'linkTitle': 'Flutter Official Website',
        'timestamp': DateTime(2025, 8, 25, 13, 30),
        'avatar': 'https://randomuser.me/api/portraits/women/8.jpg',
      },
    ],
  };

  void processMembers(String teamName) {
    members.clear();

    final chatData = chatMessages[teamName] ?? [];
    final Set<String> addedNames = {};
    final List<Map<String, String>> teamMembers = [];

    final creator = teams.firstWhere(
            (team) => team['name'] == teamName,
        orElse: () => {'description': ''}
    )['description']?.split(" ").first;

    if (creator != null && creator.isNotEmpty) {
      final creatorAvatar = chatData.firstWhere(
            (msg) => msg['sender'] == creator,
        orElse: () => {"avatar": "https://via.placeholder.com/150"},
      )['avatar'];

      teamMembers.add({
        "name": creator,
        "avatar": creatorAvatar!,
        "role": "Admin",
      });
      addedNames.add(creator);
    }

    for (var msg in chatData) {
      final sender = msg['sender'] ?? "";
      if (sender.isNotEmpty && !addedNames.contains(sender)) {
        teamMembers.add({
          "name": sender,
          "avatar": msg['avatar'] ?? "https://via.placeholder.com/150",
          "role": "Client",
        });
        addedNames.add(sender);
      }
    }
    members.value = teamMembers;
  }

  //  dialog and logic for member options
  void showMemberOptionsDialog(Map<String, String> member) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // 🔹 slightly low circular
        ),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOptionTile("Message ${member['name']}", () {
              Get.back();
            }),
            _buildOptionTile("View ${member['name']}", () {
              Get.back();
            }),
            if (member['role'] == "Client")
              _buildOptionTile("Make group admin", () {
                updateMemberRole(member['name']!, "Admin");
                Get.back();
              })
            else
              _buildOptionTile("Remove group admin", () {
                updateMemberRole(member['name']!, "Client");
                Get.back();
              }),
            _buildOptionTile("Remove ${member['name']}", () {
              Get.back();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(String title, VoidCallback onTap, {IconData? icon}) {
    return ListTile(
      dense: true,
      minVerticalPadding: 0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16,),
      leading: icon != null ? Icon(icon, color: Colors.black54,) : null,
      title: Text(
        title,
        style: const TextStyle(fontSize: 14), // 🔹 compact font
      ),
      onTap: onTap,
    );
  }

  // function to update a member's role.
  void updateMemberRole(String memberName, String newRole) {
    final index = members.indexWhere((member) => member['name'] == memberName);
    if (index != -1) {
      final updatedMember = Map<String, String>.from(members[index]);
      updatedMember['role'] = newRole;
      members[index] = updatedMember;
      members.refresh();
    }
  }

  // New methods for handling chat message options
  void showChatOptions(BuildContext context, Map<String, dynamic> message) {
    // You can customize the bottom sheet UI here.
    Get.bottomSheet(
      Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOptionTile("Quote message", () {
              // TODO: Implement quote message logic
              Get.back();
            }, icon: Icons.format_quote),
            _buildOptionTile("Forward message", () {
              // TODO: Implement forward message logic
              Get.back();
            }, icon: Icons.shortcut),
            _buildOptionTile("Edit message", () {
              // TODO: Implement edit message logic
              Get.back();
            }, icon: Icons.edit),
            _buildOptionTile("Copy", () {
              // Call the copy logic in the controller
              _copyMessage(message['message'] ?? '');
              Get.back();
            }, icon: Icons.copy),
            _buildOptionTile("Pin", () {
              // TODO: Implement pin message logic
              Get.back();
            }, icon: Icons.push_pin_outlined),
            _buildOptionTile("Delete message", () {
              // Call the delete logic in the controller
              _deleteMessage(message);
              Get.back();
            }, icon: Icons.delete_outline),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ).whenComplete(() {
      // Clear the selection when the bottom sheet is dismissed.
      clearSelection();
    });
  }

  // New methods for managing message selection
  void selectMessage(Map<String, dynamic> message) {
    selectedMessage.value = message;
  }

  void clearSelection() {
    selectedMessage.value = null;
  }

  // New private methods to handle the actions
  void _copyMessage(String text) {

    Get.snackbar("Copied!", "Message copied to clipboard.");
  }

  void _deleteMessage(Map<String, dynamic> message) {

    Get.snackbar("Deleted!", "Message has been deleted.");
  }

}
