import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'reset_password_widget.dart' show ResetPasswordWidget;
import 'package:flutter/material.dart';

class ResetPasswordModel extends FlutterFlowModel<ResetPasswordWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for create widget.
  FocusNode? createFocusNode;
  TextEditingController? createTextController;
  late bool createVisibility;
  String? Function(BuildContext, String?)? createTextControllerValidator;
  // State field(s) for confirm widget.
  FocusNode? confirmFocusNode;
  TextEditingController? confirmTextController;
  late bool confirmVisibility;
  String? Function(BuildContext, String?)? confirmTextControllerValidator;

  @override
  void initState(BuildContext context) {
    createVisibility = false;
    confirmVisibility = false;
  }

  @override
  void dispose() {
    createFocusNode?.dispose();
    createTextController?.dispose();

    confirmFocusNode?.dispose();
    confirmTextController?.dispose();
  }
}
