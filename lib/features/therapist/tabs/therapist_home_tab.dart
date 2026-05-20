import 'package:flutter/material.dart';
import 'package:my_therapy/common/enums/user_role.dart';
import 'package:my_therapy/features/search/screens/search_screen.dart';

import '../../../common/helpers/current_user.dart';
import '../../../common/widgets/custom_search_field.dart';
import '../../../common/widgets/header_action_button.dart';
import '../../../common/widgets/home_header.dart';

class TherapistHomeTab extends StatelessWidget {
  const TherapistHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            children: [
              HomeHeader(
                user: therapistUser,
                actions: [
                  HeaderActionButton(
                    icon: Icons.calendar_month_rounded,
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                HeaderActionButton(
                  icon: Icons.notifications_rounded,
                  onTap: () {},
              ),
              ],
              ),
              const SizedBox(height: 8,),
              CustomSearchField(
                hintText: 'Search a Patient...',
                readOnly: true,
                enabledFocus: false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_)=> SearchScreen(role: UserRole.therapist,)
                    ),);
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}