import '/flutter_flow/flutter_flow_util.dart';
import 'job_widget.dart' show JobWidget;
import 'package:flutter/material.dart';

class JobModel extends FlutterFlowModel<JobWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for otp_input widget.
  FocusNode? otpInputFocusNode1;
  TextEditingController? otpInputTextController1;
  String? Function(BuildContext, String?)? otpInputTextController1Validator;
  // State field(s) for otp_input widget.
  FocusNode? otpInputFocusNode2;
  TextEditingController? otpInputTextController2;
  String? Function(BuildContext, String?)? otpInputTextController2Validator;
  // State field(s) for PlacePicker widget.
  FFPlace placePickerValue = FFPlace();
  // State field(s) for otp_input widget.
  FocusNode? otpInputFocusNode3;
  TextEditingController? otpInputTextController3;
  String? Function(BuildContext, String?)? otpInputTextController3Validator;

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
