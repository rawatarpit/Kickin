import '/flutter_flow/flutter_flow_util.dart';
import 'bio_widget.dart' show BioWidget;
import 'package:flutter/material.dart';

class BioModel extends FlutterFlowModel<BioWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for otp_input widget.
  FocusNode? otpInputFocusNode;
  TextEditingController? otpInputTextController;
  String? Function(BuildContext, String?)? otpInputTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    otpInputFocusNode?.dispose();
    otpInputTextController?.dispose();
  }
}
