import '../database.dart';

class JobsTable extends SupabaseTable<JobsRow> {
  @override
  String get tableName => 'jobs';

  @override
  JobsRow createRow(Map<String, dynamic> data) => JobsRow(data);
}

class JobsRow extends SupabaseDataRow {
  JobsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => JobsTable();

  String get jobId => getField<String>('job_id')!;
  set jobId(String value) => setField<String>('job_id', value);

  String? get companyId => getField<String>('company_id');
  set companyId(String? value) => setField<String>('company_id', value);

  String get title => getField<String>('title')!;
  set title(String value) => setField<String>('title', value);

  String get description => getField<String>('description')!;
  set description(String value) => setField<String>('description', value);

  String? get location => getField<String>('location');
  set location(String? value) => setField<String>('location', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get experience => getField<String>('Experience');
  set experience(String? value) => setField<String>('Experience', value);

  String? get createdBy => getField<String>('created_by');
  set createdBy(String? value) => setField<String>('created_by', value);
}
