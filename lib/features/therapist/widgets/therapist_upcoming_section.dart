import 'package:flutter/material.dart';

import '../data/session_storage.dart';
import '../screens/upcoming_sessions_screen.dart';
import 'appointment_card.dart';

class TherapistUpcomingSection extends StatefulWidget {
  const TherapistUpcomingSection({
    super.key,
  });

  @override
  State<TherapistUpcomingSection> createState() =>
      _TherapistUpcomingSectionState();
}

class _TherapistUpcomingSectionState
    extends State<TherapistUpcomingSection> {

  @override
  Widget build(BuildContext context) {

    final sessions =
        SessionStorage.upcomingSessions;

    if (sessions.isEmpty) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          const Text(
            'Upcoming sessions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const UpcomingSessionsScreen(),
                ),
              );

              setState(() {});
            },
            child: const Text('View all'),
          ),
        ],
      ),

      const SizedBox(height: 12),

      Container(
        height: 150,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xffECEEF8),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xff6C8DDB),
          ),
        ),
        child: const Center(
          child: Text(
            'No upcoming sessions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ],
  );
}

    final session = sessions.first;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Row(
          children: [

            const Text(
              'Upcoming sessions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Spacer(),

            TextButton(
              onPressed: () async {

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const UpcomingSessionsScreen(),
                  ),
                );

                setState(() {});
              },
              child: const Text(
                'View all',
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        AppointmentCard(
          name: session.name,
          sessionType: session.sessionType,
          date: session.date,
          time: session.time,
          imageUrl: session.imageUrl,
          status: session.status,
          firstButtonText: 'Cancel',
          secondButtonText: 'Join',
          onFirstPressed: () {

            SessionStorage.cancelSession(
              session.id,
            );

            setState(() {});
          },
          onSecondPressed: (){},
          onLongPress: () async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Complete Session',
        ),
        content: const Text(
          'Do you want to mark this session as completed?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
                false,
              );
            },
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                true,
              );
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );

  if (result == true) {
    SessionStorage.completeSession(
      session.id,
    );

    setState(() {});
  }
},
        ),

      ],
    );
  }
}