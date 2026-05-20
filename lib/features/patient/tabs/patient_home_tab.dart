import 'package:flutter/material.dart';

import '../../../common/enums/user_role.dart';
import '../../../common/helpers/current_user.dart';
import '../../../common/widgets/custom_search_field.dart';
import '../../../common/widgets/header_action_button.dart';
import '../../../common/widgets/home_header.dart';
import '../../search/screens/search_screen.dart';

class PatientHomeTab extends StatelessWidget {
  const PatientHomeTab({super.key});

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
                user: patientUser,
                actions: [
                  HeaderActionButton(
                    icon: Icons.notifications_rounded,
                    onTap: () {},
                  ),
                  ],
                  ),
                  const SizedBox(height: 8,),
                  CustomSearchField(
                    hintText: 'Search a Therapist...',
                    readOnly: true,
                    enabledFocus: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_)=> SearchScreen(role: UserRole.patient,)
                        ),);
                },
              ),
            ],
          ),
          ),
        ),
    );
  }
}