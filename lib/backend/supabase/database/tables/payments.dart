import '../database.dart';

class PaymentsTable extends SupabaseTable<PaymentsRow> {
  @override
  String get tableName => 'payments';

  @override
  PaymentsRow createRow(Map<String, dynamic> data) => PaymentsRow(data);
}

class PaymentsRow extends SupabaseDataRow {
  PaymentsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PaymentsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String get subscriptionId => getField<String>('subscription_id')!;
  set subscriptionId(String value) =>
      setField<String>('subscription_id', value);

  double get amount => getField<double>('amount')!;
  set amount(double value) => setField<double>('amount', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  String? get phonepeMerchantOrderId =>
      getField<String>('phonepe_merchant_order_id');
  set phonepeMerchantOrderId(String? value) =>
      setField<String>('phonepe_merchant_order_id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);

  dynamic get phonepeResponse => getField<dynamic>('phonepe_response');
  set phonepeResponse(dynamic value) =>
      setField<dynamic>('phonepe_response', value);

  bool? get isTournament => getField<bool>('is_tournament');
  set isTournament(bool? value) => setField<bool>('is_tournament', value);
}
