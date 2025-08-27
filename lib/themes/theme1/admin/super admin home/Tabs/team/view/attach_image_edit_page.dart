// In attach_image_editor_page.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:image_painter/image_painter.dart';
import 'package:path_provider/path_provider.dart';

class AttachImageEditorPage extends StatefulWidget {
  final String filePath;

  const AttachImageEditorPage({super.key, required this.filePath});

  @override
  State<AttachImageEditorPage> createState() => _AttachImageEditorPageState();
}

class _AttachImageEditorPageState extends State<AttachImageEditorPage> {
  VideoPlayerController? _videoController;
  final _imagePainterController = ImagePainterController();
  final GlobalKey<ImagePainterState> _imagePainterKey = GlobalKey<ImagePainterState>();
  bool _isVideo = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isVideo = widget.filePath.endsWith('.mp4') || widget.filePath.endsWith('.mov');
    if (_isVideo) {
      _videoController = VideoPlayerController.file(File(widget.filePath))
        ..initialize().then((_) {
          setState(() {});
          _videoController?.play();
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _imagePainterController.dispose(); // This is correct
    super.dispose();
  }

  Future<void> _saveAndSendImage() async {
    // Check if the widget is still mounted before proceeding with any async operations
    if (!mounted) return;

    final imageBytes = await _imagePainterController.exportImage();
    if (imageBytes != null) {
      final editedImagePath = await _saveImageToFile(imageBytes);
      Get.back(result: editedImagePath);
    } else {
      // If image export fails, go back without a result
      Get.back();
    }
  }

  Future<String> _saveImageToFile(Uint8List imageBytes) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final String fileName = '${DateTime.now().toIso8601String()}.png';
    final File file = File('$appDocPath/$fileName');
    await file.writeAsBytes(imageBytes);
    return file.path;
  }

  void _toggleEditingMode() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        _imagePainterController.setMode(PaintMode.none);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _isVideo
                ? (_videoController != null && _videoController!.value.isInitialized
                ? AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: VideoPlayer(_videoController!),
            )
                : const CircularProgressIndicator(color: Colors.white))
                : ImagePainter.file(
              File(widget.filePath),
              key: _imagePainterKey,
              controller: _imagePainterController,
              scalable: true,
            ),
          ),

          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () {
                    Get.back(); // Go back without a result
                  },
                ),
                if (!_isVideo)
                  Row(
                    children: [
                      if (!_isEditing)
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.text_fields, color: Colors.white, size: 30),
                              onPressed: _toggleEditingMode,
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white, size: 30),
                              onPressed: _toggleEditingMode,
                            ),
                          ],
                        ),
                      if (_isEditing)
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.white, size: 30),
                          onPressed: _toggleEditingMode,
                        ),
                    ],
                  ),
              ],
            ),
          ),

          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                if (_isVideo) {
                  Get.back(result: widget.filePath);
                } else {
                  _saveAndSendImage();
                }
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.send, color: Colors.black),
            ),
          ),

          if (!_isVideo && _isEditing)
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.text_fields, color: Colors.white, size: 30),
                        onPressed: () {
                          _imagePainterController.setMode(PaintMode.text);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white, size: 30),
                        onPressed: () {
                          _imagePainterController.setMode(PaintMode.freeStyle);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}