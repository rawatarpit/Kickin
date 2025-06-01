import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/components/media_widget.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'dart:async';
import 'otherprofile_widget.dart' show OtherprofileWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class OtherprofileModel extends FlutterFlowModel<OtherprofileWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (delete connections)] action in sent widget.
  ApiCallResponse? apiResultmc6Copy;
  // Stores action output result for [Backend Call - Insert Row] action in connect widget.
  ConnectionsRow? request;
  // Stores action output result for [Backend Call - API (delete connections)] action in connected widget.
  ApiCallResponse? apiResultmc6;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  Stream<List<UserExperienceRow>>? listViewSupabaseStream;
  Completer<List<AchievementsRow>>? requestCompleter;
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

  /// Query cache managers for this widget.

  final _lcationManager = StreamRequestManager<List<UserExperienceRow>>();
  Stream<List<UserExperienceRow>> lcation({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<UserExperienceRow>> Function() requestFn,
  }) =>
      _lcationManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearLcationCache() => _lcationManager.clear();
  void clearLcationCacheKey(String? uniqueKey) =>
      _lcationManager.clearRequest(uniqueKey);

  final _postssManager = StreamRequestManager<List<UsersRecord>>();
  Stream<List<UsersRecord>> postss({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<UsersRecord>> Function() requestFn,
  }) =>
      _postssManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPostssCache() => _postssManager.clear();
  void clearPostssCacheKey(String? uniqueKey) =>
      _postssManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    mediaModels = FlutterFlowDynamicModels(() => MediaModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    postsStreamSubscriptions.forEach((s) => s?.cancel());
    postsPagingController?.dispose();

    mediaModels.dispose();
    navbarModel.dispose();

    /// Dispose query cache managers for this widget.

    clearLcationCache();

    clearPostssCache();
  }

  /// Additional helper methods.
  Future waitForRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter?.isCompleted ?? false;
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
