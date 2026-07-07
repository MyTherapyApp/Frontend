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
    final sentimentCounts = <String, int>{};
    final emotionCounts = <String, int>{};

    for (final item in timeline) {
      sentimentCounts[item.sentiment] =
          (sentimentCounts[item.sentiment] ?? 0) + 1;

      emotionCounts[item.emotion] =
          (emotionCounts[item.emotion] ?? 0) + 1;
    }

    final sentimentData = sentimentCounts.entries
        .map(
          (e) => ChartData(
            label: e.key,
            value: e.value.toDouble(),
          ),
        )
        .toList();

    final emotionData = emotionCounts.entries
        .map(
          (e) => ChartData(
            label: e.key,
            value: e.value.toDouble(),
          ),
        )
        .toList();

    return Row(
      children: [
        Expanded(
          child: _PieChartCard(
            title: 'Text Sentiment',
            data: sentimentData,
            colors: const [
              Colors.orange,
              Colors.green,
            ],
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _PieChartCard(
            title: 'Voice Emotion',
            data: emotionData,
            colors: const [
              Colors.blue,
              Colors.red,
              Colors.yellow,
              
            ],
          ),
        ),
      ],
    );
  }
}

class _PieChartCard extends StatelessWidget {
  final String title;
  final List<ChartData> data;
  final List<Color> colors;

  const _PieChartCard({
    required this.title,
    required this.data,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: SfCircularChart(
        title: ChartTitle(
          text: title,
        ),

        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
        ),

        series: [
          PieSeries<ChartData, String>(
            dataSource: data,

            pointColorMapper: (item, index) {
              return colors[index % colors.length];
            },

            xValueMapper: (item, _) => item.label,

            yValueMapper: (item, _) => item.value,

            dataLabelMapper: (item, _) {
              final total = data.fold<double>(
                0,
                (sum, e) => sum + e.value,
              );

              final percentage =
                  (item.value / total) * 100;

              return '${percentage.toStringAsFixed(0)}%';
            },

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