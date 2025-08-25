import 'package:adventure_app/themes/theme1/admin/super%20admin%20home/Tabs/team/view/view_tabs/documents_tab.dart';
import 'package:adventure_app/themes/theme1/admin/super%20admin%20home/Tabs/team/view/view_tabs/links_tab.dart';
import 'package:adventure_app/themes/theme1/admin/super%20admin%20home/Tabs/team/view/view_tabs/photos_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../core/utils/style/app_fonts.dart';

class PinnedFilesPage extends StatelessWidget {
  final String teamName;

  const PinnedFilesPage({super.key, required this.teamName});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "$teamName Info",
            style: const TextStyle(
              fontFamily: AppFonts.interBold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Constant Team Name Row
            Container(
              width: double.infinity,
              color: Colors.black,
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    teamName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: AppFonts.interRegular,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Tabs with black background + min height
            Container(
              color: Colors.black,
              constraints: const BoxConstraints(minHeight: 48), // 👈 minimum height
              child: const TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: "Photos"),
                  Tab(text: "Documents"),
                  Tab(text: "Links"),
                ],
              ),
            ),

            // 🔹 Tab Views
            Expanded(
              child: TabBarView(
                children: [
                  PhotosTab(teamName: teamName),
                  DocumentsTab(teamName: teamName),
                  LinksTab(teamName: teamName),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
