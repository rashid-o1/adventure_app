class TeamMemberModel {
  final String id;
  final String email;
  final String name;
  final String countryCode;
  final String mobileNumber;
  final String signupId;
  final String userId;
  final String byLeaderId;
  final String profilePicture;
  final String profileThumbnail;
  final String status;

  TeamMemberModel({
    required this.id,
    required this.email,
    required this.name,
    required this.countryCode,
    required this.mobileNumber,
    required this.signupId,
    required this.userId,
    required this.byLeaderId,
    required this.profilePicture,
    required this.profileThumbnail,
    required this.status,
  });

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    return TeamMemberModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      countryCode: json['countryCode'],
      mobileNumber: json['mobileNumber'],
      signupId: json['signupId'],
      userId: json['userId'],
      byLeaderId: json['byLeaderId'],
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
      'byLeaderId': byLeaderId,
      'profilePicture': profilePicture,
      'profileThumbnail': profileThumbnail,
      'status': status,
    };
  }
}