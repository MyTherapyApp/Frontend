import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_therapy/common/widgets/custom_appbar.dart';

import '../data/session_storage.dart';
import '../enums/appointment_status.dart';
import '../widgets/appointment_card.dart';

class CancelledSessionsScreen
    extends StatefulWidget {
  const CancelledSessionsScreen({
    super.key,
  });

  @override
  State<CancelledSessionsScreen> createState() => _CancelledSessionsScreenState();
}

class _CancelledSessionsScreenState extends State<CancelledSessionsScreen> {
  @override
  Widget build(BuildContext context) {
    final sessions =
        SessionStorage.cancelledSessions;

    return Scaffold(
      appBar: CustomAppBar(title: "Cancelled Sessions", showBackArrow: true,),
      body: sessions.isEmpty
          ? const Center(
              child: Text(
              'No cancelled sessions',
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
            status:
                AppointmentStatus
                    .cancelled,
            firstButtonText:
                "Reschedule",
            secondButtonText:
                "Message",
            onFirstPressed: () {
              SessionStorage.rescheduleSession(
              session.id,
            );
            setState(() {});
          },
          onSecondPressed: (){},
          );
        },
      ),
    );
  }
}