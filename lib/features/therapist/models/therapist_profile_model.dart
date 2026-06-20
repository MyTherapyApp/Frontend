class TherapistProfileModel {
  final String id;
  final String fullName;
  final String? profilePicture;
  final String phone;
  final String? specialization;
  final String? bio;
  final double pricePerSession;
  final int experienceYears;

  TherapistProfileModel({
    required this.id,
    required this.fullName,
    this.profilePicture,
    required this.phone,
    this.specialization,
    this.bio,
    required this.pricePerSession,
    required this.experienceYears,
  });

  factory TherapistProfileModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TherapistProfileModel(
      id: json['id'],
      fullName: json['fullName'] ?? '',
      profilePicture: json['profilePicture'],
      phone: json['phone'] ?? '',
      specialization: json['specialization'],
      bio: json['bio'],
      pricePerSession:
          (json['pricePerSession'] ?? 0).toDouble(),
      experienceYears:
          json['experienceYears'] ?? 0,
    );
  }
}