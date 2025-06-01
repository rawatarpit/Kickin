import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/loading_widget.dart';
import '/components/media_widget.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'dart:async';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  Local state fields for this page.

  bool? loadon = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (resume)] action in resume widget.
  ApiCallResponse? apiResult;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  bool requestCompleted2 = false;
  String? requestLastUniqueKey2;
  bool requestCompleted1 = false;
  String? requestLastUniqueKey1;
  // State field(s) for posts widget.

  PagingController<DocumentSnapshot?, PostsRecord>? postsPagingController;
  Query? postsPagingQuery;
  List<StreamSubscription?> postsStreamSubscriptions = [];

  // Models for media dynamic component.
  late FlutterFlowDynamicModels<MediaModel> mediaModels;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in media widget.
  DocumentReference? userPost;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in Icon widget.
  DocumentReference? userPo;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in comment widget.
  DocumentReference? use;
  // Model for navbar component.
  late NavbarModel navbarModel;
  // Model for loading component.
  late LoadingModel loadingModel;

  /// Query cache managers for this widget.

  final _postsssnManager = StreamRequestManager<List<UsersRecord>>();
  Stream<List<UsersRecord>> postsssn({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<UsersRecord>> Function() requestFn,
  }) =>
      _postsssnManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPostsssnCache() => _postsssnManager.clear();
  void clearPostsssnCacheKey(String? uniqueKey) =>
      _postsssnManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    mediaModels = FlutterFlowDynamicModels(() => MediaModel());
    navbarModel = createModel(context, () => NavbarModel());
    loadingModel = createModel(context, () => LoadingModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    postsStreamSubscriptions.forEach((s) => s?.cancel());
    postsPagingController?.dispose();

    mediaModels.dispose();
    navbarModel.dispose();
    loadingModel.dispose();

    /// Dispose query cache managers for this widget.

    clearPostsssnCache();
  }

  /// Additional helper methods.
  Future waitForRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleted2;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleted1;
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
