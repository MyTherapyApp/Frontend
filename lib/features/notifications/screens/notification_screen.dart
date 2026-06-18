import 'package:flutter/material.dart';

import '../widgets/notification_card.dart';
import '../widgets/notification_date_section.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const NotificationDateSection(
          title: "Today",
        ),

        NotificationCard(
          title: "Appointment Confirmation",
          description: "Your appointment has been confirmed.",
          time: "9:00 pm",
          icon: Icons.person_outline,
        ),

        NotificationCard(
          title: "Appointment Alarm",
          description: "Your session starts soon.",
          time: "8:00 pm",
          icon: Icons.calendar_month,
        ),

        NotificationCard(
          title: "New Update Available",
          description: "Update the app for new features.",
          time: "6:00 pm",
          icon: Icons.update,
        ),

        const NotificationDateSection(
          title: "Yesterday",
        ),

        NotificationCard(
          title: "Appointment Cancellation",
          description: "Your appointment was cancelled.",
          time: "9:00 pm",
          icon: Icons.cancel_outlined,
        ),

        NotificationCard(
          title: "Appointment Alarm",
          description: "Reminder for tomorrow session.",
          time: "5:00 pm",
          icon: Icons.calendar_month,
        ),
      ],
    );
  }
}