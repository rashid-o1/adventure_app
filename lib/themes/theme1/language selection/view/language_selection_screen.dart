import 'package:adventure_app/core/utils/style/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/style/app_colors.dart';
import '../controller/language_selection_controller.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageSelectionController controller = Get.put(LanguageSelectionController());

    //  language names to their flag emojis
    final Map<String, String> languageFlags = {
      'English': '🇬🇧',
      'Italian': '🇮🇹',
      'Chinese': '🇨🇳',
      'French': '🇫🇷',
      'German': '🇩🇪',
      'Spanish': '🇪🇸',
      'Russian': '🇷🇺',
      'Japanese': '🇯🇵',
      'Arabic': '🇸🇦',
      'Hindi': '🇮🇳',
      'Portuguese': '🇵🇹',
      'Bengali': '🇧🇩',
      'Urdu': '🇵🇰',
      'Korean': '🇰🇷',
    };

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    //Get.back();
                    Navigator.pop(context);
                  }
              ),
              const SizedBox(height: 15),
              Text(
                'Choose Your Language ${languageFlags['English']}',
                style: const TextStyle(
                  fontFamily: 'InterBold',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please search and then choose your personal language.',
                style: TextStyle(
                  fontFamily: AppFonts.interRegular,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  onChanged: (value) => controller.searchQuery.value = value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Language list
              Expanded(
                child: Obx(() => ListView.builder(
                  itemCount: controller.filteredLanguages.length,
                  itemBuilder: (context, index) {
                    final language = controller.filteredLanguages[index];
                    return Obx(() => ListTile(
                      tileColor: controller.selectedLanguage.value == language
                          ? Colors.grey[200]
                          : Colors.transparent,
                      leading: Text(
                        languageFlags[language] ?? '❓',
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(language),
                      trailing: controller.selectedLanguage.value == language
                          ? Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check, color: AppColors.black, size: 16),
                      )
                          : null,
                      onTap: () {
                        controller.selectLanguage(language);
                      },
                    ));
                  },
                )),
              ),
              const SizedBox(height: 20),
              // Continue button
              ElevatedButton(
                onPressed: () {
                  print('Selected Language: ${controller.selectedLanguage.value}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontFamily: AppFonts.interBold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}