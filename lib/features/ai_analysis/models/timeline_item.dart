class TimelineItem {
  final String transcript;
  final String sentiment;
  final String emotion;

  const TimelineItem({
    required this.transcript,
    required this.sentiment,
    required this.emotion,
  });

  factory TimelineItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return TimelineItem(
      transcript: json['transcript'] ?? '',
      sentiment: json['semantic_sentiment'] ?? '',
      emotion: json['vocal_acoustic_emotion'] ?? '',
    );
  }
}