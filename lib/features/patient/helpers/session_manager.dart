class SessionManager {
  // الجلسات القادمة (اللي هتظهر في الـ Home والـ Upcoming tab)
  static List<Map<String, dynamic>> upcomingSessions = [
    {
      'id': '1',
      'doctorName': 'Dr.Sara Ali',
      'specialty': 'Psychotherapist',
      'date': 'Today',
      'time': '10:30 - 11:30 Am',
      'isConfirmed': true,
    },
    {
      'id': '2',
      'doctorName': 'DR.Ola Gad',
      'specialty': 'Psychotherapist',
      'date': 'Monday, Jan 8',
      'time': '9:00 - 11:00 Am',
      'isConfirmed': true,
    },
  ];

  // الجلسات المكتملة
  static List<Map<String, dynamic>> completedSessions = [
    {
      'id': '3',
      'doctorName': 'DR.Ola Gad',
      'specialty': 'Psychotherapist',
      'date': 'Monday, Jan 8',
      'time': '9:00 - 11:00 Am',
    }
  ];

  // الجلسات الملغية
  static List<Map<String, dynamic>> cancelledSessions = [];

  // دالة الإلغاء (بتشيل من القادمة وتحط في الملغية)
  static void cancelSession(String id) {
    final sessionIndex = upcomingSessions.indexWhere((s) => s['id'] == id);
    if (sessionIndex != -1) {
      final session = upcomingSessions.removeAt(sessionIndex);
      session['isConfirmed'] = false;
      cancelledSessions.add(session);
    }
  }

  // دالة الحجز الجديد
  static void bookNewSession(Map<String, dynamic> session) {
    upcomingSessions.insert(0, session); // بيضيف الجلسة الجديدة في أول اللستة
  }
}