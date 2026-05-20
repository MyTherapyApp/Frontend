import 'package:flutter/material.dart';
import 'package:my_therapy/common/theme/app_colors.dart';

import '../enums/menu_item_type.dart';
import '../models/profile_menu_item_model.dart';

class ProfileMenuItem extends StatelessWidget {
  final ProfileMenuItemModel item;

  const ProfileMenuItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: Icon(
                  item.icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
      
              const SizedBox(width: 16),
      
              Expanded(
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
      
              _buildTrailing(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrailing() {
    switch (item.type) {
      case MenuItemType.arrow:
        return const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18,
        );

      case MenuItemType.toggle:
        return Switch(
          value: item.switchValue,
          onChanged: item.onToggle,
        );

      case MenuItemType.custom:
        return item.customTrailing ?? const SizedBox.shrink();
    }
  }
}