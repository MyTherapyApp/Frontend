import 'package:flutter/material.dart';

class AppNotification {
  final String title;
  final String description;
  final String time;
  final String date;
  final IconData icon;

  AppNotification({
    required this.title,
    required this.description,
    required this.time,
    required this.date,
    required this.icon,
  });
}