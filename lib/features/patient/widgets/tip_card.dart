import 'package:flutter/material.dart';

class TipCard extends StatelessWidget {
  final String text;

  const TipCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF638ECB), // اللون الأزرق الفاتح الخاص بالنصائح
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          height: 1.3,
        ),
      ),
    );
  }
}