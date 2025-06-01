import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/components/media_widget.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'dart:async';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  List<String> userList = [];
  void addToUserList(String item) => userList.add(item);
  void removeFromUserList(String item) => userList.remove(item);
  void removeAtIndexFromUserList(int index) => userList.removeAt(index);
  void insertAtIndexInUserList(int index, String item) =>
      userList.insert(index, item);
  void updateUserListAtIndex(int index, Function(String) updateFn) =>
      userList[index] = updateFn(userList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in home widget.
  List<UsersRecord>? userLists;
  // Model for media component.
  late MediaModel mediaModel1;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in media widget.
  DocumentReference? userPost;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in Icon widget.
  DocumentReference? userPo;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in comment widget.
  DocumentReference? use;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Sent widget.
  List<ConnectionsRow>? deleet;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in Sent widget.
  DocumentReference? docs;
  Completer<ApiCallResponse>? apiRequestCompleter;
  // Stores action output result for [Backend Call - Insert Row] action in connect widget.
  ConnectionsRow? sent;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in connect widget.
  DocumentReference? doc;
  // Stores action output result for [Backend Call - Insert Row] action in connect widget.
  NotificationsRow? notification;
  // State field(s) for posts widget.

  PagingController<DocumentSnapshot?, PostsRecord>? postsPagingController;
  Query? postsPagingQuery;
  List<StreamSubscription?> postsStreamSubscriptions = [];

  // Models for media dynamic component.
  late FlutterFlowDynamicModels<MediaModel> mediaModels2;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in media widget.
  DocumentReference? userPosts;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in Icon widget.
  DocumentReference? userPos;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in comment widget.
  DocumentReference? uses;
  // Model for navbar component.
  late NavbarModel navbarModel;

  /// Query cache managers for this widget.

  final _infoManager = StreamRequestManager<List<UsersRecord>>();
  Stream<List<UsersRecord>> info({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<UsersRecord>> Function() requestFn,
  }) =>
      _infoManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearInfoCache() => _infoManager.clear();
  void clearInfoCacheKey(String? uniqueKey) =>
      _infoManager.clearRequest(uniqueKey);

  final _postManager = StreamRequestManager<List<PostsRecord>>();
  Stream<List<PostsRecord>> post({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<PostsRecord>> Function() requestFn,
  }) =>
      _postManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPostCache() => _postManager.clear();
  void clearPostCacheKey(String? uniqueKey) =>
      _postManager.clearRequest(uniqueKey);

  final _commentsManager = StreamRequestManager<List<CommentsRecord>>();
  Stream<List<CommentsRecord>> comments({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<CommentsRecord>> Function() requestFn,
  }) =>
      _commentsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCommentsCache() => _commentsManager.clear();
  void clearCommentsCacheKey(String? uniqueKey) =>
      _commentsManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    mediaModel1 = createModel(context, () => MediaModel());
    mediaModels2 = FlutterFlowDynamicModels(() => MediaModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    mediaModel1.dispose();
    postsStreamSubscriptions.forEach((s) => s?.cancel());
    postsPagingController?.dispose();

    mediaModels2.dispose();
    navbarModel.dispose();

    /// Dispose query cache managers for this widget.

    clearInfoCache();

    clearPostCache();

    clearCommentsCache();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  PagingController<DocumentSnapshot?, PostsRecord> setPostsController(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    postsPagingController ??= _createPostsController(query, parent);
    if (postsPagingQuery != query) {
      postsPagingQuery = query;
      postsPagingController?.refresh();
    }
    return postsPagingController!;
  }

  PagingController<DocumentSnapshot?, PostsRecord> _createPostsController(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, PostsRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryPostsRecordPage(
          queryBuilder: (_) => postsPagingQuery ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: postsStreamSubscriptions,
          controller: controller,
          pageSize: 15,
          isStream: true,
        ),
      );
  }
}
