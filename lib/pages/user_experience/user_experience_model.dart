import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'user_experience_widget.dart' show UserExperienceWidget;
import 'package:flutter/material.dart';

class UserExperienceModel extends FlutterFlowModel<UserExperienceWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for player_team widget.
  FocusNode? playerTeamFocusNode;
  TextEditingController? playerTeamTextController;
  String? Function(BuildContext, String?)? playerTeamTextControllerValidator;
  // State field(s) for player_position widget.
  String? playerPositionValue;
  FormFieldController<String>? playerPositionValueController;
  // State field(s) for player_year widget.
  FocusNode? playerYearFocusNode;
  TextEditingController? playerYearTextController;
  String? Function(BuildContext, String?)? playerYearTextControllerValidator;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  UserExperienceRow? experience;
  // State field(s) for Coach_team widget.
  FocusNode? coachTeamFocusNode;
  TextEditingController? coachTeamTextController;
  String? Function(BuildContext, String?)? coachTeamTextControllerValidator;
  // State field(s) for Coach_license widget.
  String? coachLicenseValue;
  FormFieldController<String>? coachLicenseValueController;
  // State field(s) for Coach_year widget.
  FocusNode? coachYearFocusNode;
  TextEditingController? coachYearTextController;
  String? Function(BuildContext, String?)? coachYearTextControllerValidator;
  // State field(s) for agent_company widget.
  FocusNode? agentCompanyFocusNode;
  TextEditingController? agentCompanyTextController;
  String? Function(BuildContext, String?)? agentCompanyTextControllerValidator;
  // State field(s) for agent_year widget.
  FocusNode? agentYearFocusNode;
  TextEditingController? agentYearTextController;
  String? Function(BuildContext, String?)? agentYearTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    playerTeamFocusNode?.dispose();
    playerTeamTextController?.dispose();

    playerYearFocusNode?.dispose();
    playerYearTextController?.dispose();

    coachTeamFocusNode?.dispose();
    coachTeamTextController?.dispose();

    coachYearFocusNode?.dispose();
    coachYearTextController?.dispose();

    agentCompanyFocusNode?.dispose();
    agentCompanyTextController?.dispose();

    agentYearFocusNode?.dispose();
    agentYearTextController?.dispose();
  }
}
