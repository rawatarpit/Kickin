import '../database.dart';

class KtmGroupTeamsTable extends SupabaseTable<KtmGroupTeamsRow> {
  @override
  String get tableName => 'ktm_group_teams';

  @override
  KtmGroupTeamsRow createRow(Map<String, dynamic> data) =>
      KtmGroupTeamsRow(data);
}

class KtmGroupTeamsRow extends SupabaseDataRow {
  KtmGroupTeamsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => KtmGroupTeamsTable();

  String get groupId => getField<String>('group_id')!;
  set groupId(String value) => setField<String>('group_id', value);

  String get teamId => getField<String>('team_id')!;
  set teamId(String value) => setField<String>('team_id', value);

  String? get tournamentId => getField<String>('tournament_id');
  set tournamentId(String? value) => setField<String>('tournament_id', value);
}
