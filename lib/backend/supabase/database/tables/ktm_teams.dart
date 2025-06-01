import '../database.dart';

class KtmTeamsTable extends SupabaseTable<KtmTeamsRow> {
  @override
  String get tableName => 'ktm_teams';

  @override
  KtmTeamsRow createRow(Map<String, dynamic> data) => KtmTeamsRow(data);
}

class KtmTeamsRow extends SupabaseDataRow {
  KtmTeamsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => KtmTeamsTable();

  String get teamId => getField<String>('team_id')!;
  set teamId(String value) => setField<String>('team_id', value);

  String? get tournamentId => getField<String>('tournament_id');
  set tournamentId(String? value) => setField<String>('tournament_id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String? get keyMemeberId => getField<String>('key_memeber_id');
  set keyMemeberId(String? value) => setField<String>('key_memeber_id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get groupId => getField<String>('group_id');
  set groupId(String? value) => setField<String>('group_id', value);

  List<String> get members => getListField<String>('Members');
  set members(List<String>? value) => setListField<String>('Members', value);

  String? get teamCode => getField<String>('team_code');
  set teamCode(String? value) => setField<String>('team_code', value);
}
