class StandingModel {
  final String teamId;
  final String teamName;
  final int matchesPlayed;
  final int wins;
  final int draws;
  final int losses;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDifference;
  final int points;
  final int? rank;

  StandingModel({
    required this.teamId,
    required this.teamName,
    required this.matchesPlayed,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDifference,
    required this.points,
    this.rank,
  });

  factory StandingModel.fromMap(Map<String, dynamic> map) {
    return StandingModel(
      teamId: map['team_id'] ?? '',
      teamName: map['team_name'] ?? '',
      matchesPlayed: map['matches_played'] ?? 0,
      wins: map['wins'] ?? 0,
      draws: map['draws'] ?? 0,
      losses: map['losses'] ?? 0,
      goalsFor: map['goals_for'] ?? 0,
      goalsAgainst: map['goals_against'] ?? 0,
      goalDifference: map['goal_difference'] ?? 0,
      points: map['points'] ?? 0,
      rank: map['rank'],
    );
  }
}
