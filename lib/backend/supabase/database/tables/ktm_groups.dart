import '../database.dart';

class KtmGroupsTable extends SupabaseTable<KtmGroupsRow> {
  @override
  String get tableName => 'ktm_groups';

  @override
  KtmGroupsRow createRow(Map<String, dynamic> data) => KtmGroupsRow(data);
}

class KtmGroupsRow extends SupabaseDataRow {
  KtmGroupsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => KtmGroupsTable();

  String get groupId => getField<String>('group_id')!;
  set groupId(String value) => setField<String>('group_id', value);

  String? get tournamentId => getField<String>('tournament_id');
  set tournamentId(String? value) => setField<String>('tournament_id', value);

  String get groupName => getField<String>('group_name')!;
  set groupName(String value) => setField<String>('group_name', value);
}
