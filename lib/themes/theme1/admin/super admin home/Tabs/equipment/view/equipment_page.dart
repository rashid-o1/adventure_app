import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../core/utils/style/app_fonts.dart';
import '../controller/equipment_controller.dart';

class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EquipmentController equipmentController = Get.put(EquipmentController());

    return Scaffold(

      body: Obx(() {
        if (equipmentController.equipmentList.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search here!",
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black, width: 1.8), // 👈 black border on input
                      ),
                      contentPadding: const EdgeInsets.all(16.0),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  itemCount: equipmentController.equipmentList.length,
                  itemBuilder: (context, index) {
                    final item = equipmentController.equipmentList[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['teamName'] ?? '',
                                      style: const TextStyle(
                                        fontFamily: AppFonts.interBold,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      item['description'] ?? '',
                                      style: TextStyle(
                                        fontFamily: AppFonts.interRegular,
                                        fontSize: 14,
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
                        const Divider(height: 1), // 👈 divider after each item (including last)
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          // Placeholder UI for no equipment
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "No Equipment of teams yet",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppFonts.interBold,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  "Team equipments will be displayed here",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFonts.interRegular,
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
