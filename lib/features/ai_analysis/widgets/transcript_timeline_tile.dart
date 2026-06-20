import 'package:flutter/material.dart';
import 'package:my_therapy/common/theme/app_colors.dart';

import '../models/timeline_item.dart';

class TranscriptTimelineTile
    extends StatelessWidget {
  final TimelineItem item;
  final int index;

  const TranscriptTimelineTile({
    super.key,
    required this.item,
    required this.index,
  });

  Color _color() {
    switch (
        item.sentiment.toLowerCase()) {
      case 'positive':
        return Colors.green;

      case 'negative':
        return Colors.red;

      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.navBackground,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: ExpansionTile(
        title: Text(
          'Chunk ${index + 1}',
        ),
        subtitle: Text(
          '${item.emotion} • ${item.sentiment}',
          style: TextStyle(
            color: _color(),
            fontWeight:
                FontWeight.w600,
          ),
        ),
        childrenPadding:
            const EdgeInsets.all(16),
        children: [
          Text(
            item.transcript,
            style: const TextStyle(
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}