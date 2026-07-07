import 'package:flutter/material.dart';
import 'package:my_therapy/common/enums/user_role.dart';
import 'package:my_therapy/features/search/screens/search_screen.dart';
import '../../../common/helpers/current_user.dart';
import '../../../common/widgets/custom_search_field.dart';
import '../../../common/widgets/header_action_button.dart';
import '../../../common/widgets/home_header.dart';
import '../models/patient_model.dart';
import '../screens/choose_availability_screen.dart';
import '../screens/recently_booked_screen.dart';
import '../widgets/recent_patient_card.dart';
import '../widgets/sessions_overview_section.dart';
import '../widgets/therapist_upcoming_section.dart';
// import '../widgets/therapist_upcoming_session_widget.dart';

class TherapistHomeTab extends StatefulWidget {
  const TherapistHomeTab({super.key});

  @override
  State<TherapistHomeTab> createState() => _TherapistHomeTabState();
}

class _TherapistHomeTabState extends State<TherapistHomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(
                  user: therapistUser,
                  actions: [
                    HeaderActionButton( icon: Icons.calendar_month_rounded, onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChooseAvailabilityScreen()),
                        );
                    }),
                    const SizedBox(width: 10),
                    HeaderActionButton(icon: Icons.notifications_rounded, onTap: () {}),
                  ],
                ),
                const SizedBox(height: 8),
                CustomSearchField(
                  hintText: 'Search a Patient...',
                  readOnly: true,
                  enabledFocus: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchScreen(role: UserRole.therapist)),
                    );
                  },
                ),
                const SizedBox(height: 32),
          
                const TherapistUpcomingSection(),
                const SizedBox(height: 24),
          
                const SessionsOverviewSection(),
                const SizedBox(height: 30),
                Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recently Booked With You',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RecentlyBookedScreen(),
                  ),
                );
              },
              child: const Text('View all'),
            ),
          ],
                ),
              ),
          
              SizedBox(
                height: 180,
                child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recentPatients.length,
          itemBuilder: (context, index) {
            final patient = recentPatients[index];
          
            return RecentPatientCard(patient: patient);
          },
                ),
              ),
            ],
          ),
                
                // const Text(
                //   'Next Session',
                //   style: TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //     color: Color(0xFF1B3B86),
                //   ),
                // ),
                // const SizedBox(height: 12),
          
                // const TherapistUpcomingSessionWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}