import 'package:flutter/material.dart';
import 'package:my_therapy/common/enums/user_role.dart';
import 'package:my_therapy/features/search/screens/search_screen.dart';
import '../../../common/helpers/current_user.dart';
import '../../../common/widgets/custom_search_field.dart';
import '../../../common/widgets/header_action_button.dart';
import '../../../common/widgets/home_header.dart';
import '../../../features/therapist/widgets/therapist_upcoming_session_widget.dart'; 
import '../screens/choose_availability_screen.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                user: therapistUser,
                actions: [
                  HeaderActionButton(
                    icon: Icons.calendar_month_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChooseAvailabilityScreen()),
                      );
                    },
                  ),
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
              
              const Text(
                'Next Session',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B3B86),
                ),
              ),
              const SizedBox(height: 12),

              // استدعاء الكارد من الملف الخارجي
              const TherapistUpcomingSessionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}