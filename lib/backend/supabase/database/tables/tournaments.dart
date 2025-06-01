import '../database.dart';

class TournamentsTable extends SupabaseTable<TournamentsRow> {
  @override
  String get tableName => 'tournaments';

  @override
  TournamentsRow createRow(Map<String, dynamic> data) => TournamentsRow(data);
}

class TournamentsRow extends SupabaseDataRow {
  TournamentsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TournamentsTable();

  String get tournamentId => getField<String>('tournament_id')!;
  set tournamentId(String value) => setField<String>('tournament_id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  DateTime? get startDate => getField<DateTime>('start_date');
  set startDate(DateTime? value) => setField<DateTime>('start_date', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String get tournamentType => getField<String>('tournament_type')!;
  set tournamentType(String value) =>
      setField<String>('tournament_type', value);

  String get tournamentFormat => getField<String>('tournament_format')!;
  set tournamentFormat(String value) =>
      setField<String>('tournament_format', value);

  int? get entryFee => getField<int>('entry_fee');
  set entryFee(int? value) => setField<int>('entry_fee', value);

  int? get teamSize => getField<int>('team_size');
  set teamSize(int? value) => setField<int>('team_size', value);

  int? get numberOfGroups => getField<int>('number_of_groups');
  set numberOfGroups(int? value) => setField<int>('number_of_groups', value);

  int? get teamsPerGroup => getField<int>('teams_per_group');
  set teamsPerGroup(int? value) => setField<int>('teams_per_group', value);

  String? get roundRobinType => getField<String>('round_robin_type');
  set roundRobinType(String? value) =>
      setField<String>('round_robin_type', value);

  int? get qualifiersPerGroup => getField<int>('qualifiers_per_group');
  set qualifiersPerGroup(int? value) =>
      setField<int>('qualifiers_per_group', value);

  String? get location => getField<String>('location');
  set location(String? value) => setField<String>('location', value);

  String? get mediaUrl => getField<String>('media_url');
  set mediaUrl(String? value) => setField<String>('media_url', value);

  String? get content => getField<String>('content');
  set content(String? value) => setField<String>('content', value);

  String? get poolPrize => getField<String>('Pool_prize');
  set poolPrize(String? value) => setField<String>('Pool_prize', value);

  bool? get sponsorOn => getField<bool>('sponsor_On');
  set sponsorOn(bool? value) => setField<bool>('sponsor_On', value);

  String? get sponsorCode => getField<String>('sponsor_code');
  set sponsorCode(String? value) => setField<String>('sponsor_code', value);

  String? get sponsorId => getField<String>('sponsor_id');
  set sponsorId(String? value) => setField<String>('sponsor_id', value);

  String? get tournamentLink => getField<String>('tournament_link');
  set tournamentLink(String? value) =>
      setField<String>('tournament_link', value);

  String? get creteadBy => getField<String>('cretead_by');
  set creteadBy(String? value) => setField<String>('cretead_by', value);

  String? get geolocation => getField<String>('geolocation');
  set geolocation(String? value) => setField<String>('geolocation', value);

  List<String> get participantIds => getListField<String>('participant_ids');
  set participantIds(List<String>? value) =>
      setListField<String>('participant_ids', value);

  double? get lng => getField<double>('lng');
  set lng(double? value) => setField<double>('lng', value);

  double? get lat => getField<double>('lat');
  set lat(double? value) => setField<double>('lat', value);

  bool? get isPaid => getField<bool>('is_paid');
  set isPaid(bool? value) => setField<bool>('is_paid', value);

  String? get subscriptionId => getField<String>('subscription_id');
  set subscriptionId(String? value) =>
      setField<String>('subscription_id', value);

  String? get tournamentCode => getField<String>('tournament_code');
  set tournamentCode(String? value) =>
      setField<String>('tournament_code', value);

  String? get merchantOrderId => getField<String>('merchant_order_id');
  set merchantOrderId(String? value) =>
      setField<String>('merchant_order_id', value);
}
