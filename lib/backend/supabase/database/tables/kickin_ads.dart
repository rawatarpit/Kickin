import '../database.dart';

class KickinAdsTable extends SupabaseTable<KickinAdsRow> {
  @override
  String get tableName => 'kickin_ads';

  @override
  KickinAdsRow createRow(Map<String, dynamic> data) => KickinAdsRow(data);
}

class KickinAdsRow extends SupabaseDataRow {
  KickinAdsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => KickinAdsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get sponsorId => getField<String>('sponsor_id');
  set sponsorId(String? value) => setField<String>('sponsor_id', value);

  String? get postedBy => getField<String>('posted_by');
  set postedBy(String? value) => setField<String>('posted_by', value);

  String? get tournamentId => getField<String>('tournament_id');
  set tournamentId(String? value) => setField<String>('tournament_id', value);

  String get imageUrl => getField<String>('image_url')!;
  set imageUrl(String value) => setField<String>('image_url', value);

  String? get redirectUrl => getField<String>('redirect_url');
  set redirectUrl(String? value) => setField<String>('redirect_url', value);

  int? get views => getField<int>('views');
  set views(int? value) => setField<int>('views', value);

  List<String> get viewedBy => getListField<String>('viewed_by');
  set viewedBy(List<String>? value) => setListField<String>('viewed_by', value);

  int? get clicks => getField<int>('clicks');
  set clicks(int? value) => setField<int>('clicks', value);

  List<String> get clickedBy => getListField<String>('clicked_by');
  set clickedBy(List<String>? value) =>
      setListField<String>('clicked_by', value);

  String get type => getField<String>('type')!;
  set type(String value) => setField<String>('type', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
