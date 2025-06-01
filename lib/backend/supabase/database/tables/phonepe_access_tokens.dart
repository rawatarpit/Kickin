import '../database.dart';

class PhonepeAccessTokensTable extends SupabaseTable<PhonepeAccessTokensRow> {
  @override
  String get tableName => 'phonepe_access_tokens';

  @override
  PhonepeAccessTokensRow createRow(Map<String, dynamic> data) =>
      PhonepeAccessTokensRow(data);
}

class PhonepeAccessTokensRow extends SupabaseDataRow {
  PhonepeAccessTokensRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PhonepeAccessTokensTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get accessToken => getField<String>('access_token')!;
  set accessToken(String value) => setField<String>('access_token', value);

  int get expiresAt => getField<int>('expires_at')!;
  set expiresAt(int value) => setField<int>('expires_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);
}
