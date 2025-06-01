import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'event_add_widget.dart' show EventAddWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventAddModel extends FlutterFlowModel<EventAddWidget> {
  ///  Local state fields for this component.

  String? mediaUrl;

  ///  State fields for stateful widgets in this component.

  bool isDataUploading_imageUrl = false;
  FFUploadedFile uploadedLocalFile_imageUrl =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_imageUrl = '';

  bool isDataUploading_imageUr = false;
  FFUploadedFile uploadedLocalFile_imageUr =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_imageUr = '';

  // State field(s) for otp_input widget.
  FocusNode? otpInputFocusNode1;
  TextEditingController? otpInputTextController1;
  String? Function(BuildContext, String?)? otpInputTextController1Validator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for otp_input widget.
  FocusNode? otpInputFocusNode2;
  TextEditingController? otpInputTextController2;
  String? Function(BuildContext, String?)? otpInputTextController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    otpInputFocusNode1?.dispose();
    otpInputTextController1?.dispose();

    otpInputFocusNode2?.dispose();
    otpInputTextController2?.dispose();
  }
}
