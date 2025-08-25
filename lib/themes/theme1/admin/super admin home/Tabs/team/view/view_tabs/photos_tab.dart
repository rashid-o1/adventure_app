import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../../core/utils/style/app_fonts.dart';
import '../../controller/team_controller.dart';
import 'package:intl/intl.dart';

class PhotosTab extends StatelessWidget {
  final String teamName;
  const PhotosTab({super.key, required this.teamName});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TeamController>();

    // ✅ Filter only photo messages
    final photos = controller.chatMessages[teamName]
        ?.where((msg) =>
    msg.containsKey('contentType') && msg['contentType'] == 'photo')
        .toList() ??
        [];

    // ✅ Group photos by timestamp
    final groupedPhotos = <String, List<Map<String, dynamic>>>{};
    for (var photo in photos) {
      final timestamp = photo['timestamp'];
      if (timestamp == null) continue;

      final group = _getPhotoGroup(timestamp);
      groupedPhotos.putIfAbsent(group, () => []);
      groupedPhotos[group]!.add(photo);
    }

    if (groupedPhotos.isEmpty) {
      return const Center(
        child: Text(
          "No photos found",
          style: TextStyle(fontFamily: AppFonts.interRegular, fontSize: 14),
        ),
      );
    }

    // Define a custom sort order for the groups
    final sortOrder = ["Today", "This Week", "This Month", "Older"];

    // ✅ Get a sorted list of map entries based on the custom sort order
    final sortedGroupedPhotos = groupedPhotos.entries.toList()
      ..sort((a, b) {
        final aIndex = sortOrder.indexOf(a.key);
        final bIndex = sortOrder.indexOf(b.key);
        return aIndex.compareTo(bIndex);
      });

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ✅ Use the sorted list for building the UI
          children: sortedGroupedPhotos.map((entry) {
            final groupTitle = entry.key;
            final photoList = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Group Title
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: Text(
                    groupTitle,
                    style: const TextStyle(
                      fontFamily: AppFonts.interBold,
                      fontSize: 16,
                    ),
                  ),
                ),

                // 🔹 Photo Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: photoList.length,
                  itemBuilder: (context, index) {
                    final photo = photoList[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        photo['message'] ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image,
                                color: Colors.red),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  /// ✅ Fixed grouping by accepting DateTime objects
  String _getPhotoGroup(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inDays < 1) {
      return "Recent";
    } else if (diff.inDays < 7) {
      return "This Week";
    } else if (diff.inDays < 30) {
      return "This Month";
    } else {
      return "Older";
    }
  }
}
