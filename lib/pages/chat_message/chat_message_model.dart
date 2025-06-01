import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'chat_message_widget.dart' show ChatMessageWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatMessageModel extends FlutterFlowModel<ChatMessageWidget> {
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

  // State field(s) for messages widget.

  PagingController<DocumentSnapshot?, MessagesRecord>? messagesPagingController;
  Query? messagesPagingQuery;
  List<StreamSubscription?> messagesStreamSubscriptions = [];

  // State field(s) for input_message widget.
  FocusNode? inputMessageFocusNode;
  TextEditingController? inputMessageTextController;
  String? Function(BuildContext, String?)? inputMessageTextControllerValidator;
  bool isDataUploading_photo = false;
  List<FFUploadedFile> uploadedLocalFiles_photo = [];

  bool isDataUploading_uploadDataHax = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataHax = [];
  List<String> uploadedFileUrls_uploadDataHax = [];

  // Stores action output result for [Backend Call - API (Conversation)] action in IconButton widget.
  ApiCallResponse? chats;
  // Stores action output result for [Backend Call - API (Conversation)] action in IconButton widget.
  ApiCallResponse? chat;

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
  void initState(BuildContext context) {}

  @override
  void dispose() {
    messagesStreamSubscriptions.forEach((s) => s?.cancel());
    messagesPagingController?.dispose();

    inputMessageFocusNode?.dispose();
    inputMessageTextController?.dispose();

    /// Dispose query cache managers for this widget.

    clearOtherTextCache();
  }

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, MessagesRecord> setMessagesController(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    messagesPagingController ??= _createMessagesController(query, parent);
    if (messagesPagingQuery != query) {
      messagesPagingQuery = query;
      messagesPagingController?.refresh();
    }
    return messagesPagingController!;
  }

  PagingController<DocumentSnapshot?, MessagesRecord> _createMessagesController(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, MessagesRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryMessagesRecordPage(
          queryBuilder: (_) => messagesPagingQuery ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: messagesStreamSubscriptions,
          controller: controller,
          pageSize: 25,
          isStream: true,
        ),
      );
  }
}
