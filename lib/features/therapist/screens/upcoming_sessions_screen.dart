import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_therapy/common/widgets/custom_appbar.dart';

import '../data/session_storage.dart';
import '../widgets/appointment_card.dart';

class UpcomingSessionsScreen
    extends StatefulWidget {
  const UpcomingSessionsScreen({
    super.key,
  });

  @override
  State<UpcomingSessionsScreen>
      createState() =>
          _UpcomingSessionsScreenState();
}

class _UpcomingSessionsScreenState
    extends State<UpcomingSessionsScreen> {
  @override
  Widget build(BuildContext context) {
    final sessions =
        SessionStorage.upcomingSessions;

    return Scaffold(
      appBar: CustomAppBar(title: "Upcoming sessions", showBackArrow: true,),
      body: sessions.isEmpty
    ? const Center(
        child: Text(
          'No upcoming sessions',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    : ListView.separated(
        padding:
            const EdgeInsets.all(16),
        itemCount: sessions.length,
        separatorBuilder:
            (_, __) =>
                const SizedBox(
                  height: 16,
                ),
        itemBuilder: (_, index) {
          final session =
              sessions[index];

          return AppointmentCard(
            name: session.name,
            sessionType:
                session.sessionType,
            date: session.date,
            time: session.time,
            imageUrl:
                session.imageUrl,
            status: session.status,
            firstButtonText:
                "Cancel",
            secondButtonText:
                "Join",
            onFirstPressed: () {
              SessionStorage
                  .cancelSession(
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
          );
        },
      ),
    );
  }
}