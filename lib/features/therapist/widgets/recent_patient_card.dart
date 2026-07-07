import 'package:flutter/material.dart';
import 'package:my_therapy/common/theme/app_colors.dart';

import '../models/patient_model.dart';
import '../screens/patient_profile_screen.dart';

class RecentPatientCard extends StatelessWidget {
  final PatientModel patient;

  const RecentPatientCard({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(left: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.navBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: patient.imageId.isNotEmpty
            ? NetworkImage('https://picsum.photos/id/${patient.imageId}/200/200',)
            :null,
          child: patient.imageId.isEmpty
          ? const Icon(Icons.person)
      : null,
          ),

          const SizedBox(height: 10),

          Text(
            patient.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            'Video Call Session',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),

          const Spacer(),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B3B86),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                ),
                  elevation: 0,
                  ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PatientProfileScreen(
                      name: patient.name,
                      age: patient.age,
                      status: patient.status,
                      language: patient.language,
                      city: patient.city,
                      imageId: patient.imageId,
                    ),
                  ),
                );
              },
              child: const Text('View Profile', style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}