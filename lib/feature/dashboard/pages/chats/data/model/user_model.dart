
class UserModel {
  final String name;
  final String uid;
  final String profilePic;
  final bool isOnline;
  final String phoneNumber;
  // final List<String> groupId;
  UserModel({
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.isOnline,
    required this.phoneNumber,
    // required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      // 'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['user_name'] ?? '',
      uid: map['unique_id'] ?? '',
      profilePic: map['image_url'] ?? '',
      isOnline: map['isOnline'] ?? false,
      phoneNumber: map['phone_number'] ?? '',
      // groupId: List<String>.from(map['groupId']),
    );
  }
}
