import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'share_widget.dart' show ShareWidget;
import 'package:flutter/material.dart';

class ShareModel extends FlutterFlowModel<ShareWidget> {
  ///  Local state fields for this component.

  bool? searchBar = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Query Rows] action in TextField widget.
  List<UsersRow>? searchedUser;
  // Stores action output result for [Backend Call - API (Conversation)] action in Button widget.
  ApiCallResponse? convoCopy;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in Button widget.
  DocumentReference? recipentCopy;
  // Stores action output result for [Backend Call - API (Conversation)] action in Button widget.
  ApiCallResponse? convo;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in Button widget.
  DocumentReference? recipent;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
