class TherapistAvailabilityModel {
  final String slotId;
  final String therapistId;
  final String therapistName;
  final String? therapistProfilePicture;
  final DateTime startTime;
  final DateTime endTime;
  final bool isBooked;

  TherapistAvailabilityModel({
    required this.slotId,
    required this.therapistId,
    required this.therapistName,
    required this.therapistProfilePicture,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
  });

  factory TherapistAvailabilityModel.fromJson(
    Map<String, dynamic> json,) {
    return TherapistAvailabilityModel(
      slotId: json['slotId'],
      therapistId: json['therapistId'],
      therapistName: json['therapistName'],
      therapistProfilePicture: json['therapistProfilePicture'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      isBooked: json['isBooked'],
    );
  }
}