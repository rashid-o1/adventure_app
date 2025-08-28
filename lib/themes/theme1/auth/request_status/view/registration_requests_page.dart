import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/style/app_fonts.dart';
import '../../../../../../core/utils/style/app_colors.dart';
import '../../../../../../services/auth_service.dart';

class RegistrationRequestsPage extends StatelessWidget {
  const RegistrationRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Registration Requests',
          style: TextStyle(
            fontFamily: AppFonts.interBold,
            fontSize: width * 0.055,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        top: false,
        child: FutureBuilder<String?>(
          future: authService.getUserRole(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, roleSnapshot) {
            if (roleSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.black));
            }
            if (roleSnapshot.hasError || !roleSnapshot.hasData) {
              return Center(
                child: Text(
                  'Error loading user role',
                  style: TextStyle(
                    fontFamily: AppFonts.interRegular,
                    fontSize: width * 0.04,
                    color: Colors.black,
                  ),
                ),
              );
            }

            final String? role = roleSnapshot.data;
            if (role == null || (role != 'admin' && role != 'TeamLeader')) {
              return Center(
                child: Text(
                  'Unauthorized access',
                  style: TextStyle(
                    fontFamily: AppFonts.interRegular,
                    fontSize: width * 0.04,
                    color: Colors.black,
                  ),
                ),
              );
            }

            return FutureBuilder<String?>(
              future: _getUserSignupId(role),
              builder: (context, signupIdSnapshot) {
                if (signupIdSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Colors.black));
                }
                if (signupIdSnapshot.hasError || !signupIdSnapshot.hasData) {
                  return Center(
                    child: Text(
                      'Error loading signup ID',
                      style: TextStyle(
                        fontFamily: AppFonts.interRegular,
                        fontSize: width * 0.04,
                        color: Colors.black,
                      ),
                    ),
                  );
                }

                final String signupId = signupIdSnapshot.data!;
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('RegistrationRequests')
                      .where(role == 'admin' ? 'adminId' : 'leaderId', isEqualTo: signupId)
                      .where('status', isEqualTo: 'pending')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Colors.black));
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error loading requests: ${snapshot.error}',
                          style: TextStyle(
                            fontFamily: AppFonts.interRegular,
                            fontSize: width * 0.04,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }

                    final requests = snapshot.data?.docs ?? [];
                    if (requests.isEmpty) {
                      return Center(
                        child: Text(
                          'No pending registration requests',
                          style: TextStyle(
                            fontFamily: AppFonts.interRegular,
                            fontSize: width * 0.04,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.02),
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final request = requests[index];
                        final String userId = request['userId'];
                        final String requestRole = request['role'];

                        return FutureBuilder<Map<String, dynamic>?>(
                          future: _getUserData(userId, requestRole),
                          builder: (context, userSnapshot) {
                            if (userSnapshot.connectionState == ConnectionState.waiting) {
                              return const ListTile(
                                title: Text('Loading...'),
                              );
                            }
                            if (userSnapshot.hasError || !userSnapshot.hasData) {
                              return ListTile(
                                title: Text(
                                  'Error loading user data',
                                  style: TextStyle(
                                    fontFamily: AppFonts.interRegular,
                                    fontSize: width * 0.04,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }

                            final userData = userSnapshot.data!;
                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.symmetric(vertical: height * 0.01),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.01),
                                title: Text(
                                  userData['email'] ?? 'Unknown Email',
                                  style: TextStyle(
                                    fontFamily: AppFonts.interBold,
                                    fontSize: width * 0.04,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  'Role: $requestRole\nStatus: ${request['status']}',
                                  style: TextStyle(
                                    fontFamily: AppFonts.interRegular,
                                    fontSize: width * 0.035,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.check, color: Colors.green),
                                      onPressed: () => _approveRequest(userId, requestRole, signupId, role),
                                      tooltip: 'Approve',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close, color: Colors.red),
                                      onPressed: () => _rejectRequest(userId),
                                      tooltip: 'Reject',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<String?> _getUserSignupId(String role) async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    if (role == 'admin') {
      final doc = await FirebaseFirestore.instance.collection('admins').doc(uid).get();
      return doc.exists ? doc['signupId'] : null;
    } else if (role == 'TeamLeader') {
      final doc = await FirebaseFirestore.instance.collection('TeamLeaders').doc(uid).get();
      return doc.exists ? doc['signupId'] : null;
    }
    return null;
  }

  Future<Map<String, dynamic>?> _getUserData(String userId, String role) async {
    try {
      final collection = role == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers';
      final doc = await FirebaseFirestore.instance.collection(collection).doc(userId).get();
      return doc.exists ? doc.data() as Map<String, dynamic> : null;
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  Future<void> _approveRequest(String userId, String requestRole, String signupId, String userRole) async {
    try {
      await FirebaseFirestore.instance.collection('RegistrationRequests').doc(userId).update({
        'status': 'approved',
      });
      final collection = requestRole == 'TeamLeader' ? 'TeamLeaders' : 'TeamMembers';
      await FirebaseFirestore.instance.collection(collection).doc(userId).update({
        'status': 'approved',
      });
      Get.snackbar(
        'Success',
        'Request approved',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to approve request: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
    }
  }

  Future<void> _rejectRequest(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('RegistrationRequests').doc(userId).update({
        'status': 'rejected',
      });
      Get.snackbar(
        'Success',
        'Request rejected',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to reject request: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
    }
  }
}