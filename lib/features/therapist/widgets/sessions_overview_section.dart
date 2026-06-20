import 'package:flutter/material.dart';
import 'package:my_therapy/features/therapist/screens/choose_availability_screen.dart';
import 'package:my_therapy/features/therapist/screens/completed_sessions_screen.dart';
import 'package:my_therapy/features/therapist/screens/upcoming_sessions_screen.dart';

import '../screens/cancelled_sessions_screen.dart';
import 'home_action_card.dart';

class SessionsOverviewSection extends StatelessWidget {
  const SessionsOverviewSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's sessions overview:",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomeActionCard(
              title: "Your Availability",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (_) => const ChooseAvailabilityScreen(),
              ),
                );
              },
            ),
            HomeActionCard(
              title: "Completed",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (_) => const CompletedSessionsScreen(),
              ),
                );
              },
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomeActionCard(
              title: "Upcoming",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (_) => const UpcomingSessionsScreen(),
              ),
                );
              },
            ),
            HomeActionCard(
              title: "Cancelled",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (_) => const CancelledSessionsScreen(),
              ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}