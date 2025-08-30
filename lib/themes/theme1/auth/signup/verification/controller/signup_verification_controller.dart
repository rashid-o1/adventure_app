import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupVerificationController extends GetxController {
  var status = 'pending'.obs;
  var tempId = ''.obs;
  var role = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    tempId.value = prefs.getString('tempId') ?? '';
    role.value = prefs.getString('selectedRole') ?? '';
    print('SignupVerificationController initialized with tempId: ${tempId.value}, role: ${role.value}');

    if (tempId.value.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('RegistrationRequests')
          .doc(tempId.value)
          .snapshots()
          .listen((doc) {
        if (doc.exists) {
          status.value = doc['status'] ?? 'pending';
          print('Registration status updated: ${status.value}');
        } else {
          print('Registration request not found for tempId: ${tempId.value}');
          status.value = 'not_found';
        }
      });
    }
  }
}