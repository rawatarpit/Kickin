import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'invite_teams_widget.dart' show InviteTeamsWidget;
import 'package:flutter/material.dart';

class InviteTeamsModel extends FlutterFlowModel<InviteTeamsWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in Invite_teams widget.
  List<UsersRecord>? users;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<UsersRecord> simpleSearchResults = [];
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  KtmTeamInvitationsRow? invited;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  KtmTeamInvitationsRow? invitedClub;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  KtmTeamInvitationsRow? invitedAcademy;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  KtmTeamInvitationsRow? invitedCoach;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    tabBarController?.dispose();
  }
}
