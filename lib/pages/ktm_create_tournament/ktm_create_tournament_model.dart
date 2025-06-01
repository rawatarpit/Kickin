import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'ktm_create_tournament_widget.dart' show KtmCreateTournamentWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KtmCreateTournamentModel
    extends FlutterFlowModel<KtmCreateTournamentWidget> {
  ///  Local state fields for this page.

  String? mediaUrl;

  ///  State fields for stateful widgets in this page.

  bool isDataUploading_tournamentMedias = false;
  FFUploadedFile uploadedLocalFile_tournamentMedias =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_tournamentMedias = '';

  bool isDataUploading_tournamentMedia = false;
  FFUploadedFile uploadedLocalFile_tournamentMedia =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_tournamentMedia = '';

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // Stores action output result for [Bottom Sheet - search_location] action in Container widget.
  dynamic place;
  DateTime? datePicked;
  // State field(s) for format_options widget.
  String? formatOptionsValue;
  FormFieldController<String>? formatOptionsValueController;
  // State field(s) for team_size widget.
  FocusNode? teamSizeFocusNode;
  TextEditingController? teamSizeTextController;
  String? Function(BuildContext, String?)? teamSizeTextControllerValidator;
  // State field(s) for otp_input widget.
  FocusNode? otpInputFocusNode1;
  TextEditingController? otpInputTextController1;
  String? Function(BuildContext, String?)? otpInputTextController1Validator;
  // State field(s) for otp_input widget.
  FocusNode? otpInputFocusNode2;
  TextEditingController? otpInputTextController2;
  String? Function(BuildContext, String?)? otpInputTextController2Validator;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  TournamentsRow? createdTournament;
  // Stores action output result for [Backend Call - API (Update Tournament Geolocation)] action in Button widget.
  ApiCallResponse? apiResulthxm;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    teamSizeFocusNode?.dispose();
    teamSizeTextController?.dispose();

    otpInputFocusNode1?.dispose();
    otpInputTextController1?.dispose();

    otpInputFocusNode2?.dispose();
    otpInputTextController2?.dispose();
  }
}
