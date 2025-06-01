import '../database.dart';

class JobApplicationsTable extends SupabaseTable<JobApplicationsRow> {
  @override
  String get tableName => 'job_applications';

  @override
  JobApplicationsRow createRow(Map<String, dynamic> data) =>
      JobApplicationsRow(data);
}

class JobApplicationsRow extends SupabaseDataRow {
  JobApplicationsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => JobApplicationsTable();

  String get applicationId => getField<String>('application_id')!;
  set applicationId(String value) => setField<String>('application_id', value);

  String? get jobId => getField<String>('job_id');
  set jobId(String? value) => setField<String>('job_id', value);

  String? get applicantId => getField<String>('applicant_id');
  set applicantId(String? value) => setField<String>('applicant_id', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
