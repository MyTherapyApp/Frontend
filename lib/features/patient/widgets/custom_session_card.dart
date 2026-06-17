import 'package:flutter/material.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
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
  final String? inviteeID;
  final String? inviteeName;
  final VoidCallback? onStartSessionTap;

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
    this.inviteeID,
    this.inviteeName,
    this.onStartSessionTap,
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
                        Text(
                          doctorName, 
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1B3B86)),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          specialty, 
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // 👇 زرار الاتصال شغال بنظام الـ Auto-generated ID (آمن جداً)
                  if (inviteeID != null)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        // يترك فارغاً لمنع التداخل
                      },
                      child: ZegoSendCallInvitationButton(
                        isVideoCall: true,
                        invitees: [
                          ZegoUIKitUser(
                            id: inviteeID!,
                            name: inviteeName ?? doctorName,
                          ),
                        ],
                        iconSize: const Size(36, 36),
                        buttonSize: const Size(36, 36),
                        onPressed: (code, message, list) {
                          // يمكنك طباعة الـ code للـ Debugging
                          debugPrint("Call Sent: $code - $message");
                        },
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(color: Colors.black12, height: 1),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.calendar_today_rounded, size: 14, color: Color(0xFF1B3B86)),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      date, 
                      style: const TextStyle(fontSize: 12, color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  if (statusText != null) ...[
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
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
                          Flexible(
                            child: Text(
                              statusText!, 
                              style: const TextStyle(fontSize: 12, color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                  const Icon(Icons.access_time_rounded, size: 14, color: Color(0xFF1B3B86)),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      time, 
                      style: const TextStyle(fontSize: 12, color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (onStartSessionTap != null) ...[
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
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