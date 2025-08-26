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
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "$teamName Info",
            style: TextStyle(
              fontFamily: AppFonts.interBold,
              color: Colors.white,
              fontSize: width * 0.045, // responsive font size
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: width * 0.06),
            onPressed: () => Get.back(),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Constant Team Name Row
              Container(
                width: double.infinity,
                color: Colors.black,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      teamName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.05, // responsive font size
                        fontFamily: AppFonts.interRegular,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.03),
                      child: Container(
                        padding: EdgeInsets.all(width * 0.015),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.message,
                          color: Colors.white,
                          size: width * 0.05, // responsive icon
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 🔹 Tabs with black background + min height
              Container(
                color: Colors.black,
                constraints: BoxConstraints(minHeight: height * 0.02),
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
      ),
    );
  }
}
