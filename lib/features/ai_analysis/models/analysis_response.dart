import 'session_statistics.dart';
import 'timeline_item.dart';

class AnalysisResponse {
  final bool success;
  final String status;

  final SessionStatistics statistics;

  final List<TimelineItem> timeline;

  final String report;

  const AnalysisResponse({
    required this.success,
    required this.status,
    required this.statistics,
    required this.timeline,
    required this.report,
  });

  factory AnalysisResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AnalysisResponse(
      success: json['success'] ?? false,

      status: json['status'] ?? '',

      statistics: SessionStatistics.fromJson(
        json['session_statistics'],
      ),

      timeline:
          (json['detailed_timeline'] as List)
              .map(
                (e) => TimelineItem.fromJson(e),
              )
              .toList(),

      report:
          json['clinical_insight_report'] ?? '',
    );
  }
}