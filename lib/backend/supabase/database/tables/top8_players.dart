import '../database.dart';

class Top8PlayersTable extends SupabaseTable<Top8PlayersRow> {
  @override
  String get tableName => 'top8_players';

  @override
  Top8PlayersRow createRow(Map<String, dynamic> data) => Top8PlayersRow(data);
}

class Top8PlayersRow extends SupabaseDataRow {
  Top8PlayersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => Top8PlayersTable();

  String? get tournamentId => getField<String>('tournament_id');
  set tournamentId(String? value) => setField<String>('tournament_id', value);

  String get playerId => getField<String>('player_id')!;
  set playerId(String value) => setField<String>('player_id', value);

  int? get finalRank => getField<int>('final_rank');
  set finalRank(int? value) => setField<int>('final_rank', value);

  bool get fromLosers => getField<bool>('from_losers')!;
  set fromLosers(bool value) => setField<bool>('from_losers', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get profilePic => getField<String>('profile_pic');
  set profilePic(String? value) => setField<String>('profile_pic', value);
}
