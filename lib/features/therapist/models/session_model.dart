import '../enums/appointment_status.dart';

class SessionModel {
  final String id;
  final String name;
  final String sessionType;
  final String date;
  final String time;
  final String imageUrl;

  AppointmentStatus status;

  SessionModel({
    required this.id,
    required this.name,
    required this.sessionType,
    required this.date,
    required this.time,
    required this.imageUrl,
    required this.status,
  });
}