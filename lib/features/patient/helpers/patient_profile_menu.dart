import 'package:flutter/material.dart';

import '../../../common/enums/menu_item_type.dart';
import '../../../common/models/profile_menu_item_model.dart';

class PatientProfileMenu {
  static List<ProfileMenuItemModel> items({
    required bool notificationEnabled,
    required ValueChanged<bool> onNotificationToggle,
  }) {
    return [
      ProfileMenuItemModel(
        title: 'Notification',
        icon: Icons.notifications_rounded,
        type: MenuItemType.toggle,

        switchValue: notificationEnabled,
        onToggle: onNotificationToggle,
      ),

      ProfileMenuItemModel(
        title: 'My Appointments',
        icon: Icons.calendar_month_rounded,
        type: MenuItemType.arrow,

        onTap: () {
          // navigate to appointments screen
        },
      ),

      ProfileMenuItemModel(
        title: 'Payment',
        icon: Icons.receipt_long_rounded,
        type: MenuItemType.arrow,

        onTap: () {
          // navigate to payment history screen
        },
      ),

      ProfileMenuItemModel(
        title: 'Support',
        icon: Icons.support_agent_rounded,
        type: MenuItemType.arrow,

        onTap: () {
          // navigate to support screen
        },
      ),

      ProfileMenuItemModel(
        title: 'Personal Details',
        icon: Icons.person_rounded,
        type: MenuItemType.arrow,

        onTap: () {
          // navigate to personal details screen
        },
      ),
    ];
  }
}