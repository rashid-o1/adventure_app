import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../view/attach_image_edit_page.dart';
import '../view/pdf_preview_page.dart';
import '../view/contact_message_page.dart';

class TeamController extends GetxController {
  final isSearching = false.obs;
  final searchQuery = "".obs;
  final RxMap<String, bool> isMuted = <String, bool>{}.obs;
  final RxList<Map<String, String>> members = <Map<String, String>>[].obs;
  final Rx<Map<String, dynamic>?> selectedMessage = Rx<Map<String, dynamic>?>(null);
  final Map<String, String> senderEmails = {
    'Zohaib': 'zohaib.01@email.com',
    'Paul': 'paul.02@email.com',
    'Hafsa': 'hafsa.03@email.com',
    'Ali': 'ali.04@email.com',
    'Faraz': 'faraz.05@email.com',
    'Iqra': 'iqra.06@email.com',
    'Jawad': 'jawad.07@email.com',
    'Raheem': 'raheem.08@email.com',
    'Areeba': 'areeba.09@email.com',
    'Hassan': 'hassan.10@email.com',
    'Huma Noor': 'huma.11@email.com',
  };

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

  final Rx<String?> imagePath = Rx<String?>(null);

  String formatDate(DateTime date) {
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

  void processMembers(String teamName) {
    members.clear();
    final chatData = chatMessages[teamName] ?? [];
    final Set<String> addedNames = {};
    final List<Map<String, String>> teamMembers = [];

    final creator = teams.firstWhere(
            (team) => team['name'] == teamName,
        orElse: () => {'description': ''})['description']?.split(" ").first;

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

  void showEmailOptionsBottomSheet() {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOptionTile("Send a New Email", () {
                Get.back();
              }, icon: Icons.email_outlined),
              _buildOptionTile("Send to Members List", () {
                Get.back();
              }, icon: Icons.group_outlined),
              _buildOptionTile("View Past Emails", () {
                Get.back();
              }, icon: Icons.history),
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  void showAttachBottomSheet(BuildContext context) {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
              _buildOptionTile("Attach files", () {
                Get.back();
                _pickFiles();
              }, icon: Icons.insert_drive_file),
              _buildOptionTile("Attach photo or videos", () {
                Get.back();
                _pickMedia(ImageSource.gallery);
              }, icon: Icons.image_outlined),
              _buildOptionTile("Take a photo", () {
                Get.back();
                _pickMedia(ImageSource.camera);
              }, icon: Icons.photo_camera_outlined),
            ],
          ),
        ),
      ),
    );
  }



  Future<void> _pickMedia(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? media;

      if (source == ImageSource.camera) {
        media = await picker.pickImage(source: source);
      } else {
        media = await picker.pickMedia();
      }

      if (media?.path != null) {
        // Check if it's an image file before proceeding
        if (media!.path.endsWith('.mp4') || media.path.endsWith('.mov')) {
          final result = await Get.to<String>(() => AttachImageEditorPage(filePath: media!.path));
          // You can handle the video path here if needed
        } else {
          // Handle the potential for invalid image data
          try {
            final editedImagePath = await Get.to<String>(
                  () => AttachImageEditorPage(filePath: media!.path),
            );

            if (editedImagePath != null) {
              imagePath.value = editedImagePath;
            } else {
              imagePath.value = media.path;
            }
            sendImagePreview(imagePath.value!, "Team 01");
          } catch (e) {
            // Catch the specific error from the image editor
            Get.snackbar("Error", "Could not load image. Please try a different one.");
            print("Error in image editor: $e");
          }
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Could not access media. Please check your app's permissions.",
        snackPosition: SnackPosition.BOTTOM,
      );
      print("Error picking media: $e");
    }
  }

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'xlsx', 'pptx'],
      );

      if (result != null) {
        final platformFile = result.files.first;
        if (platformFile.extension?.toLowerCase() == 'pdf') {
          Get.to(() => PdfPreviewPage(path: platformFile.path!));
        } else {
          Get.snackbar("File Sent", "${platformFile.name} sent successfully.");
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Could not pick the file. Please check your app's permissions.",
        snackPosition: SnackPosition.BOTTOM,
      );
      print("Error picking file: $e");
    }
  }

  void sendImagePreview(String imagePath, String teamName) {
    if (imagePath.isNotEmpty) {
      chatMessages[teamName]?.add({
        'sender': 'Hassan', // Use a real sender or a placeholder
        'contentType': 'photo',
        'message': imagePath,
        'timestamp': DateTime.now(),
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
      });
      update();
    }
  }

  void showMemberOptionsDialog(Map<String, String> member) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOptionTile("Message ${member['name']}", () {
              Get.back();
              final memberEmail = senderEmails[member['name']];
              final Map<String, String> contactDataWithEmail = Map.from(member);
              if (memberEmail != null) {
                contactDataWithEmail['email'] = memberEmail;
              }
              Get.to(() => ContactMessagePage(contactData: contactDataWithEmail));
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
        style: const TextStyle(fontSize: 14),
      ),
      onTap: onTap,
    );
  }

  void updateMemberRole(String memberName, String newRole) {
    final index = members.indexWhere((member) => member['name'] == memberName);
    if (index != -1) {
      final updatedMember = Map<String, String>.from(members[index]);
      updatedMember['role'] = newRole;
      members[index] = updatedMember;
      members.refresh();
    }
  }

  void showChatOptions(BuildContext context, Map<String, dynamic> message) {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOptionTile("Quote message", () {
                Get.back();
              }, icon: Icons.format_quote),
              _buildOptionTile("Forward message", () {
                Get.back();
              }, icon: Icons.shortcut),
              _buildOptionTile("Edit message", () {
                Get.back();
              }, icon: Icons.edit),
              _buildOptionTile("Copy", () {
                _copyMessage(message['message'] ?? '');
                Get.back();
              }, icon: Icons.copy),
              _buildOptionTile("Pin", () {
                Get.back();
              }, icon: Icons.push_pin_outlined),
              _buildOptionTile("Delete message", () {
                _deleteMessage(message);
                Get.back();
              }, icon: Icons.delete_outline),
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ).whenComplete(() {
      clearSelection();
    });
  }

  void selectMessage(Map<String, dynamic> message) {
    selectedMessage.value = message;
  }

  void clearSelection() {
    selectedMessage.value = null;
  }

  void _copyMessage(String text) {
    Get.snackbar("Copied!", "Message copied to clipboard.");
  }

  void _deleteMessage(Map<String, dynamic> message) {
    Get.snackbar("Deleted!", "Message has been deleted.");
  }
}