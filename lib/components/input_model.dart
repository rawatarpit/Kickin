import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'input_widget.dart' show InputWidget;
import 'package:flutter/material.dart';

class InputModel extends FlutterFlowModel<InputWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for input_message widget.
  FocusNode? inputMessageFocusNode;
  TextEditingController? inputMessageTextController;
  String? Function(BuildContext, String?)? inputMessageTextControllerValidator;
  // Stores action output result for [Backend Call - API (Conversation)] action in IconButton widget.
  ApiCallResponse? chat;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in IconButton widget.
  DocumentReference? creatorUser;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    inputMessageFocusNode?.dispose();
    inputMessageTextController?.dispose();
  }
}
