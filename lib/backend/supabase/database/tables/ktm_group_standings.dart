import '../database.dart';

class KtmGroupStandingsTable extends SupabaseTable<KtmGroupStandingsRow> {
  @override
  String get tableName => 'ktm_group_standings';

  @override
  KtmGroupStandingsRow createRow(Map<String, dynamic> data) =>
      KtmGroupStandingsRow(data);
}

class KtmGroupStandingsRow extends SupabaseDataRow {
  KtmGroupStandingsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => KtmGroupStandingsTable();

  String get standingId => getField<String>('standing_id')!;
  set standingId(String value) => setField<String>('standing_id', value);

  String? get tournamentId => getField<String>('tournament_id');
  set tournamentId(String? value) => setField<String>('tournament_id', value);

  String? get groupId => getField<String>('group_id');
  set groupId(String? value) => setField<String>('group_id', value);

  String? get teamId => getField<String>('team_id');
  set teamId(String? value) => setField<String>('team_id', value);

  int? get matchesPlayed => getField<int>('matches_played');
  set matchesPlayed(int? value) => setField<int>('matches_played', value);

  int? get wins => getField<int>('wins');
  set wins(int? value) => setField<int>('wins', value);

  int? get draws => getField<int>('draws');
  set draws(int? value) => setField<int>('draws', value);

  int? get losses => getField<int>('losses');
  set losses(int? value) => setField<int>('losses', value);

  int? get goalsFor => getField<int>('goals_for');
  set goalsFor(int? value) => setField<int>('goals_for', value);

  int? get goalsAgainst => getField<int>('goals_against');
  set goalsAgainst(int? value) => setField<int>('goals_against', value);

  int? get goalDifference => getField<int>('goal_difference');
  set goalDifference(int? value) => setField<int>('goal_difference', value);

  int? get points => getField<int>('points');
  set points(int? value) => setField<int>('points', value);

  int? get rank => getField<int>('rank');
  set rank(int? value) => setField<int>('rank', value);

  String? get groupName => getField<String>('group_name');
  set groupName(String? value) => setField<String>('group_name', value);

  String? get teamName => getField<String>('team_name');
  set teamName(String? value) => setField<String>('team_name', value);
}
