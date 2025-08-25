import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../../../../../../../../core/utils/style/app_fonts.dart';
import '../../controller/team_controller.dart';


class LinksTab extends StatelessWidget {
  final String teamName;
  const LinksTab({super.key, required this.teamName});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TeamController>();
    // Filter the chat messages to get only the ones with contentType 'link'
    final links = controller.chatMessages[teamName]?.where((msg) => msg.containsKey('contentType') && msg['contentType'] == 'link').toList() ?? [];

    // Sort links by timestamp to display the latest first
    links.sort((a, b) => (b['timestamp'] as DateTime).compareTo(a['timestamp'] as DateTime));

    if (links.isEmpty) {
      return const Center(
        child: Text(
          "No links found",
          style: TextStyle(fontFamily: AppFonts.interRegular, fontSize: 14),
        ),
      );
    }

    return ListView.builder(
      itemCount: links.length,
      itemBuilder: (context, index) {
        final link = links[index];
        // Correctly cast timestamp to DateTime and format it
        final timestamp = link['timestamp'] as DateTime;
        final formattedTimestamp = DateFormat('MMM d, h:mm a').format(timestamp);

        // ✅ Wrap the ListTile and a Divider in a Column
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.link, color: Colors.grey),
                // Safely access linkTitle, using the link message as a fallback
                title: Text(
                  link['linkTitle'] ?? link['message'] ?? 'Unknown Link',
                  style: const TextStyle(fontFamily: AppFonts.interRegular, fontSize: 14),
                ),
                subtitle: Text(
                  link['message']!,
                  style: const TextStyle(fontSize: 12, color: Colors.blue),
                ),
                // Display the formatted timestamp
                trailing: Text(
                  formattedTimestamp,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ),
            // ✅ Add a Divider after each ListTile
            const Divider(height: 1, thickness: 1, color: Colors.black12),
          ],
        );
      },
    );
  }
}
