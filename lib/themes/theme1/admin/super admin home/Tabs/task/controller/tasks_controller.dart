// File: lib/app/modules/superAdmin/controller/events_controller.dart

import 'package:get/get.dart';

class TasksController extends GetxController {
  final RxList<Map<String, String>> tasks = <Map<String, String>>[
    {
      'name': 'Level 3 Map Layout',
      'description': 'Build the environment for the desert-themed level, including enemy spawn points.',

      'date': 'Oct 15,2025',
      'image': 'https://tse3.mm.bing.net/th/id/OIP.ituk_8CblwdIGGmblRNXQAHaHa?rs=1&pid=ImgDetMain&o=7&rm=3',
    }
  ].obs;

  void clearEvents() {
    tasks.clear();
  }
}