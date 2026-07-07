import 'package:flutter/material.dart';
import 'package:my_therapy/features/therapist/screens/earning_screen.dart';

import '../../../common/enums/menu_item_type.dart';
import '../../../common/models/profile_menu_item_model.dart';
import '../screens/session_analysis_screen.dart';
import '../screens/therapist_edit_profile_screen.dart';

class TherapistProfileMenu {
  static List<ProfileMenuItemModel> items({
    required BuildContext context,
    required bool notificationEnabled,
    required ValueChanged<bool> onNotificationToggle,
  }) {
    return [
      ProfileMenuItemModel(
        title: 'Notification',
        icon: Icons.notifications,
        type: MenuItemType.toggle,

        switchValue: notificationEnabled,
        onToggle: onNotificationToggle,
      ),

      ProfileMenuItemModel(
        title: 'AI Reports',
        icon: Icons.align_horizontal_left_rounded,
        type: MenuItemType.arrow,

        onTap: () {
          Navigator.push( context, MaterialPageRoute(
          builder: (_) => const SessionAnalysisScreen(),
        ),
      );
        },
      ),

      ProfileMenuItemModel(
        title: 'Earning',
        icon: Icons.account_balance_wallet,
        type: MenuItemType.arrow,

        onTap: () {
          Navigator.push( context, MaterialPageRoute(
          builder: (_) => const EarningScreen(),
        ),
      );
        },
      ),

      ProfileMenuItemModel(
        title: 'Support',
        icon: Icons.support_agent,
        type: MenuItemType.arrow,

        onTap: () {
          // navigate to support screen
        },
      ),

      ProfileMenuItemModel(
        title: 'Personal details',
        icon: Icons.person,
        type: MenuItemType.arrow,

        onTap: () {
          Navigator.push(
          context,
      MaterialPageRoute(
        builder: (_) => const TherapistEditProfileScreen(),
      ),
    );
        },
      ),
    ];
  }
}