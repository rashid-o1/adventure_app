import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../core/utils/style/app_fonts.dart';
import '../controller/equipment_controller.dart';

class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EquipmentController equipmentController = Get.put(EquipmentController());
    final Size size = MediaQuery.of(context).size; // 📱 screen size

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (equipmentController.equipmentList.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Padding(
                padding: EdgeInsets.all(size.width * 0.04), // responsive padding
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(size.width * 0.05),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search here!",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: size.width * 0.04),
                      suffixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(size.width * 0.05),
                        borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(size.width * 0.05),
                        borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(size.width * 0.05),
                        borderSide: const BorderSide(color: Colors.black, width: 1.8),
                      ),
                      contentPadding: EdgeInsets.all(size.width * 0.04),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  itemCount: equipmentController.equipmentList.length,
                  itemBuilder: (context, index) {
                    final item = equipmentController.equipmentList[index];
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.01,
                            horizontal: size.width * 0.03,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['teamName'] ?? '',
                                      style: TextStyle(
                                        fontFamily: AppFonts.interBold,
                                        fontSize: size.width * 0.045,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.005),
                                    Text(
                                      item['description'] ?? '',
                                      style: TextStyle(
                                        fontFamily: AppFonts.interRegular,
                                        fontSize: size.width * 0.04,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Edit Pop-up Menu
                              PopupMenuButton<String>(
                                onSelected: (String result) {
                                  if (result == 'edit') {
                                    // Handle "Edit" action
                                  }
                                },
                                color: Colors.grey[100],
                                itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    height: 20,
                                    value: 'edit',
                                    child: SizedBox(
                                      width: 70,
                                      child: Text('Edit'),
                                    ),
                                  ),
                                ],
                                icon: const Icon(Icons.more_vert, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          // Placeholder UI for no equipment
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Equipment of teams yet",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFonts.interBold,
                      fontSize: size.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    "Team equipments will be displayed here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFonts.interRegular,
                      fontSize: size.width * 0.045,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
