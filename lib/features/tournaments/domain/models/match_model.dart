enum MatchStatus { scheduled, ongoing, completed }

MatchStatus parseMatchStatus(String? raw) {
  switch (raw) {
    case 'scheduled':
    case 'upcoming':
      return MatchStatus.scheduled;
    case 'ongoing':
      return MatchStatus.ongoing;
    case 'completed':
      return MatchStatus.completed;
    default:
      return MatchStatus.scheduled;
  }
}

String matchStatusToDb(MatchStatus status) {
  switch (status) {
    case MatchStatus.scheduled:
      return 'scheduled';
    case MatchStatus.ongoing:
      return 'ongoing';
    case MatchStatus.completed:
      return 'completed';
  }
}

class MatchModel {
  final String id;
  final String tournamentId;
  final String round;

  final String? team1Id;
  final String? team2Id;

  final String? team1Name;
  final String? team2Name;

  final int? team1Score;
  final int? team2Score;

  final MatchStatus status;
  final DateTime? matchDate;
  final String? winnerId;

  MatchModel({
    required this.id,
    required this.tournamentId,
    required this.round,
    required this.status,
    this.team1Id,
    this.team2Id,
    this.team1Name,
    this.team2Name,
    this.team1Score,
    this.team2Score,
    this.matchDate,
    this.winnerId,
  });

  factory MatchModel.fromMap(Map<String, dynamic> map) {
    return MatchModel(
      id: map['match_id'],
      tournamentId: map['tournament_id'],
      round: map['round'] ?? '',
      status: parseMatchStatus(map['status']),
      team1Id: map['team1_id'],
      team2Id: map['team2_id'],
      team1Name: map['team1_name'],
      team2Name: map['team2_name'],
      team1Score: map['team1_score'],
      team2Score: map['team2_score'],
      matchDate:
          map['match_date'] != null
              ? DateTime.tryParse(map['match_date'].toString())
              : null,
      winnerId: map['winner_id'],
    );
  }

  bool get isScheduled => status == MatchStatus.scheduled;
  bool get isOngoing => status == MatchStatus.ongoing;
  bool get isCompleted => status == MatchStatus.completed;
  bool get isLocked => isCompleted;

  bool get hasTeams => team1Id != null && team2Id != null;
  bool get hasScore => team1Score != null && team2Score != null;
}
