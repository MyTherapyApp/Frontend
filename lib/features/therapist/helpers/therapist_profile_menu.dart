import 'package:flutter/material.dart';

import '../../../common/enums/menu_item_type.dart';
import '../../../common/models/profile_menu_item_model.dart';

class TherapistProfileMenu {
  static List<ProfileMenuItemModel> items({
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
        title: 'My All Sessions',
        icon: Icons.calendar_month,
        type: MenuItemType.arrow,

        onTap: () {
          // navigate to sessions screen
        },
      ),

      ProfileMenuItemModel(
        title: 'Earning',
        icon: Icons.account_balance_wallet,
        type: MenuItemType.arrow,

        onTap: () {
          // navigate to earnings screen
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
          // navigate to personal details screen
        },
      ),
    ];
  }
}