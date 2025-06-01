import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_achivements_widget.dart' show AddAchivementsWidget;
import 'package:flutter/material.dart';

class AddAchivementsModel extends FlutterFlowModel<AddAchivementsWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for otp_input widget.
  FocusNode? otpInputFocusNode1;
  TextEditingController? otpInputTextController1;
  String? Function(BuildContext, String?)? otpInputTextController1Validator;
  // State field(s) for otp_input widget.
  FocusNode? otpInputFocusNode2;
  TextEditingController? otpInputTextController2;
  String? Function(BuildContext, String?)? otpInputTextController2Validator;
  // State field(s) for otp_input widget.
  FocusNode? otpInputFocusNode3;
  TextEditingController? otpInputTextController3;
  String? Function(BuildContext, String?)? otpInputTextController3Validator;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  AchievementsRow? achieveme;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    otpInputFocusNode1?.dispose();
    otpInputTextController1?.dispose();

    otpInputFocusNode2?.dispose();
    otpInputTextController2?.dispose();

    otpInputFocusNode3?.dispose();
    otpInputTextController3?.dispose();
  }
}
