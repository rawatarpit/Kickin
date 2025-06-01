import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'k_t_mpricing_widget.dart' show KTMpricingWidget;
import 'package:flutter/material.dart';

class KTMpricingModel extends FlutterFlowModel<KTMpricingWidget> {
  ///  Local state fields for this component.

  int? box = 1;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in KTMpricing widget.
  List<TournamentsRow>? event;
  // Stores action output result for [Backend Call - API (token)] action in Button widget.
  ApiCallResponse? token;
  // Stores action output result for [Backend Call - API (Create Payment Order)] action in Button widget.
  ApiCallResponse? url;
  // Stores action output result for [Custom Action - generateTournamentCode] action in Button widget.
  String? code;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<TournamentsRow>? updated;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
