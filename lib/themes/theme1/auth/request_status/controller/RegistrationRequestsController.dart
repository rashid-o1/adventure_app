import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../services/auth_service.dart';

class RegistrationRequestsController extends GetxController {
  final AuthService _authService = AuthService();
  final RxBool isLoading = true.obs;
  final RxString userRole = ''.obs;
  final RxString signupId = ''.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await _initialize();
  }

  Future<void> _initialize() async {
    try {
      final String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        print('No authenticated user found');
        errorMessage.value = 'Please log in to access registration requests';
        isLoading.value = false;
        return;
      }
      print('Initializing RegistrationRequestsController for UID: $uid');
      String? role = await _authService.getUserRole(uid);
      if (role == null || (role != 'admin' && role != 'TeamLeader')) {
        print('Invalid or unauthorized role: $role');
        errorMessage.value = 'Unauthorized access';
        isLoading.value = false;
        return;
      }
      userRole.value = role;
      print('User role set: ${userRole.value}');

      final String? fetchedSignupId = await _getUserSignupId(role);
      if (fetchedSignupId == null) {
        print('No signUpId found for role: $role, uid: $uid');
        errorMessage.value = 'Error loading signup ID. Please check your account settings.';
        isLoading.value = false;
        return;
      }
      signupId.value = fetchedSignupId;
      print('Signup ID set: ${signupId.value}');
      isLoading.value = false;
    } catch (e) {
      print('Error initializing RegistrationRequestsController: $e');
      errorMessage.value = 'Failed to initialize: $e';
      isLoading.value = false;
    }
  }

  Stream<QuerySnapshot> getRequestsStream(String status) {
    final String field = userRole.value == 'admin' ? 'adminId' : 'leaderId';
    final int parsedId = int.parse(signupId.value);
    print('Fetching $status requests for ${userRole.value} with $field: $parsedId');

    return FirebaseFirestore.instance
        .collection('RegistrationRequests')
        .where(field, isEqualTo: parsedId)
        .where('status', isEqualTo: status)
        .snapshots();
  }

  Future<void> approveRequest(String tempId, String requestRole) async {
    try {
      print('Approving request: tempId=$tempId, role=$requestRole');
      await _authService.approveRequest(tempId, requestRole);
    } catch (e) {
      print('Error approving request: $e');
      throw e; // Handled by UI
    }
  }

  Future<void> rejectRequest(String tempId, String requestRole) async {
    try {
      print('Rejecting request: tempId=$tempId, role=$requestRole');
      await _authService.rejectRequest(tempId, requestRole);
    } catch (e) {
      print('Error rejecting request: $e');
      throw e; // Handled by UI
    }
  }

  Future<String?> _getUserSignupId(String role) async {
    try {
      final String uid = FirebaseAuth.instance.currentUser!.uid;
      print('Fetching signUpId for role: $role, uid: $uid');
      final prefs = await SharedPreferences.getInstance();
      String? cachedSignupId = prefs.getString('signUpId');
      if (cachedSignupId != null) {
        print('Using cached signUpId: $cachedSignupId');
        return cachedSignupId;
      }
      if (role == 'admin') {
        QuerySnapshot adminSnapshot = await FirebaseFirestore.instance.collection('admins').where('userId', isEqualTo: uid).get();
        if (adminSnapshot.docs.isNotEmpty && adminSnapshot.docs.first['signUpId'] != null) {
          print('Admin signUpId found: ${adminSnapshot.docs.first['signUpId']}');
          await prefs.setString('signUpId', adminSnapshot.docs.first['signUpId'].toString());
          return adminSnapshot.docs.first['signUpId'].toString();
        }
      } else if (role == 'TeamLeader') {
        DocumentSnapshot leaderDoc = await FirebaseFirestore.instance.collection('TeamLeaders').doc(uid).get();
        if (leaderDoc.exists && leaderDoc['signUpId'] != null) {
          print('TeamLeader signUpId found: ${leaderDoc['signUpId']}');
          await prefs.setString('signUpId', leaderDoc['signUpId'].toString());
          return leaderDoc['signUpId'].toString();
        }
      }
      print('No signUpId found for role: $role, uid: $uid');
      return null;
    } catch (e) {
      print('Error fetching signUpId: $e');
      return null;
    }
  }
}