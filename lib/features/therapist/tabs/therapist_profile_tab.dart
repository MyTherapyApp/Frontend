import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/logout_button.dart';
import '../../../common/widgets/profile_menu_item.dart';
import '../../auth/controllers/auth_cubit.dart';
import '../../auth/screens/role_selection_screen.dart';
import '../helpers/therapist_profile_menu.dart';
import '../../../common/helpers/current_user.dart';
import '../../../common/widgets/profile_header.dart';

class TherapistProfileTab extends StatefulWidget {
  const TherapistProfileTab({super.key});

  @override
  State<TherapistProfileTab> createState() =>
      _TherapistProfileTabState();
}

class _TherapistProfileTabState
    extends State<TherapistProfileTab> {
  bool notificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    final menuItems = TherapistProfileMenu.items(
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
                user: therapistUser,
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
                  await context
      .read<AuthCubit>()
      .logout();

  if (!context.mounted) return;

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) =>
          const RoleSelectionScreen(verifiedEmail: '',),
    ),
    (route) => false,
  );
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