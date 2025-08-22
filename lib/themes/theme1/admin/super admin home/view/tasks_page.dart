import 'package:flutter/material.dart';
import '../../../../../core/utils/style/app_fonts.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Add a New Task!",
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
            "Easily create a task by adding details and setting a location to stay on track.",
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
}