import 'package:flutter/material.dart';

import '../../../common/helpers/current_user.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/logout_button.dart';
import '../../../common/widgets/profile_header.dart';
import '../../../common/widgets/profile_menu_item.dart';
import '../helpers/patient_profile_menu.dart';

class PatientProfileTab extends StatefulWidget {
  const PatientProfileTab({super.key});

  @override
  State<PatientProfileTab> createState() => _PatientProfileTabState();
}

class _PatientProfileTabState extends State<PatientProfileTab> {
  bool notificationEnabled = true;
  @override

  
  Widget build(BuildContext context) {
    final menuItems = PatientProfileMenu.items(
      notificationEnabled: notificationEnabled,
      onNotificationToggle: (value) {
        setState(() {
          notificationEnabled = value;
        });
      },
    );
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),

          child: Column(
            children: [
              ProfileHeader(
                user: patientUser,
              ),
              const SizedBox(height: 32),
              /// Menu Container
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),

                  decoration: BoxDecoration(
                    color: Color(0xFFFDFDFD),
                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),

                    itemCount: menuItems.length,

                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 8),

                    itemBuilder: (context, index) {
                      return ProfileMenuItem(
                        item: menuItems[index],
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Logout
              Align(
                alignment: Alignment.centerLeft,
                child: LogoutButton(
                  onTap: () async {
                  // await AuthService.logout();
                  // navigation later
                },
                            ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}