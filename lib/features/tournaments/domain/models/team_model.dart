class TeamModel {
  final String id;
  final String tournamentId;
  final String name;
  final String? keyMemberId;
  final String? teamCode;
  final String? logoUrl;

  TeamModel({
    required this.id,
    required this.tournamentId,
    required this.name,
    this.keyMemberId,
    this.teamCode,
    this.logoUrl,
  });

  factory TeamModel.fromMap(Map<String, dynamic> map) {
    return TeamModel(
      id: map['team_id'] ?? '',
      tournamentId: map['tournament_id'] ?? '',
      name: map['name'] ?? '',
      keyMemberId: map['key_member_id'],
      teamCode: map['team_code'],
      logoUrl: map['team_logo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tournament_id': tournamentId,
      'name': name,
      'key_member_id': keyMemberId,
      'team_code': teamCode,
      'team_logo': logoUrl,
    };
  }
}
