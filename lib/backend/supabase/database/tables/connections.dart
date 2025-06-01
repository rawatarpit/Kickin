import '../database.dart';

class ConnectionsTable extends SupabaseTable<ConnectionsRow> {
  @override
  String get tableName => 'connections';

  @override
  ConnectionsRow createRow(Map<String, dynamic> data) => ConnectionsRow(data);
}

class ConnectionsRow extends SupabaseDataRow {
  ConnectionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ConnectionsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get fromUserId => getField<String>('from_user_id');
  set fromUserId(String? value) => setField<String>('from_user_id', value);

  String? get toUserId => getField<String>('to_user_id');
  set toUserId(String? value) => setField<String>('to_user_id', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
