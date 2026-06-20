import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/timeline_item.dart';

class MoodLineChart extends StatelessWidget {
  final List<TimelineItem> timeline;

  const MoodLineChart({
    super.key,
    required this.timeline,
  });

  double _mapSentiment(String sentiment) {
    switch (sentiment.toLowerCase()) {
      case 'positive':
        return 100;

      case 'negative':
        return 0;

      default:
        return 50;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = timeline.asMap().entries.map((entry) {
      return _MoodPoint(
        chunk: entry.key + 1,
        mood: _mapSentiment(entry.value.sentiment),
      );
    }).toList();

    return SizedBox(
      height: 250,
      child: SfCartesianChart(
        primaryXAxis: NumericAxis(),
        series: [
          LineSeries<_MoodPoint, int>(
            dataSource: data,
            xValueMapper: (item, _) => item.chunk,
            yValueMapper: (item, _) => item.mood,
            markerSettings:
                const MarkerSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

class _MoodPoint {
  final int chunk;
  final double mood;

  _MoodPoint({
    required this.chunk,
    required this.mood,
  });
}

