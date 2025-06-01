import '/flutter_flow/flutter_flow_util.dart';
import 'tournament_code_widget.dart' show TournamentCodeWidget;
import 'package:flutter/material.dart';

class TournamentCodeModel extends FlutterFlowModel<TournamentCodeWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for code widget.
  FocusNode? codeFocusNode;
  TextEditingController? codeTextController;
  String? Function(BuildContext, String?)? codeTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    codeFocusNode?.dispose();
    codeTextController?.dispose();
  }
}
