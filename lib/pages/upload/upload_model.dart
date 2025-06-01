import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'upload_widget.dart' show UploadWidget;
import 'package:flutter/material.dart';

class UploadModel extends FlutterFlowModel<UploadWidget> {
  ///  Local state fields for this page.

  List<String> mediaUrl = [];
  void addToMediaUrl(String item) => mediaUrl.add(item);
  void removeFromMediaUrl(String item) => mediaUrl.remove(item);
  void removeAtIndexFromMediaUrl(int index) => mediaUrl.removeAt(index);
  void insertAtIndexInMediaUrl(int index, String item) =>
      mediaUrl.insert(index, item);
  void updateMediaUrlAtIndex(int index, Function(String) updateFn) =>
      mediaUrl[index] = updateFn(mediaUrl[index]);

  String publicType = 'Everyone';

  bool upload = false;

  bool? isEvent = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - selectUploadFiles] action in Stack widget.
  List<String>? imagesCopy;
  // Stores action output result for [Bottom Sheet - Post_type] action in publicType widget.
  String? type;
  // Stores action output result for [Backend Call - Create Document] action in Text widget.
  PostsRecord? notShot;
  // Stores action output result for [Backend Call - Create Document] action in Text widget.
  PostsRecord? shot;
  // Stores action output result for [Backend Call - Create Document] action in Text widget.
  PostsRecord? event;
  // Stores action output result for [Backend Call - Create Document] action in Text widget.
  PostsRecord? write;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (Delete File)] action in Icon widget.
  ApiCallResponse? apiResultkwv;
  // Stores action output result for [Custom Action - selectUploadFiles] action in image_upload widget.
  List<String>? images;
  // Stores action output result for [Custom Action - selectUploadFiles] action in video_upload widget.
  List<String>? video;
  // Stores action output result for [Bottom Sheet - event_add] action in event_upload widget.
  EventDetailsStruct? events;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
