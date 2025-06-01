import '../database.dart';

class TournamentMediaTable extends SupabaseTable<TournamentMediaRow> {
  @override
  String get tableName => 'tournament_media';

  @override
  TournamentMediaRow createRow(Map<String, dynamic> data) =>
      TournamentMediaRow(data);
}

class TournamentMediaRow extends SupabaseDataRow {
  TournamentMediaRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TournamentMediaTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  List<String> get imageUrl => getListField<String>('image_url');
  set imageUrl(List<String>? value) => setListField<String>('image_url', value);

  String? get tournamentId => getField<String>('tournament_id');
  set tournamentId(String? value) => setField<String>('tournament_id', value);
}
