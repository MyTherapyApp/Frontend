import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool underline;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.underline = true,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w400,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color ?? AppColors.linkText,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration:
              underline ? TextDecoration.underline : TextDecoration.none,
          decorationColor: color ?? AppColors.linkText,
        ),
      ),
    );
  }
}