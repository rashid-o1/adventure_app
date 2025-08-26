// New file: contact_message_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../core/utils/style/app_fonts.dart';

class ContactMessagePage extends StatelessWidget {
  final Map<String, String> contactData;

  const ContactMessagePage({super.key, required this.contactData});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final String contactName = contactData['name'] ?? 'Contact'; // Get the contact name

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          contactData['email'] ?? "",
          style: TextStyle(
            fontFamily: AppFonts.interRegular,
            fontSize: width * 0.045,
            color: Colors.black,
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                "Your contact hasn't joined yet. Once signed up, they will receive your messages.",
                style: TextStyle(
                  fontFamily: AppFonts.interRegular,
                  color: Colors.white,
                  fontSize: width * 0.035,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // This is the contact's avatar. The second letter is the first letter of their name.
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(contactData['avatar']!),
                    radius: width * 0.1,
                  ),
                  SizedBox(height: width * 0.02),
                  SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.1,
                        vertical: width * 0.03,
                      ),
                    ),
                    child: Text(
                      "Resend Invite",
                      style: TextStyle(
                        fontFamily: AppFonts.interRegular,
                        color: Colors.black,
                        fontSize: width * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // This is the sent message bubble, mimicking the UI from the image.
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // Update the message text to use the dynamic contact name
                          child: Text(
                            "Hi $contactName, please accept invitation.",
                            style: TextStyle(
                              fontFamily: AppFonts.interRegular,
                              fontSize: width * 0.04,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "11:08 PM",
                          style: TextStyle(
                            fontFamily: AppFonts.interRegular,
                            fontSize: width * 0.025,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  suffixIcon: const Icon(Icons.send),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
