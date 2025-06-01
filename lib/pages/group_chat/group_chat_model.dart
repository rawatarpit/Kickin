import '/backend/backend.dart';
import '/components/message_image_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'group_chat_widget.dart' show GroupChatWidget;
import 'package:flutter/material.dart';

class GroupChatModel extends FlutterFlowModel<GroupChatWidget> {
  ///  Local state fields for this page.

  bool typing = false;

  bool seen = false;

  List<FFUploadedFile> mediaList = [];
  void addToMediaList(FFUploadedFile item) => mediaList.add(item);
  void removeFromMediaList(FFUploadedFile item) => mediaList.remove(item);
  void removeAtIndexFromMediaList(int index) => mediaList.removeAt(index);
  void insertAtIndexInMediaList(int index, FFUploadedFile item) =>
      mediaList.insert(index, item);
  void updateMediaListAtIndex(int index, Function(FFUploadedFile) updateFn) =>
      mediaList[index] = updateFn(mediaList[index]);

  List<DocumentReference> particpantId = [];
  void addToParticpantId(DocumentReference item) => particpantId.add(item);
  void removeFromParticpantId(DocumentReference item) =>
      particpantId.remove(item);
  void removeAtIndexFromParticpantId(int index) => particpantId.removeAt(index);
  void insertAtIndexInParticpantId(int index, DocumentReference item) =>
      particpantId.insert(index, item);
  void updateParticpantIdAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      particpantId[index] = updateFn(particpantId[index]);

  ///  State fields for stateful widgets in this page.

  // Models for message_image dynamic component.
  late FlutterFlowDynamicModels<MessageImageModel> messageImageModels1;
  // Models for message_image dynamic component.
  late FlutterFlowDynamicModels<MessageImageModel> messageImageModels2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  bool isDataUploading_uploadData5dc = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadData5dc = [];

  bool isDataUploading_uploadDataM65 = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataM65 = [];
  List<String> uploadedFileUrls_uploadDataM65 = [];

  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  MessagesRecord? text;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in IconButton widget.
  DocumentReference? userDoc;

  /// Query cache managers for this widget.

  final _otherTextManager = StreamRequestManager<List<UsersRecord>>();
  Stream<List<UsersRecord>> otherText({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<UsersRecord>> Function() requestFn,
  }) =>
      _otherTextManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearOtherTextCache() => _otherTextManager.clear();
  void clearOtherTextCacheKey(String? uniqueKey) =>
      _otherTextManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    messageImageModels1 = FlutterFlowDynamicModels(() => MessageImageModel());
    messageImageModels2 = FlutterFlowDynamicModels(() => MessageImageModel());
  }

  @override
  void dispose() {
    messageImageModels1.dispose();
    messageImageModels2.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    /// Dispose query cache managers for this widget.

    clearOtherTextCache();
  }
}
