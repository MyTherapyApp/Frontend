import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/chart_models.dart';
import '../models/timeline_item.dart';

class SentimentPieChart extends StatelessWidget {
  final List<TimelineItem> timeline;

  const SentimentPieChart({
    super.key,
    required this.timeline,
  });

  @override
  Widget build(BuildContext context) {
    final sentiments = <String, int>{};

    for (final item in timeline) {
      sentiments[item.sentiment] =
          (sentiments[item.sentiment] ?? 0) + 1;
    }

    final data = sentiments.entries
        .map(
          (e) => ChartData(
            label: e.key,
            value: e.value.toDouble(),
          ),
        )
        .toList();

    return SizedBox(
      height: 250,
      child: SfCircularChart(
        legend: const Legend(
          isVisible: true,
        ),
        series: [
          PieSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (item, _) => item.label,
            yValueMapper: (item, _) => item.value,
            dataLabelSettings:
                const DataLabelSettings(
              isVisible: true,
            ),
          ),
        ],
      ),
    );
  }
}

