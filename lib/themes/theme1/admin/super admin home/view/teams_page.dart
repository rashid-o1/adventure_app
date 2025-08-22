import 'package:flutter/material.dart';
import '../../../../../core/utils/style/app_fonts.dart';

class TeamsPage extends StatelessWidget {
  const TeamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Add a New Team!",
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
            "Invite team members by entering their email addresses and start collaborating instantly.",
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