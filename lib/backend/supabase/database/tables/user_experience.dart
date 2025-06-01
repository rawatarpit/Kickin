import '../database.dart';

class UserExperienceTable extends SupabaseTable<UserExperienceRow> {
  @override
  String get tableName => 'user_experience';

  @override
  UserExperienceRow createRow(Map<String, dynamic> data) =>
      UserExperienceRow(data);
}

class UserExperienceRow extends SupabaseDataRow {
  UserExperienceRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserExperienceTable();

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get teamName => getField<String>('teamName');
  set teamName(String? value) => setField<String>('teamName', value);

  String? get startYear => getField<String>('startYear');
  set startYear(String? value) => setField<String>('startYear', value);

  String? get position => getField<String>('position');
  set position(String? value) => setField<String>('position', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);
}
