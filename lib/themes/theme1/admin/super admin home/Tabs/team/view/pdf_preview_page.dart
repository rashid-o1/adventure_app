import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

class PdfPreviewPage extends StatelessWidget {
  final String path;

  const PdfPreviewPage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    // Check if the file exists before trying to display it
    final fileExists = File(path).existsSync();

    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: fileExists
          ? PDFView(
        filePath: path,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: false,
        onError: (error) {
          Get.snackbar("Error", "Failed to load PDF: $error", snackPosition: SnackPosition.BOTTOM);
        },
      )
          : const Center(
        child: Text(
          'File not found.',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add logic to send the file.
          // This will go back to the chat and show a confirmation.
          Get.back();
          Get.snackbar("File Sent", "PDF sent successfully.");
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.send, color: Colors.black),
      ),
    );
  }
}