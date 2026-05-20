import 'package:flutter/material.dart';
import 'package:my_therapy/common/theme/app_colors.dart';

class HeaderActionButton extends StatelessWidget {
  final IconData icon;

  final VoidCallback onTap;

  const HeaderActionButton({
    super.key,

    required this.icon,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: onTap,

        borderRadius: BorderRadius.circular(100),

        child: Ink(
          width: 44,
          height: 44,

          decoration: const BoxDecoration(
            shape: BoxShape.circle,

            color: AppColors.navBackground,
          ),

          child: Icon(
            icon,

            color: AppColors.primary,

            size: 22,
          ),
        ),
      ),
    );
  }
}