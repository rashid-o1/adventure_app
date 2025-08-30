import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/style/app_fonts.dart';
import '../../../../../../core/utils/style/app_colors.dart';
import '../controller/RegistrationRequestsController.dart';

class RegistrationRequestsPage extends StatefulWidget {
  const RegistrationRequestsPage({super.key});

  @override
  _RegistrationRequestsPageState createState() => _RegistrationRequestsPageState();
}

class _RegistrationRequestsPageState extends State<RegistrationRequestsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final RegistrationRequestsController _controller = Get.put(RegistrationRequestsController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Approved'),
            Tab(text: 'Rejected'),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        child: Obx(() {
          if (_controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          }
          if (_controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Text(
                _controller.errorMessage.value,
                style: TextStyle(
                  fontFamily: AppFonts.interRegular,
                  fontSize: width * 0.04,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          if (_controller.userRole.value != 'admin' && _controller.userRole.value != 'TeamLeader') {
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
          return TabBarView(
            controller: _tabController,
            children: [
              _buildRequestList(context, 'pending', width, height),
              _buildRequestList(context, 'approved', width, height),
              _buildRequestList(context, 'rejected', width, height),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildRequestList(BuildContext context, String status, double width, double height) {
    return StreamBuilder<QuerySnapshot>(
      stream: _controller.getRequestsStream(status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.black));
        }
        if (snapshot.hasError) {
          print('Error loading $status requests: ${snapshot.error}');
          return Center(
            child: Text(
              'Error loading $status requests: ${snapshot.error}',
              style: TextStyle(
                fontFamily: AppFonts.interRegular,
                fontSize: width * 0.04,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        final requests = snapshot.data?.docs ?? [];
        if (requests.isEmpty) {
          return Center(
            child: Text(
              'No $status registration requests',
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
            final String tempId = request['userId'];
            final String requestRole = request['role'];
            final String requestStatus = request['status'] ?? 'pending';

            Color cardColor = Colors.white;
            String statusText = requestStatus.capitalizeFirst!;
            if (requestStatus == 'approved') {
              cardColor = Colors.green.withOpacity(0.1);
            } else if (requestStatus == 'rejected') {
              cardColor = Colors.red.withOpacity(0.1);
            }

            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(vertical: height * 0.01),
              color: cardColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request['email'] ?? 'Unknown Email',
                      style: TextStyle(
                        fontFamily: AppFonts.interBold,
                        fontSize: width * 0.04,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      'Role: $requestRole\nStatus: $statusText',
                      style: TextStyle(
                        fontFamily: AppFonts.interRegular,
                        fontSize: width * 0.035,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (requestStatus == 'pending') ...[
                      SizedBox(height: height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                await _controller.approveRequest(tempId, requestRole);
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
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(
                              'Approve',
                              style: TextStyle(
                                fontFamily: AppFonts.interMedium,
                                fontSize: width * 0.035,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                await _controller.rejectRequest(tempId, requestRole);
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
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(
                              'Reject',
                              style: TextStyle(
                                fontFamily: AppFonts.interMedium,
                                fontSize: width * 0.035,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}