import 'package:flutter/material.dart';
import '../../../features/patient/widgets/custom_session_card.dart'; // تأكدي من المسار

class TherapistUpcomingSessionWidget extends StatelessWidget {
  const TherapistUpcomingSessionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSessionCard(
      doctorName: 'Menna Bobazla', // اسم المريضة للعرض
      specialty: 'Anxiety Consultation',
      date: '15 June 2026',
      time: '08:30 PM',
      statusText: 'Confirmed',
      statusColor: Colors.green,
      
      // هنا ضفنا الـ ID بتاع المريض عشان الثيرابيست يقدر يرن عليه
      inviteeID: 'patient_menna', 
      inviteeName: 'Menna (Patient)',
    );
  }
}