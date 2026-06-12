import 'package:flutter/material.dart';
import '../../../common/widgets/user_avatar.dart';

class TherapistInfoCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String rating;
  final String price;
  final String? imageUrl;
  final VoidCallback? onTap; // 👈 ضفنا المتغير ده عشان نستقبل الضغطة

  const TherapistInfoCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.price,
    this.imageUrl,
    this.onTap, // 👈 سجلناه هنا
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 145,
      margin: const EdgeInsets.only(right: 12),
      // 👈 لفينا المحتوى بـ Material و InkWell عشان يدي تأثير الضغطة (Ripple Effect)
      child: Material(
        color: const Color(0xFFF4F6FD),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap, // 👈 نفذنا الضغطة هنا
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAvatar(size: 44, imageUrl: imageUrl),
                const SizedBox(height: 8),
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(
                  specialty,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                      ],
                    ),
                    Text(
                      price,
                      style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}