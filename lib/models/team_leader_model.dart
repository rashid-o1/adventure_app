class TeamLeaderModel {
  final String id;
  final String email;
  final String name;
  final String countryCode;
  final String mobileNumber;
  final String signupId;
  final String userId;
  final String byAdminId;
  final String profilePicture;
  final String profileThumbnail;
  final String status;

  TeamLeaderModel({
    required this.id,
    required this.email,
    required this.name,
    required this.countryCode,
    required this.mobileNumber,
    required this.signupId,
    required this.userId,
    required this.byAdminId,
    required this.profilePicture,
    required this.profileThumbnail,
    required this.status,
  });

  factory TeamLeaderModel.fromJson(Map<String, dynamic> json) {
    return TeamLeaderModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      countryCode: json['countryCode'],
      mobileNumber: json['mobileNumber'],
      signupId: json['signupId'],
      userId: json['userId'],
      byAdminId: json['byAdminId'],
      profilePicture: json['profilePicture'],
      profileThumbnail: json['profileThumbnail'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'countryCode': countryCode,
      'mobileNumber': mobileNumber,
      'signupId': signupId,
      'userId': userId,
      'byAdminId': byAdminId,
      'profilePicture': profilePicture,
      'profileThumbnail': profileThumbnail,
      'status': status,
    };
  }
}