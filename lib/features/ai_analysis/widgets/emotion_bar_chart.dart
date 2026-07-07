import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/chart_models.dart';
import '../models/timeline_item.dart';

class EmotionBarChart extends StatelessWidget {
  final List<TimelineItem> timeline;

  const EmotionBarChart({
    super.key,
    required this.timeline,
  });

  @override
  Widget build(BuildContext context) {
    final emotions = <String, int>{};

    for (final item in timeline) {
      emotions[item.emotion] =
          (emotions[item.emotion] ?? 0) + 1;
    }

    final data = emotions.entries
        .map(
          (e) => ChartData(
            label: e.key,
            value: e.value.toDouble(),
          ),
        )
        .toList();

    return SizedBox(
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: [
          ColumnSeries<ChartData, String>(
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

