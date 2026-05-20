import 'package:flutter/material.dart';
import 'package:my_therapy/common/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackArrow;
  final VoidCallback? onBackPressed;
  final Widget? action;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackArrow = false,
    this.onBackPressed,
    this.action
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
      leading: showBackArrow
          ? IconButton(
              onPressed: onBackPressed ?? () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              ),
            )
          : null,
          actions: action != null
            ? [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: action,
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}