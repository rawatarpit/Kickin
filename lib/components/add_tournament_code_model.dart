import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_tournament_code_widget.dart' show AddTournamentCodeWidget;
import 'package:flutter/material.dart';

class AddTournamentCodeModel extends FlutterFlowModel<AddTournamentCodeWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<TournamentsRow>? validNewCode;
  // Stores action output result for [Custom Action - generateTournamentCode] action in Button widget.
  String? teamCode;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  KtmTeamsRow? addedTeam;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
