class PendingTherapistModel {
  final String id;
  final String fullName;
  final String email;
  final String licenseNumber;
  final String verificationStatus;
  final DateTime createdAt;

  PendingTherapistModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.licenseNumber,
    required this.verificationStatus,
    required this.createdAt,
  });

  factory PendingTherapistModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return PendingTherapistModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      licenseNumber: json['licenseNumber'] ?? '',
      verificationStatus:
          json['verificationStatus'],
      createdAt: DateTime.parse(
        json['createdAt'],
      ),
    );
  }
}