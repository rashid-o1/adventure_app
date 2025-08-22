// File: lib/app/modules/superAdmin/controller/events_controller.dart

import 'package:get/get.dart';

class EventsController extends GetxController {
  final RxList<Map<String, String>> events = <Map<String, String>>[
    {
      'name': 'Annual Community Fair',
      'description': 'Join us for a day of fun, food, and games for all ages. Enjoy live music and local vendor stalls.',
      'location': 'City Park Pavilion',
      'date': 'Oct 15,2025, 10:00 AM',
      'image': 'https://th.bing.com/th/id/R.5fc84016b7ce1278674ca30c737d9397?rik=cyhNvWqHGP5NVA&riu=http%3a%2f%2fblackarchives.org%2fwp-content%2fuploads%2f2022%2f11%2fDSC01004-scaled.jpg&ehk=SIp1jSKb6T5V0OeGWHCdAWndgZtnMAQxqqWMDu8WzSQ%3d&risl=&pid=ImgRaw&r=0',
    },
    {
      'name': 'Future Fest',
      'description': 'A tech conference for all.',
      'location': 'Lahore Expo Center',
      'date': '20th Sep 2025',
      'image': 'https://tse4.mm.bing.net/th/id/OIP.fDZi1onTLd9wqe3ES2Rp9AHaE7?w=1280&h=853&rs=1&pid=ImgDetMain&o=7&rm=3',
    },
  ].obs;

  void clearEvents() {
    events.clear();
  }
}