import '../database.dart';

class SponsorsTable extends SupabaseTable<SponsorsRow> {
  @override
  String get tableName => 'sponsors';

  @override
  SponsorsRow createRow(Map<String, dynamic> data) => SponsorsRow(data);
}

class SponsorsRow extends SupabaseDataRow {
  SponsorsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SponsorsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String get email => getField<String>('email')!;
  set email(String value) => setField<String>('email', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get companyName => getField<String>('company_name');
  set companyName(String? value) => setField<String>('company_name', value);

  String? get sponsorType => getField<String>('sponsor_type');
  set sponsorType(String? value) => setField<String>('sponsor_type', value);

  String? get phoneNumber => getField<String>('phone_number');
  set phoneNumber(String? value) => setField<String>('phone_number', value);
}
