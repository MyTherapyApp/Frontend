import '../enums/appointment_status.dart';
import '../models/session_model.dart';

class SessionStorage {
  static final List<SessionModel> sessions = [
    SessionModel(
      id: "1",
      name: "menna abobazla",
      sessionType: "Video",
      date: "Monday, June 22",
      time: "2.00-2.30 Am",
      imageUrl: "https://picsum.photos/id/1011/200",
      status: AppointmentStatus.confirmed,
    ),
    SessionModel(
      id: "2",
      name: "Sara Ahmed",
      sessionType: "Video",
      date: "Tuesday, June 23",
      time: "9.00-11.00 Am",
      imageUrl: "https://picsum.photos/id/1027/200",
      status: AppointmentStatus.confirmed,
    ),
    SessionModel(
      id: "3",
      name: "Esraa Magdy",
      sessionType: "Video",
      date: "Wednesday, June 22",
      time: "9.00-11.00 Am",
      imageUrl: "https://picsum.photos/id/1005/200",
      status: AppointmentStatus.confirmed,
    ),
  ];

  static List<SessionModel> get upcomingSessions =>
      sessions
          .where(
            (e) => e.status == AppointmentStatus.confirmed,
          )
          .toList();

  static List<SessionModel> get cancelledSessions =>
      sessions
          .where(
            (e) => e.status == AppointmentStatus.cancelled,
          )
          .toList();

  static void cancelSession(String id) {
    final session = sessions.firstWhere(
      (e) => e.id == id,
    );

    session.status = AppointmentStatus.cancelled;
  }
  static void rescheduleSession(String id) {
  final session = sessions.firstWhere(
    (e) => e.id == id,
  );

  session.status = AppointmentStatus.confirmed;
}
static List<SessionModel> get completedSessions =>
    sessions
        .where(
          (e) => e.status == AppointmentStatus.done,
        )
        .toList();

static void completeSession(String id) {
  final session = sessions.firstWhere(
    (e) => e.id == id,
  );

  session.status = AppointmentStatus.done;
}
}