class PatientProfileModel {
  final String id;
  final String fullName;
  final String? profilePicture;
  final String? phone;
  final String? gender;
  final String? dateOfBirth;
  final String? mentalHealthStatus;
  final String? therapistPreferences;

  PatientProfileModel({
    required this.id,
    required this.fullName,
    this.profilePicture,
    this.phone,
    this.gender,
    this.dateOfBirth,
    this.mentalHealthStatus,
    this.therapistPreferences,
  });

  factory PatientProfileModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return PatientProfileModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      profilePicture: json['profilePicture'],
      phone: json['phone'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      mentalHealthStatus:
          json['mentalHealthStatus'],
      therapistPreferences:
          json['therapistPreferences'],
    );
  }
}