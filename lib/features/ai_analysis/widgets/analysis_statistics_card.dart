import 'package:flutter/material.dart';
import 'package:my_therapy/common/theme/app_colors.dart';

import '../models/session_statistics.dart';

class AnalysisStatisticsCard extends StatelessWidget {
  final SessionStatistics statistics;

  const AnalysisStatisticsCard({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _Item(
              title: 'Chunks',
              value:
                  statistics.totalChunksProcessed
                      .toString(),
            ),
          ),
          Expanded(
            child: _Item(
              title: 'Processing',
              value:
                  '${statistics.processingTime.toStringAsFixed(1)}s',
            ),
          ),
          Expanded(
            child: _Item(
              title: 'Report',
              value:
                  '${statistics.reportTime.toStringAsFixed(1)}s',
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String title;
  final String value;

  const _Item({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(title),
      ],
    );
  }
}