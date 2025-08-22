import 'package:get/get.dart';

class EquipmentController extends GetxController {
  // Dummy data for the equipment list
  final RxList<Map<String, String>> equipmentList = <Map<String, String>>[
    {
      'teamName': 'Team 01',
      'description': 'i-pad, 2 Land Rover and drivers',
    },
    {
      'teamName': 'Team 02',
      'description': 'i-pad, tablet, 5 Land Rover and drivers',
    },
    {
      'teamName': 'Team 03',
      'description': 'i-pad, 4 Land Rover and drivers',
    },
    {
      'teamName': 'Team 04',
      'description': 'i-pad, Land Rover and driver',
    },
  ].obs;

  void clearEquipment() {
    equipmentList.clear();
  }
}