import 'package:flutter/material.dart';

import '../enums/appointment_status.dart';

class AppointmentCard extends StatelessWidget {
  final String name;
  final String sessionType;
  final String date;
  final String time;
  final String imageUrl;

  final AppointmentStatus status;

  final String firstButtonText;
  final String secondButtonText;

  final VoidCallback? onFirstPressed;
  final VoidCallback? onSecondPressed;

  final VoidCallback? onLongPress;
  const AppointmentCard({
    super.key,
    required this.name,
    required this.sessionType,
    required this.date,
    required this.time,
    required this.imageUrl,
    required this.status,
    required this.firstButtonText,
    required this.secondButtonText,
    this.onFirstPressed,
    this.onSecondPressed,
    this.onLongPress,
  });

  Color get statusColor {
    switch (status) {
      case AppointmentStatus.confirmed:
        return Colors.green;
      case AppointmentStatus.cancelled:
        return Colors.red;
      case AppointmentStatus.done:
        return Colors.green;
    }
  }

  String get statusText {
    switch (status) {
      case AppointmentStatus.confirmed:
        return "Confirmed";
      case AppointmentStatus.cancelled:
        return "Cancelled";
      case AppointmentStatus.done:
        return "Done";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xffECEEF8),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xff6C8DDB),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        sessionType,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
      
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ],
            ),
      
            const SizedBox(height: 8),
      
            Divider(
              color: Colors.grey.shade400,
            ),
      
            const SizedBox(height: 8),
      
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 20),
                const SizedBox(width: 8),
                Text(date),
      
                const Spacer(),
      
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(statusText),
              ],
            ),
      
            const SizedBox(height: 10),
      
            Row(
              children: [
                const Icon(Icons.access_time, size: 20),
                const SizedBox(width: 8),
                Text(time),
              ],
            ),
      
            const SizedBox(height: 16),
      
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onFirstPressed,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(firstButtonText),
                  ),
                ),
      
                const SizedBox(width: 12),
      
                Expanded(
                  child: ElevatedButton(
                    onPressed: onSecondPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff193B8C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(secondButtonText),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

