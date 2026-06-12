import 'package:flutter/material.dart';
import '../../../common/widgets/user_avatar.dart';

class CustomSessionCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String date;
  final String time;
  final String? doctorImageUrl;
  final bool isConfirmed;
  final String? statusText;        
  final Color? statusColor;        
  final Widget? bottomActionRow;   
  final VoidCallback? onTap;       
  final VoidCallback? onVideoTap; 
  final VoidCallback? onStartSessionTap; // ⚡ 1. ضفنا متغير زرار بدء الجلسة

  const CustomSessionCard({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    this.doctorImageUrl,
    this.isConfirmed = false,
    this.statusText,
    this.statusColor,
    this.bottomActionRow,
    this.onTap,
    this.onVideoTap, 
    this.onStartSessionTap, // ⚡ 2. ضفناه في الـ Constructor
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF4F6FD),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity, 
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  UserAvatar(size: 46, imageUrl: doctorImageUrl),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doctorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1B3B86))),
                        Text(specialty, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  // ⚡ 3. أيقونة الفيديو هتظهر لو مررنا دالة onVideoTap
                  if (onVideoTap != null)
                    GestureDetector(
                      onTap: onVideoTap,
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.videocam_rounded, color: Color(0xFF1B3B86), size: 20),
                      ),
                    )
                ],
              ),
              const SizedBox(height: 12),
              const Divider(color: Colors.black12, height: 1),
              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(Icons.calendar_today_rounded, size: 14, color: Color(0xFF1B3B86)),
                  const SizedBox(width: 4),
                  Text(date, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                  const Spacer(),
                  
                  if (statusText != null) ...[
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: statusColor ?? Colors.green, 
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(statusText!, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                      ],
                    ),
                    const Spacer(),
                  ],
                  
                  const Icon(Icons.access_time_rounded, size: 14, color: Color(0xFF1B3B86)),
                  const SizedBox(width: 4),
                  Text(time, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                ],
              ),
              
              // ⚡ 4. زرار Start Session هيظهر تحت الوقت والحالة لو مررنا onStartSessionTap
              if (onStartSessionTap != null) ...[
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight, // عشان ييجي ناحية اليمين زي التصميم
                  child: GestureDetector(
                    onTap: onStartSessionTap,
                    child: const Text(
                      'Start Session',
                      style: TextStyle(
                        color: Color(0xFF162A86),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],

              if (bottomActionRow != null) ...[
                const SizedBox(height: 14),
                bottomActionRow!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class UpcomingActionRow extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onReschedule;

  const UpcomingActionRow({super.key, required this.onCancel, required this.onReschedule});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black87,
              side: const BorderSide(color: Colors.black12),
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: onReschedule,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B3B86),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Reschedule', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
        ),
      ],
    );
  }
}

class CancelledActionRow extends StatelessWidget {
  final VoidCallback onReschedule;
  final VoidCallback onMessageDoctor;

  const CancelledActionRow({super.key, required this.onReschedule, required this.onMessageDoctor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onReschedule,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black87,
              side: const BorderSide(color: Colors.black12),
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Reschedule', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: onMessageDoctor,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B3B86),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Message Doctor', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
        ),
      ],
    );
  }
}

class CompletedActionRow extends StatelessWidget {
  final VoidCallback onSeeNotes;

  const CompletedActionRow({super.key, required this.onSeeNotes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onSeeNotes,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B3B86),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text('See notes', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      ),
    );
  }
}