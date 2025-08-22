import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

    return Obx(() {
      if (eventsController.events.isNotEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar (Unchanged)
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

            // Recent Heading (Unchanged)
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
            // List of Event Cards (Unchanged)
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
        // Placeholder UI (Unchanged)
        return Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Add a New Event!",
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
                      "Invite the New Location Admins to their new Event and Management App",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFonts.interRegular,
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    });
  }
}
