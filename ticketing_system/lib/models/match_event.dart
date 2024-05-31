class MatchEvent {
  final String id;
  final String name;
  final DateTime date;

  MatchEvent({required this.id, required this.name, required this.date});

  factory MatchEvent.fromJson(Map<String, dynamic> json) {
    return MatchEvent(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
    );
  }
}
