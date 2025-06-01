import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'ktm_tournament_details_widget.dart' show KtmTournamentDetailsWidget;
import 'package:flutter/material.dart';

class KtmTournamentDetailsModel
    extends FlutterFlowModel<KtmTournamentDetailsWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for otp_input widget.
  FocusNode? otpInputFocusNode1;
  TextEditingController? otpInputTextController1;
  String? Function(BuildContext, String?)? otpInputTextController1Validator;
  // State field(s) for otp_input widget.
  FocusNode? otpInputFocusNode2;
  TextEditingController? otpInputTextController2;
  String? Function(BuildContext, String?)? otpInputTextController2Validator;
  // State field(s) for Switch widget.
  bool? switchValue;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<TournamentsRow>? updatedEvent;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    otpInputFocusNode1?.dispose();
    otpInputTextController1?.dispose();

    otpInputFocusNode2?.dispose();
    otpInputTextController2?.dispose();
  }
}
