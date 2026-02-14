class TournamentActivity {
  final String tournamentId;
  final DateTime createdAt;
  final String type;
  final String? meta;
  final String? refId;

  final String? playerName;
  final String? teamName;
  final String? assistName;
  final int? team1Score;
  final int? team2Score;
  final int? minute;

  TournamentActivity({
    required this.tournamentId,
    required this.createdAt,
    required this.type,
    this.meta,
    this.refId,
    this.playerName,
    this.teamName,
    this.assistName,
    this.team1Score,
    this.team2Score,
    this.minute,
  });

  factory TournamentActivity.fromMap(Map<String, dynamic> map) {
    return TournamentActivity(
      tournamentId: map['tournament_id'] ?? '',
      createdAt:
          DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now(),
      type: map['type'] ?? '',
      meta: map['meta'],
      refId: map['ref_id'],
      playerName: map['player_name'],
      teamName: map['team_name'],
      assistName: map['assist_name'],
      team1Score: map['team1_score'],
      team2Score: map['team2_score'],
      minute: map['minute'],
    );
  }

  String get formattedMinute => minute != null ? "$minute'" : "";

  String get formattedTime {
    final diff = DateTime.now().difference(createdAt);

    if (diff.inMinutes < 1) return "Just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";
    return "${createdAt.day}/${createdAt.month}/${createdAt.year}";
  }

  bool get isGoal => meta == 'goal';
  bool get isYellow => meta == 'yellow_card';
  bool get isRed => meta == 'red_card';
  bool get isStatus => type == 'status_change';
}
