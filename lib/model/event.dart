
class Event {
  final String eventHash;
  final String summary;
  final String startTime;

  Event({
    required this.eventHash,
    required this.summary,
    required this.startTime,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventHash: json['id'],
      summary: json['summary'],
      startTime: json['start']['dateTime'],
    );
  }

  @override
  String toString() {
    return '{id: $eventHash, summary: $summary, startTime: $startTime}';
  }
}
