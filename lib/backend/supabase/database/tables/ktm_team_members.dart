import '../database.dart';

class KtmTeamMembersTable extends SupabaseTable<KtmTeamMembersRow> {
  @override
  String get tableName => 'ktm_team_members';

  @override
  KtmTeamMembersRow createRow(Map<String, dynamic> data) =>
      KtmTeamMembersRow(data);
}

class KtmTeamMembersRow extends SupabaseDataRow {
  KtmTeamMembersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => KtmTeamMembersTable();

  String get memberId => getField<String>('member_id')!;
  set memberId(String value) => setField<String>('member_id', value);

  String? get teamId => getField<String>('team_id');
  set teamId(String? value) => setField<String>('team_id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String? get type => getField<String>('type');
  set type(String? value) => setField<String>('type', value);

  DateTime? get joinedAt => getField<DateTime>('joined_at');
  set joinedAt(DateTime? value) => setField<DateTime>('joined_at', value);

  String? get tournamentId => getField<String>('tournament_id');
  set tournamentId(String? value) => setField<String>('tournament_id', value);
}
