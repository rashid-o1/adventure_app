import 'package:adventure_app/themes/theme1/admin/super%20admin%20home/view/super_admin_home.dart';
import 'package:adventure_app/themes/theme1/auth/login/view/login_screen.dart';
import 'package:adventure_app/themes/theme1/auth/signup/register/view/signup_screen.dart';
import 'package:adventure_app/themes/theme1/language%20selection/view/language_selection_screen.dart';
import 'package:adventure_app/themes/theme1/selection/view/selection_screen.dart';
import 'package:adventure_app/themes/theme1/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/utils/style/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adventure App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        appBarTheme: const AppBarTheme(color: AppColors.black),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.black),
        ),
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignupScreen()),
        GetPage(name: '/selection', page: () => const SelectionScreen()),
        GetPage(name: '/language', page: () => const LanguageSelectionScreen()),
        GetPage(name: '/superAdminHome', page: () => const SuperAdminHome()),
      ],
    );
  }
}