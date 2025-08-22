import 'package:get/get.dart';

class TeamController extends GetxController {
  // Dummy data for the team list
  final RxList<Map<String, String>> teams = <Map<String, String>>[
    {
      'name': 'Team 01',
      'description': 'Zohaib create a team',
      'avatar': 'https://4kwallpapers.com/images/wallpapers/atlanta-falcons-2560x1440-23570.jpg',
    },
    {
      'name': 'Team 02',
      'description': 'Ali create a team',
      'avatar': 'https://tse2.mm.bing.net/th/id/OIP.NiVj66aYfZKqb6xwVKBbMwAAAA?rs=1&pid=ImgDetMain&o=7&rm=3',
    },
    {
      'name': 'Team 03',
      'description': 'Jawad create a team',
      'avatar': 'https://th.bing.com/th?id=OIF.SvCO8Eh8eOhA%2bzgkJGycIg&rs=1&pid=ImgDetMain&o=7&rm=3',
    },
    {
      'name': 'Team 04',
      'description': 'Hassan create a team',
      'avatar': 'https://tse1.mm.bing.net/th/id/OIP.PMSG8Y2QcHx8nimCQobztgHaH1?rs=1&pid=ImgDetMain&o=7&rm=3',
    },
  ].obs;

  // dummy chat data organized by team name
  final Map<String, List<Map<String, String>>> chatMessages = {
    'Team 01': [
      {
        'sender': 'Zohaib',
        'message': 'Hello Paul. How are you?',
        'timestamp': '11:05 PM',
        'avatar': 'https://randomuser.me/api/portraits/men/1.jpg',
      },
      {
        'sender': 'Zohaib',
        'message': 'Are you available today?',
        'timestamp': '11:06 PM',
        'avatar': 'https://randomuser.me/api/portraits/men/1.jpg',
      },
      {
        'sender': 'Paul',
        'message': "Hi Zohaib, I'm good!",
        'timestamp': '11:09 PM',
        'avatar': 'https://randomuser.me/api/portraits/men/5.jpg',
      },
      {
        'sender': 'Paul',
        'message': "Yeah, I'm available.",
        'timestamp': '11:09 PM',
        'avatar': 'https://randomuser.me/api/portraits/men/5.jpg',
      },
      {
        'sender': 'Zohaib',
        'message': "Great, let's meet at 3 PM.",
        'timestamp': '11:15 PM',
        'avatar': 'https://randomuser.me/api/portraits/men/1.jpg',
      },
      {
        'sender': 'Hafsa',
        'message': "I'm also available at that time.",
        'timestamp': '11:19 PM',
        'avatar': 'https://randomuser.me/api/portraits/women/17.jpg',
      },
    ],
    'Team 02': [
      {
        'sender': 'Ali',
        'message': 'Meeting is at 2 PM.',
        'timestamp': '10:00 AM',
        'avatar': 'https://randomuser.me/api/portraits/men/9.jpg',
      },
      {
        'sender': 'Faraz',
        'message': "Got it. I'll be there.",
        'timestamp': '10:06 AM',
        'avatar': 'https://randomuser.me/api/portraits/men/6.jpg',
      },
      {
        'sender': 'Ali',
        'message': "Don't be late!",
        'timestamp': '10:09 AM',
        'avatar': 'https://randomuser.me/api/portraits/men/9.jpg',
      },
      {
        'sender': 'Iqra',
        'message': "I won't. See you soon.",
        'timestamp': '10:10 AM',
        'avatar': 'https://randomuser.me/api/portraits/women/11.jpg',
      },
      {
        'sender': 'Faraz',
        'message': "Perfect.",
        'timestamp': '10:04 AM',
        'avatar': 'https://randomuser.me/api/portraits/men/6.jpg',
      },
    ],
    'Team 03': [
      {
        'sender': 'Jawad',
        'message': 'Project deadline is tomorrow.',
        'timestamp': '09:00 AM',
        'avatar': 'https://randomuser.me/api/portraits/men/3.jpg',
      },
      {
        'sender': 'Raheem',
        'message': "Working on it now.",
        'timestamp': '09:05 AM',
        'avatar': 'https://randomuser.me/api/portraits/men/7.jpg',
      },
      {
        'sender': 'Jawad',
        'message': "Let me know if you need any help.",
        'timestamp': '09:10 AM',
        'avatar': 'https://randomuser.me/api/portraits/men/3.jpg',
      },
      {
        'sender': 'Raheem',
        'message': "Thanks! I'm almost done.",
        'timestamp': '09:20 AM',
        'avatar': 'https://randomuser.me/api/portraits/men/7.jpg',
      },
      {
        'sender': 'Areeba',
        'message': "Good to hear.",
        'timestamp': '09:25 AM',
        'avatar': 'https://randomuser.me/api/portraits/women/19.jpg',
      },
    ],
    'Team 04': [
      {
        'sender': 'Hassan',
        'message': 'Report submitted.',
        'timestamp': '01:00 PM',
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
      },
      {
        'sender': 'Hassan',
        'message': "Let's start on the next task.",
        'timestamp': '01:05 PM',
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
      },
      {
        'sender': 'Hassan',
        'message': "Anyone online?",
        'timestamp': '01:07 PM',
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
      },
      {
        'sender': 'Huma Noor',
        'message': "I'm here.",
        'timestamp': '01:14 PM',
        'avatar': 'https://randomuser.me/api/portraits/women/8.jpg',
      },
      {
        'sender': 'Hassan',
        'message': "I guess I'll start myself.",
        'timestamp': '01:15 PM',
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
      },

    ],
  };

  void clearTeams() {
    teams.clear();
  }
}