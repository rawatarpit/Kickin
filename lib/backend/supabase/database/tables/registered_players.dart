import '../database.dart';

class RegisteredPlayersTable extends SupabaseTable<RegisteredPlayersRow> {
  @override
  String get tableName => 'registered_players';

  @override
  RegisteredPlayersRow createRow(Map<String, dynamic> data) =>
      RegisteredPlayersRow(data);
}

class RegisteredPlayersRow extends SupabaseDataRow {
  RegisteredPlayersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RegisteredPlayersTable();

  String? get tournamentId => getField<String>('tournament_id');
  set tournamentId(String? value) => setField<String>('tournament_id', value);

  int get rankingPoints => getField<int>('ranking_points')!;
  set rankingPoints(int value) => setField<int>('ranking_points', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String? get position => getField<String>('position');
  set position(String? value) => setField<String>('position', value);

  String? get name => getField<String>('Name');
  set name(String? value) => setField<String>('Name', value);

  String? get pic => getField<String>('pic');
  set pic(String? value) => setField<String>('pic', value);
}
