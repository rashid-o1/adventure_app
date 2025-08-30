import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../../core/utils/style/app_fonts.dart';
import '../../../admin_home/controller/super_admin_home_controller.dart';
import '../controller/events_controller.dart';
import 'event_cards.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EventsController eventsController = Get.put(EventsController());
    final SuperAdminHomeController superAdminController = Get.find();

    return FutureBuilder<String?>(
      future: SharedPreferences.getInstance().then((prefs) => prefs.getString('selectedRole')),
      builder: (context, snapshot) {
        final String? role = snapshot.data;
        final bool isTeamLeader = role == 'TeamLeader';
        print('EventsPage role: $role');

        return Obx(() {
          if (eventsController.events.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔍 Search Bar
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
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
                          borderSide: const BorderSide(color: Colors.black, width: 1.8),
                        ),
                        contentPadding: const EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                ),

                // 📌 Recent Heading
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Recent",
                    style: TextStyle(
                      fontFamily: AppFonts.interBold,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // 📝 Event List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: eventsController.events.length,
                    itemBuilder: (context, index) {
                      return EventCard(eventData: eventsController.events[index]);
                    },
                  ),
                ),
              ],
            );
          } else {
            // ⏳ Placeholder
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isTeamLeader ? "No events available" : "Add a New Event!",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: AppFonts.interBold,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          if (!isTeamLeader) ...[
                            const SizedBox(height: 10),
                            Text(
                              "Invite the New Location Admins to their new Event and Management App",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: AppFonts.interRegular,
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        });
      },
    );
  }
}