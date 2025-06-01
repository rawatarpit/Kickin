import '../database.dart';

class UsersTable extends SupabaseTable<UsersRow> {
  @override
  String get tableName => 'users';

  @override
  UsersRow createRow(Map<String, dynamic> data) => UsersRow(data);
}

class UsersRow extends SupabaseDataRow {
  UsersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UsersTable();

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  String? get phone => getField<String>('phone');
  set phone(String? value) => setField<String>('phone', value);

  String? get profilePic => getField<String>('profile_pic');
  set profilePic(String? value) => setField<String>('profile_pic', value);

  String? get role => getField<String>('role');
  set role(String? value) => setField<String>('role', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get dateOfBirth => getField<String>('date_of_birth');
  set dateOfBirth(String? value) => setField<String>('date_of_birth', value);

  String? get gender => getField<String>('gender');
  set gender(String? value) => setField<String>('gender', value);

  List<String> get connectedWith => getListField<String>('connected_with');
  set connectedWith(List<String>? value) =>
      setListField<String>('connected_with', value);

  String? get bio => getField<String>('bio');
  set bio(String? value) => setField<String>('bio', value);

  String? get geolocation => getField<String>('geolocation');
  set geolocation(String? value) => setField<String>('geolocation', value);

  bool? get isTopUser => getField<bool>('is_topUser');
  set isTopUser(bool? value) => setField<bool>('is_topUser', value);

  bool? get subscribedUser => getField<bool>('subscribed_user');
  set subscribedUser(bool? value) => setField<bool>('subscribed_user', value);
}
