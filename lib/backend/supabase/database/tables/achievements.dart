import '../database.dart';

class AchievementsTable extends SupabaseTable<AchievementsRow> {
  @override
  String get tableName => 'achievements';

  @override
  AchievementsRow createRow(Map<String, dynamic> data) => AchievementsRow(data);
}

class AchievementsRow extends SupabaseDataRow {
  AchievementsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AchievementsTable();

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  int? get year => getField<int>('year');
  set year(int? value) => setField<int>('year', value);

  String? get content => getField<String>('content');
  set content(String? value) => setField<String>('content', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);
}
