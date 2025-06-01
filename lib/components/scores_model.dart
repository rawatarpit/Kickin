import '/flutter_flow/flutter_flow_util.dart';
import 'scores_widget.dart' show ScoresWidget;
import 'package:flutter/material.dart';

class ScoresModel extends FlutterFlowModel<ScoresWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for otp_input widget.
  FocusNode? otpInputFocusNode1;
  TextEditingController? otpInputTextController1;
  String? Function(BuildContext, String?)? otpInputTextController1Validator;
  // State field(s) for otp_input widget.
  FocusNode? otpInputFocusNode2;
  TextEditingController? otpInputTextController2;
  String? Function(BuildContext, String?)? otpInputTextController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    otpInputFocusNode1?.dispose();
    otpInputTextController1?.dispose();

    otpInputFocusNode2?.dispose();
    otpInputTextController2?.dispose();
  }
}
