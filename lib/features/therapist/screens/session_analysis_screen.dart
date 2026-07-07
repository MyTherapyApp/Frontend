import 'package:flutter/material.dart';
import 'package:my_therapy/common/widgets/custom_appbar.dart';

import '../../ai_analysis/data/mock_analysis_data.dart';
import '../../ai_analysis/models/analysis_response.dart';
// import '../../ai_analysis/models/session_statistics.dart';
// import '../../ai_analysis/models/timeline_item.dart';
import '../../ai_analysis/widgets/analysis_statistics_card.dart';
import '../../ai_analysis/widgets/clinical_report_card.dart';
// import '../../ai_analysis/widgets/emotion_bar_chart.dart';
import '../../ai_analysis/widgets/mood_line_chart.dart';
import '../../ai_analysis/widgets/sentiment_pie_chart.dart';
import '../../ai_analysis/widgets/transcript_timeline_tile.dart';


class SessionAnalysisScreen extends StatefulWidget {
  const SessionAnalysisScreen({super.key});

  @override
  State<SessionAnalysisScreen> createState() => _SessionAnalysisScreenState();
  
}

class _SessionAnalysisScreenState extends State<SessionAnalysisScreen> {
  late final AnalysisResponse analysis;
  bool _isLoading = true;
  double _progress = 0;

@override
void initState() {
  super.initState();

  analysis = AnalysisResponse.fromJson(
    MockAnalysisData.data,
  );

  _startLoading();
}

Future<void> _startLoading() async {
  const totalDuration = Duration(seconds: 4);
  const stepDuration = Duration(milliseconds: 40);

  final totalSteps =
      totalDuration.inMilliseconds ~/ stepDuration.inMilliseconds;

  for (int i = 0; i <= totalSteps; i++) {
    await Future.delayed(stepDuration);

    if (!mounted) return;

    setState(() {
      _progress = i / totalSteps;
    });
  }

  setState(() {
    _isLoading = false;
  });
}


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: const CustomAppBar(
      title: 'Session Analysis',
      showBackArrow: true,
    ),
    body: _isLoading
    ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: CircularProgressIndicator(
                value: _progress,
                strokeWidth: 8,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '${(_progress * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Analyzing Session...',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      )
    : SingleChildScrollView(
  padding: const EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment:
        CrossAxisAlignment.start,
    children: [

      AnalysisStatisticsCard(
        statistics:
            analysis.statistics,
      ),

      const SizedBox(height: 24),

      const Text(
        'Mood Timeline',
      ),

      MoodLineChart(
        timeline: analysis.timeline,
      ),

      const SizedBox(height: 24),

      const Text(
        'Sentiment Distribution',
      ),

      SentimentPieChart(
        timeline: analysis.timeline,
      ),

      // const SizedBox(height: 24),

      // const Text(
      //   'Voice Emotion Distribution',
      // ),

      // EmotionBarChart(
      //   timeline: analysis.timeline,
      // ),

      const SizedBox(height: 24),

      

      const Text(
        'Detailed Timeline',
      ),

      const SizedBox(height: 12),

      ListView.builder(
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(),
        itemCount:
            analysis.timeline.length,
        itemBuilder:
            (_, index) =>
                TranscriptTimelineTile(
          item:
              analysis.timeline[index],
          index: index,
        ),
      ),
      const Text(
        'Clinical Insight Report',
      ),

      const SizedBox(height: 12),

      ClinicalReportCard(
        report: analysis.report,
      ),

      const SizedBox(height: 24),
    ],
  ),
),

  );
}

}