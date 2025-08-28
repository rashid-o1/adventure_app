import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  final String id;
  final int? adminId;
  final String email;
  final String name;
  final String countryCode;
  final String mobileNumber;
  final String signupId;
  final String userId;
  final String profilePicture;
  final String profileThumbnail;
  final String agencyName;
  final DateTime? createdOn;

  AdminModel({
    required this.id,
    this.adminId,
    required this.email,
    required this.name,
    required this.countryCode,
    required this.mobileNumber,
    required this.signupId,
    required this.userId,
    required this.profilePicture,
    required this.profileThumbnail,
    required this.agencyName,
    this.createdOn,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'] ?? json['userId'] ?? '',
      adminId: json['adminId'] is int ? json['adminId'] : (json['adminId'] is String ? int.tryParse(json['adminId']) : null),
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      countryCode: json['countryCode'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      signupId: json['signupId'] ?? json['signUpId']?.toString() ?? '',
      userId: json['userId'] ?? json['id'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      profileThumbnail: json['profileThumbnail'] ?? '',
      agencyName: json['agencyName'] ?? '',
      createdOn: json['createdOn'] != null
          ? (json['createdOn'] is Timestamp
          ? (json['createdOn'] as Timestamp).toDate()
          : DateTime.parse(json['createdOn']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'adminId': adminId,
      'email': email,
      'name': name,
      'countryCode': countryCode,
      'mobileNumber': mobileNumber,
      'signupId': signupId,
      'userId': userId,
      'profilePicture': profilePicture,
      'profileThumbnail': profileThumbnail,
      'agencyName': agencyName,
      'createdOn': createdOn != null ? Timestamp.fromDate(createdOn!) : null,
    };
  }
}