import 'package:flutter/material.dart';

class NotificationDateSection extends StatelessWidget {
  final String title;

  const NotificationDateSection({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xff223B7B),
        ),
      ),
    );
  }
}