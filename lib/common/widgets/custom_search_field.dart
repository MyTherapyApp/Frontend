import 'package:flutter/material.dart';
import 'package:my_therapy/common/theme/app_colors.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;

  final String hintText;

  final ValueChanged<String>? onChanged;

  final VoidCallback? onTap;

  final bool readOnly;

  final bool autofocus;
  final bool enabledFocus;

  final Widget? suffixIcon;

  const CustomSearchField({
    super.key,

    this.controller,

    required this.hintText,

    this.onChanged,

    this.onTap,

    this.readOnly = false,

    this.autofocus = false,

    this.suffixIcon,
    this.enabledFocus = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      onChanged: onChanged,

      onTap: onTap,

      readOnly: readOnly,

      autofocus: autofocus,

      textInputAction: TextInputAction.search,

      decoration: InputDecoration(
        hintText: hintText,

        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Color(0xFF9CA3AF),
        ),

        suffixIcon: suffixIcon,

        filled: true,

        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),

          borderSide: const BorderSide(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
        ),

        focusedBorder: enabledFocus
            ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),

            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 1.4,
            ),
          )
          : OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),

            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
      ),
    );
  }
}