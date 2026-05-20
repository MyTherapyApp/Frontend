import 'package:flutter/material.dart';
import 'package:my_therapy/common/theme/app_colors.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const LogoutButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: onTap,

        borderRadius: BorderRadius.circular(16),

        splashColor: Colors.red.withOpacity(0.1),
        highlightColor: Colors.red.withOpacity(0.05),

        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,

            children: [
              Icon(
                Icons.logout_rounded,
                color: Colors.red,
                size: 24,
              ),

              SizedBox(width: 8),

              Text(
                'Logout',
                style: TextStyle(
                  color: AppColors.logoutBtn,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}