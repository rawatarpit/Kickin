import '/flutter_flow/flutter_flow_util.dart';
import 'report_user_widget.dart' show ReportUserWidget;
import 'package:flutter/material.dart';

class ReportUserModel extends FlutterFlowModel<ReportUserWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for report_inut widget.
  FocusNode? reportInutFocusNode;
  TextEditingController? reportInutTextController;
  String? Function(BuildContext, String?)? reportInutTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    reportInutFocusNode?.dispose();
    reportInutTextController?.dispose();
  }
}
