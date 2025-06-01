import '/flutter_flow/flutter_flow_util.dart';
import 'add_team_code_widget.dart' show AddTeamCodeWidget;
import 'package:flutter/material.dart';

class AddTeamCodeModel extends FlutterFlowModel<AddTeamCodeWidget> {
  ///  Local state fields for this component.

  List<String> memebers = [];
  void addToMemebers(String item) => memebers.add(item);
  void removeFromMemebers(String item) => memebers.remove(item);
  void removeAtIndexFromMemebers(int index) => memebers.removeAt(index);
  void insertAtIndexInMemebers(int index, String item) =>
      memebers.insert(index, item);
  void updateMemebersAtIndex(int index, Function(String) updateFn) =>
      memebers[index] = updateFn(memebers[index]);

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
