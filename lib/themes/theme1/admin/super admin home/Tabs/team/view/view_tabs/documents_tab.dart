import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../../../../core/utils/style/app_fonts.dart';
import '../../controller/team_controller.dart';

class DocumentsTab extends StatelessWidget {
  final String teamName;
  const DocumentsTab({super.key, required this.teamName});

  // Helper function to get the document grouping title
  String _getDocGroup(DateTime timestamp) {
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

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TeamController>();
    final documents = controller.chatMessages[teamName]?.where((msg) => msg.containsKey('contentType') && msg['contentType'] == 'document').toList() ?? [];

    // Group documents by time
    final groupedDocuments = <String, List<Map<String, dynamic>>>{};
    for (var doc in documents) {
      final timestamp = doc['timestamp'] as DateTime;
      final group = _getDocGroup(timestamp);
      if (!groupedDocuments.containsKey(group)) {
        groupedDocuments[group] = [];
      }
      groupedDocuments[group]!.add(doc);
    }

    // Sort the documents within each group by timestamp (latest first)
    groupedDocuments.forEach((key, value) {
      value.sort((a, b) => (b['timestamp'] as DateTime).compareTo(a['timestamp'] as DateTime));
    });

    // Define a custom sort order for the groups
    final sortOrder = ["Recent", "This Week", "This Month", "Older"];
    final sortedGroupedDocuments = groupedDocuments.entries.toList()
      ..sort((a, b) {
        final aIndex = sortOrder.indexOf(a.key);
        final bIndex = sortOrder.indexOf(b.key);
        return aIndex.compareTo(bIndex);
      });

    if (groupedDocuments.isEmpty) {
      return const Center(
        child: Text(
          "No documents found",
          style: TextStyle(fontFamily: AppFonts.interRegular, fontSize: 14),
        ),
      );
    }

    return ListView(
      children: sortedGroupedDocuments.map((entry) {
        final groupTitle = entry.key;
        final docList = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
              child: Text(
                groupTitle,
                style: const TextStyle(
                  fontFamily: AppFonts.interBold,
                  fontSize: 16,
                ),
              ),
            ),
            ...docList.map((doc) => Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
                  leading: const Icon(Icons.file_copy, color: Colors.grey),
                  title: Text(
                    doc['fileName']!,
                    style: const TextStyle(fontFamily: AppFonts.interRegular),
                  ),
                  subtitle: Text(
                    "${doc['fileSize']}",
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: const Icon(Icons.download, color: Colors.grey),
                ),
                // ✅ Add a Divider after each document ListTile
                const Divider(height: 1, thickness: 1, color: Colors.black12),
              ],
            )).toList(),
          ],
        );
      }).toList(),
    );
  }
}
