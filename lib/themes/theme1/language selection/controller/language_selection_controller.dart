import 'package:get/get.dart';

class LanguageSelectionController extends GetxController {
  // list of popular languages
  final List<String> allLanguages = [
    'English',
    'Italian',
    'Chinese',
    'French',
    'German',
    'Spanish',
    'Russian',
    'Japanese',
    'Arabic',
    'Hindi',
    'Portuguese',
    'Bengali',
    'Urdu',
    'Korean',
  ];

  // Obs list of languages that will be filtered based on search input
  RxList<String> filteredLanguages = <String>[].obs;

  // Obs string to hold the current search query
  RxString searchQuery = ''.obs;

  // Obs string to hold the currently selected language
  RxString selectedLanguage = 'English'.obs;

  @override
  void onInit() {
    super.onInit();

    // initialize filteredLanguages with all languages
    filteredLanguages.assignAll(allLanguages);

    // listen for changes in the search query and update the filtered list
    debounce(searchQuery, (_) => filterLanguages(), time: const Duration(milliseconds: 300));
  }

  // filters the language list based on search query
  void filterLanguages() {
    if (searchQuery.value.isEmpty) {
      filteredLanguages.assignAll(allLanguages);
    } else {
      filteredLanguages.assignAll(allLanguages.where((language) =>
          language.toLowerCase().contains(searchQuery.value.toLowerCase())).toList());
    }
  }

  // updates the selected language
  void selectLanguage(String language) {
    selectedLanguage.value = language;
  }
}
