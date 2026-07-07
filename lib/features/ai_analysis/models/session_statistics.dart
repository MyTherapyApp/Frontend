class SessionStatistics {
  final int totalChunksProcessed;
  final double processingTime;
  final double reportTime;

  const SessionStatistics({
    required this.totalChunksProcessed,
    required this.processingTime,
    required this.reportTime,
  });

  factory SessionStatistics.fromJson(
    Map<String, dynamic> json,
  ) {
    return SessionStatistics(
      totalChunksProcessed:
          json['total_chunks_processed'] ?? 0,

      processingTime:
          (json['total_processing_latency_sec'] ?? 0)
              .toDouble(),

      reportTime:
          (json['llm_report_latency_sec'] ?? 0)
              .toDouble(),
    );
  }
}