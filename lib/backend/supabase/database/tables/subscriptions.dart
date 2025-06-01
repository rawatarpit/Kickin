import '../database.dart';

class SubscriptionsTable extends SupabaseTable<SubscriptionsRow> {
  @override
  String get tableName => 'subscriptions';

  @override
  SubscriptionsRow createRow(Map<String, dynamic> data) =>
      SubscriptionsRow(data);
}

class SubscriptionsRow extends SupabaseDataRow {
  SubscriptionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SubscriptionsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get title => getField<String>('title')!;
  set title(String value) => setField<String>('title', value);

  int get price => getField<int>('price')!;
  set price(int value) => setField<int>('price', value);

  bool? get isTournament => getField<bool>('is_tournament');
  set isTournament(bool? value) => setField<bool>('is_tournament', value);

  List<String> get features => getListField<String>('features');
  set features(List<String>? value) => setListField<String>('features', value);

  int? get potentialUsers => getField<int>('potential_users');
  set potentialUsers(int? value) => setField<int>('potential_users', value);

  int? get convertedUsers => getField<int>('converted_users');
  set convertedUsers(int? value) => setField<int>('converted_users', value);

  List<String> get userIds => getListField<String>('user_ids');
  set userIds(List<String>? value) => setListField<String>('user_ids', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  int? get amount => getField<int>('amount');
  set amount(int? value) => setField<int>('amount', value);
}
