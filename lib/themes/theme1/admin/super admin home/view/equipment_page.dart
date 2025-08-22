import 'package:flutter/material.dart';
import '../../../../../core/utils/style/app_fonts.dart';

class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
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
}