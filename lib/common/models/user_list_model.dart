class UserListModel {
  final String id;
  final String fullName;
  final String? profilePicture;

  UserListModel({
    required this.id,
    required this.fullName,
    this.profilePicture,
  });

  factory UserListModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserListModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      profilePicture: json['profilePicture'],
    );
  }
}