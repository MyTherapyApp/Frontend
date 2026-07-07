import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/timeline_item.dart';

class MoodLineChart extends StatelessWidget {
  final List<TimelineItem> timeline;

  const MoodLineChart({
    super.key,
    required this.timeline,
  });

  double _sentimentValue(String sentiment) {
    switch (sentiment.toLowerCase()) {
      case 'positive':
        return 100;

      default:
        return 0;
    }
  }

  double _voiceValue(String emotion) {
  switch (emotion) {
    case 'Low_Tired':
      return 0;

    case 'Neutral':
      return 50;

    case 'High_Intensity':
      return 100;

    default:
      return 50;
  }
}

  @override
  Widget build(BuildContext context) {
    final data = timeline.asMap().entries.map((entry) {
      return _ChartPoint(
        chunk: entry.key + 1,
        textScore: _sentimentValue(
          entry.value.sentiment,
        ),
        voiceScore: _voiceValue(
          entry.value.emotion,
        ),
      );
    }).toList();

    return SizedBox(
      height: 300,
      child: SfCartesianChart(
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),

        primaryXAxis: NumericAxis(
          title: AxisTitle(
            text: 'Chunks',
          ),
        ),

        primaryYAxis: NumericAxis(
  minimum: 0,
  maximum: 100,
  interval: 50,

  axisLabelFormatter: (args) {
    switch (args.value.toInt()) {
      case 0:
        return ChartAxisLabel(
          'Negative',
          const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w600,
          ),
        );

      case 50:
        return ChartAxisLabel(
          'Neutral',
          const TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.w600,
          ),
        );

      case 100:
        return ChartAxisLabel(
          'Positive',
          const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        );

      default:
        return ChartAxisLabel(
          '',
          const TextStyle(),
        );
    }
  },
),

        tooltipBehavior:
            TooltipBehavior(enable: true),

        series: [
          LineSeries<_ChartPoint, int>(
            name: 'Text Sentiment',
            color: Colors.red,
            dataSource: data,
            xValueMapper: (item, _) =>
                item.chunk,
            yValueMapper: (item, _) =>
                item.textScore,
            markerSettings:
                const MarkerSettings(
              isVisible: true,
            ),
          ),

          LineSeries<_ChartPoint, int>(
            name: 'Voice Emotion',
            dataSource: data,
            xValueMapper: (item, _) =>
                item.chunk,
            yValueMapper: (item, _) =>
                item.voiceScore,
            markerSettings:
                const MarkerSettings(
              isVisible: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartPoint {
  final int chunk;

  final double textScore;

  final double voiceScore;

  _ChartPoint({
    required this.chunk,
    required this.textScore,
    required this.voiceScore,
  });
}