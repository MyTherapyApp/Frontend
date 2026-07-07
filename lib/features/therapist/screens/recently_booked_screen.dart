import 'package:flutter/material.dart';

import '../models/patient_model.dart';
import '../widgets/recent_patient_card.dart';

class RecentlyBookedScreen extends StatelessWidget {
  const RecentlyBookedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recently Booked'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recentPatients.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: .8,
        ),
        itemBuilder: (context, index) {
          return RecentPatientCard(
            patient: recentPatients[index],
          );
        },
      ),
    );
  }
}