import 'package:flutter/material.dart';
import 'package:my_therapy/common/widgets/custom_appbar.dart';
import 'package:my_therapy/features/therapist/screens/session_analysis_screen.dart';

import '../data/session_storage.dart';
import '../enums/appointment_status.dart';
import '../widgets/appointment_card.dart';

class CompletedSessionsScreen extends StatefulWidget {
  const CompletedSessionsScreen({super.key});

  @override
  State<CompletedSessionsScreen> createState() =>
      _CompletedSessionsScreenState();
}

class _CompletedSessionsScreenState
    extends State<CompletedSessionsScreen> {
  @override
  Widget build(BuildContext context) {
    final sessions =
        SessionStorage.completedSessions;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Completed Sessions',
        showBackArrow: true,
      ),

      body: sessions.isEmpty
          ? const Center(
              child: Text(
                'No completed sessions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: sessions.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: 16),
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
                      AppointmentStatus.done,

                  firstButtonText:
                      "See Report",

                  secondButtonText:
                      "Message",

                  onFirstPressed: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (_) => const SessionAnalysisScreen(),
              ),
                );
                  },

                  onSecondPressed: () {
                    // Open Notes Screen
                  },
                );
              },
            ),
    );
  }
}