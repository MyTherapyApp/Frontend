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

  Color _sentimentColor() {
  switch (item.sentiment.toLowerCase()) {
    case 'positive':
      return Colors.green;

    case 'negative':
      return Colors.orange;

    default:
      return Colors.orange;
  }
}

Color _emotionColor() {
  switch (item.emotion) {
    case 'High_Intensity':
      return Colors.blue;

    case 'Low_Tired':
      return Colors.red;

    case 'Neutral':
      return  Colors.yellow;

    default:
      return Colors.grey;
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
        subtitle: Padding(
  padding: const EdgeInsets.only(top: 8),
  child: Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: _sentimentColor().withOpacity(.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _sentimentColor(),
          ),
        ),
        child: Text(
          item.sentiment.toUpperCase(),
          style: TextStyle(
            color: _sentimentColor(),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),

      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: _emotionColor().withOpacity(.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _emotionColor(),
          ),
        ),
        child: Text(
          item.emotion,
          style: TextStyle(
            color: _emotionColor(),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    ],
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