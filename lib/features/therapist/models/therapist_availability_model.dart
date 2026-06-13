class TherapistAvailabilityModel {
  final String slotId;
  final String therapistName;
  final DateTime startTime;
  final DateTime endTime;
  final bool isBooked;

  TherapistAvailabilityModel({
    required this.slotId,
    required this.therapistName,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
  });

  factory TherapistAvailabilityModel.fromJson(Map<String, dynamic> json) {
    return TherapistAvailabilityModel(
      slotId: json['slotId'],
      therapistName: json['therapistName'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      isBooked: json['isBooked'],
    );
  }
}