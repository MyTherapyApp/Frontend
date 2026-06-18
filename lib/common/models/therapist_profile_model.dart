class TherapistProfileModel {
  final String id;
  final String fullName;
  final String? profilePicture;
  final String? phone;
  final String? gender;
  final String? licenseNumber;
  final String? specialization;
  final int experienceYears;
  final double pricePerSession;
  final double ratingAverage;
  final int totalRatings;
  final int totalSessions;
  final String? bio;
  final String? availableDays;

  TherapistProfileModel({
    required this.id,
    required this.fullName,
    this.profilePicture,
    this.phone,
    this.gender,
    this.licenseNumber,
    this.specialization,
    required this.experienceYears,
    required this.pricePerSession,
    required this.ratingAverage,
    required this.totalRatings,
    required this.totalSessions,
    this.bio,
    this.availableDays,
  });

  factory TherapistProfileModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TherapistProfileModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      profilePicture:
          json['profilePicture'],
      phone: json['phone'],
      gender: json['gender'],
      licenseNumber:
          json['licenseNumber'],
      specialization:
          json['specialization'],
      experienceYears:
          json['experienceYears'] ?? 0,
      pricePerSession:
          (json['pricePerSession'] ?? 0)
              .toDouble(),
      ratingAverage:
          (json['ratingAverage'] ?? 0)
              .toDouble(),
      totalRatings:
          json['totalRatings'] ?? 0,
      totalSessions:
          json['totalSessions'] ?? 0,
      bio: json['bio'],
      availableDays:
          json['availableDays'],
    );
  }
}