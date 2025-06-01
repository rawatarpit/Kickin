import '../database.dart';

class LoserBracketTable extends SupabaseTable<LoserBracketRow> {
  @override
  String get tableName => 'loser_bracket';

  @override
  LoserBracketRow createRow(Map<String, dynamic> data) => LoserBracketRow(data);
}

class LoserBracketRow extends SupabaseDataRow {
  LoserBracketRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => LoserBracketTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get tournamentId => getField<String>('tournament_id');
  set tournamentId(String? value) => setField<String>('tournament_id', value);

  String get round => getField<String>('round')!;
  set round(String value) => setField<String>('round', value);

  String? get player1 => getField<String>('player1');
  set player1(String? value) => setField<String>('player1', value);

  String? get player2 => getField<String>('player2');
  set player2(String? value) => setField<String>('player2', value);

  String? get winner => getField<String>('winner');
  set winner(String? value) => setField<String>('winner', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
