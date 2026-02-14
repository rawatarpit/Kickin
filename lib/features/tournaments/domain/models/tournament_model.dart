import '../tournament_lifecycle.dart';

class TournamentModel {
  final String id;
  final String slug; // ✅ NEW

  final String name;
  final TournamentStatus status;

  final DateTime? startDate;
  final DateTime? createdAt;

  final String? tournamentType;
  final String? tournamentFormat;

  final int? teamSize;
  final int? numberOfGroups;
  final int? teamsPerGroup;
  final String? roundRobinType;
  final int? qualifiersPerGroup;

  final int? entryFee;
  final String? poolPrize;
  final bool? isPaid;

  final String? createdBy;
  final String? ktmReporter;

  final String? location;
  final String? mediaUrl;
  final String? content;

  final bool? sponsorOn;
  final String? sponsorCode;
  final String? sponsorId;

  final List<String>? participantIds;

  final double? lat;
  final double? lng;

  final String? winnerId;
  final String? winnerName;
  final String? runnerupId;
  final String? runnerupName;

  TournamentModel({
    required this.id,
    required this.slug, // ✅ REQUIRED
    required this.name,
    required this.status,
    this.startDate,
    this.createdAt,
    this.tournamentType,
    this.tournamentFormat,
    this.teamSize,
    this.numberOfGroups,
    this.teamsPerGroup,
    this.roundRobinType,
    this.qualifiersPerGroup,
    this.entryFee,
    this.poolPrize,
    this.isPaid,
    this.createdBy,
    this.ktmReporter,
    this.location,
    this.mediaUrl,
    this.content,
    this.sponsorOn,
    this.sponsorCode,
    this.sponsorId,
    this.participantIds,
    this.lat,
    this.lng,
    this.winnerId,
    this.winnerName,
    this.runnerupId,
    this.runnerupName,
  });

  factory TournamentModel.fromMap(Map<String, dynamic> map) {
    return TournamentModel(
      id: map['tournament_id'],
      slug: map['slug'], // ✅ ADDED
      name: map['name'] ?? '',
      status: parseTournamentStatus(map['status']),
      startDate:
          map['start_date'] != null
              ? DateTime.tryParse(map['start_date'].toString())
              : null,
      createdAt:
          map['created_at'] != null
              ? DateTime.tryParse(map['created_at'].toString())
              : null,
      tournamentType: map['tournament_type'],
      tournamentFormat: map['tournament_format'],
      teamSize: map['team_size'],
      numberOfGroups: map['number_of_groups'],
      teamsPerGroup: map['teams_per_group'],
      roundRobinType: map['round_robin_type'],
      qualifiersPerGroup: map['qualifiers_per_group'],
      entryFee: map['entry_fee'],
      poolPrize: map['Pool_prize'],
      isPaid: map['is_paid'],
      createdBy: map['created_by'],
      ktmReporter: map['ktm_reporter'],
      location: map['location'],
      mediaUrl: map['media_url'],
      content: map['content'],
      sponsorOn: map['sponsor_On'],
      sponsorCode: map['sponsor_code'],
      sponsorId: map['sponsor_id'],
      participantIds:
          (map['participant_ids'] as List?)?.map((e) => e.toString()).toList(),
      lat: map['lat'] != null ? double.tryParse(map['lat'].toString()) : null,
      lng: map['lng'] != null ? double.tryParse(map['lng'].toString()) : null,
      winnerId: map['winner_id'],
      winnerName: map['winner_name'],
      runnerupId: map['runnerup_id'],
      runnerupName: map['runnerup_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tournament_id': id,
      'slug': slug, // ✅ ADDED
      'name': name,
      'status': tournamentStatusToDb(status),
      'start_date': startDate?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'tournament_type': tournamentType,
      'tournament_format': tournamentFormat,
      'team_size': teamSize,
      'number_of_groups': numberOfGroups,
      'teams_per_group': teamsPerGroup,
      'round_robin_type': roundRobinType,
      'qualifiers_per_group': qualifiersPerGroup,
      'entry_fee': entryFee,
      'Pool_prize': poolPrize,
      'is_paid': isPaid,
      'created_by': createdBy,
      'ktm_reporter': ktmReporter,
      'location': location,
      'media_url': mediaUrl,
      'content': content,
      'sponsor_On': sponsorOn,
      'sponsor_code': sponsorCode,
      'sponsor_id': sponsorId,
      'participant_ids': participantIds,
      'lat': lat,
      'lng': lng,
      'winner_id': winnerId,
      'winner_name': winnerName,
      'runnerup_id': runnerupId,
      'runnerup_name': runnerupName,
    };
  }

  bool get isLocked =>
      status == TournamentStatus.completed ||
      status == TournamentStatus.cancelled;

  bool get hasWinner => winnerId != null;
}
