import 'package:flutter/material.dart';

import '../enums/menu_item_type.dart';

class ProfileMenuItemModel {
  final String title;
  final IconData icon;

  final MenuItemType type;

  final VoidCallback? onTap;

  final bool switchValue;

  final ValueChanged<bool>? onToggle;

  final Widget? customTrailing;

  const ProfileMenuItemModel({
    required this.title,
    required this.icon,
    required this.type,

    this.onTap,

    this.switchValue = false,
    this.onToggle,

    this.customTrailing,
  });
}