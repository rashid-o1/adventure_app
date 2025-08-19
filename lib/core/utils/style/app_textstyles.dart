import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyles {
  /// Scale font size based on screen width
  static double _scale(BuildContext context, double size) {
    double baseWidth = 375; // base design width (e.g., iPhone X)
    double screenWidth = MediaQuery.of(context).size.width;
    return size * (screenWidth / baseWidth);
  }

  // ----------- BLACK (theme-aware) -----------
  static TextStyle blackRegular(BuildContext context, double size) => TextStyle(
    color: Theme.of(context).textTheme.bodyMedium?.color,
    fontFamily: AppFonts.interRegular,
    fontSize: _scale(context, size),
  );

  static TextStyle blackMedium(BuildContext context, double size) => TextStyle(
    color: Theme.of(context).textTheme.bodyMedium?.color,
    fontFamily: AppFonts.interMedium,
    fontSize: _scale(context, size),
  );

  static TextStyle blackBold(BuildContext context, double size) => TextStyle(
    color: Theme.of(context).textTheme.bodyMedium?.color,
    fontFamily: AppFonts.interBold,
    fontSize: _scale(context, size),
  );

  // ----------- WHITE -----------
  static TextStyle whiteRegular(BuildContext context, double size) => TextStyle(
    color: Colors.white,
    fontFamily: AppFonts.interRegular,
    fontSize: _scale(context, size),
  );

  static TextStyle whiteMedium(BuildContext context, double size) => TextStyle(
    color: Colors.white,
    fontFamily: AppFonts.interMedium,
    fontSize: _scale(context, size),
  );

  static TextStyle whiteBold(BuildContext context, double size) => TextStyle(
    color: Colors.white,
    fontFamily: AppFonts.interBold,
    fontSize: _scale(context, size),
  );

  // ----------- GREY -----------
  static TextStyle greyRegular(BuildContext context, double size) => TextStyle(
    color: Colors.grey,
    fontFamily: AppFonts.interRegular,
    fontSize: _scale(context, size),
  );

  static TextStyle greyMedium(BuildContext context, double size) => TextStyle(
    color: Colors.grey,
    fontFamily: AppFonts.interMedium,
    fontSize: _scale(context, size),
  );

  static TextStyle greyBold(BuildContext context, double size) => TextStyle(
    color: Colors.grey,
    fontFamily: AppFonts.interBold,
    fontSize: _scale(context, size),
  );

  // ----------- GREEN (Theme Color) -----------
  static TextStyle greenRegular(BuildContext context, double size) => TextStyle(
    color: AppColors.green,
    fontFamily: AppFonts.interRegular,
    fontSize: _scale(context, size),
  );

  static TextStyle greenMedium(BuildContext context, double size) => TextStyle(
    color: AppColors.green,
    fontFamily: AppFonts.interMedium,
    fontSize: _scale(context, size),
  );

  static TextStyle greenBold(BuildContext context, double size) => TextStyle(
    color: AppColors.green,
    fontFamily: AppFonts.interBold,
    fontSize: _scale(context, size),
  );
}