import '../database.dart';

class KtmMatchesTable extends SupabaseTable<KtmMatchesRow> {
  @override
  String get tableName => 'ktm_matches';

  @override
  KtmMatchesRow createRow(Map<String, dynamic> data) => KtmMatchesRow(data);
}

class KtmMatchesRow extends SupabaseDataRow {
  KtmMatchesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => KtmMatchesTable();

  String get matchId => getField<String>('match_id')!;
  set matchId(String value) => setField<String>('match_id', value);

  String? get tournamentId => getField<String>('tournament_id');
  set tournamentId(String? value) => setField<String>('tournament_id', value);

  String get round => getField<String>('round')!;
  set round(String value) => setField<String>('round', value);

  String? get team1Id => getField<String>('team1_id');
  set team1Id(String? value) => setField<String>('team1_id', value);

  String? get team2Id => getField<String>('team2_id');
  set team2Id(String? value) => setField<String>('team2_id', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  DateTime? get matchDate => getField<DateTime>('match_date');
  set matchDate(DateTime? value) => setField<DateTime>('match_date', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get winnerId => getField<String>('winner_id');
  set winnerId(String? value) => setField<String>('winner_id', value);

  String? get groupId => getField<String>('group_id');
  set groupId(String? value) => setField<String>('group_id', value);

  int? get team1Score => getField<int>('team1_score');
  set team1Score(int? value) => setField<int>('team1_score', value);

  int? get team2Score => getField<int>('team2_score');
  set team2Score(int? value) => setField<int>('team2_score', value);

  String? get team1Name => getField<String>('team1Name');
  set team1Name(String? value) => setField<String>('team1Name', value);

  String? get team2Name => getField<String>('team2Name');
  set team2Name(String? value) => setField<String>('team2Name', value);
}
