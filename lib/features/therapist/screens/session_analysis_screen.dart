import 'package:flutter/material.dart';
import 'package:my_therapy/common/widgets/custom_appbar.dart';

import '../../ai_analysis/data/mock_analysis_data.dart';
import '../../ai_analysis/models/analysis_response.dart';
import '../../ai_analysis/models/session_statistics.dart';
import '../../ai_analysis/models/timeline_item.dart';
import '../../ai_analysis/widgets/analysis_statistics_card.dart';
import '../../ai_analysis/widgets/clinical_report_card.dart';
import '../../ai_analysis/widgets/emotion_bar_chart.dart';
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

@override
void initState() {
  super.initState();

  analysis = AnalysisResponse.fromJson(
    MockAnalysisData.data,
  );
}


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: const CustomAppBar(
      title: 'Session Analysis',
      showBackArrow: true,
    ),
    body: SingleChildScrollView(
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

      const SizedBox(height: 24),

      const Text(
        'Voice Emotion Distribution',
      ),

      EmotionBarChart(
        timeline: analysis.timeline,
      ),

      const SizedBox(height: 24),

      const Text(
        'Clinical Insight Report',
      ),

      const SizedBox(height: 12),

      ClinicalReportCard(
        report: analysis.report,
      ),

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
    ],
  ),
),

  );
}

}