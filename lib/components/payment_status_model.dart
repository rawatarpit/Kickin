import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/loading_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'payment_status_widget.dart' show PaymentStatusWidget;
import 'package:flutter/material.dart';

class PaymentStatusModel extends FlutterFlowModel<PaymentStatusWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (orderStatus)] action in paymentStatus widget.
  ApiCallResponse? apiResultamp;
  // Stores action output result for [Backend Call - Update Row(s)] action in paymentStatus widget.
  List<PaymentsRow>? updated;
  // Model for loading component.
  late LoadingModel loadingModel;

  @override
  void initState(BuildContext context) {
    loadingModel = createModel(context, () => LoadingModel());
  }

  @override
  void dispose() {
    loadingModel.dispose();
  }
}
