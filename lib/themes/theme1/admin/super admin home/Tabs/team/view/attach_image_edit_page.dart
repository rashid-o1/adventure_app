import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adventure_app/core/utils/style/app_fonts.dart';

class AttachImageEditorPage extends StatelessWidget {
  final String imageUrl;

  const AttachImageEditorPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // The image display
          Center(
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Text(
                    "Image not found.",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),

          // Top bar with icons
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel/Cross Button
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () {
                    Get.back();
                  },
                ),
                Row(
                  children: [
                    // Text Button
                    IconButton(
                      icon: const Icon(Icons.text_fields, color: Colors.white, size: 30),
                      onPressed: () {
                        // TODO: Implement logic for adding text on the photo
                        Get.snackbar(
                          "Coming Soon!",
                          "Text editing functionality will be added here.",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                    ),
                    // Marker/Draw Button
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white, size: 30),
                      onPressed: () {
                        // TODO: Implement logic for drawing on the photo
                        Get.snackbar(
                          "Coming Soon!",
                          "Drawing functionality will be added here.",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bottom send button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                // TODO: Implement logic to send the edited image
                Get.snackbar(
                  "Sent!",
                  "Image sent successfully.",
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.send, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
