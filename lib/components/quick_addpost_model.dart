import '/flutter_flow/flutter_flow_util.dart';
import 'quick_addpost_widget.dart' show QuickAddpostWidget;
import 'package:flutter/material.dart';

class QuickAddpostModel extends FlutterFlowModel<QuickAddpostWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
