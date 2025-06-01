import '/backend/backend.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'kickin_shot_widget.dart' show KickinShotWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class KickinShotModel extends FlutterFlowModel<KickinShotWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for default_PageView widget.
  PageController? defaultPageViewController;
  int defaultPageViewLoadedLength = 15;
  int get defaultPageViewCurrentIndex => defaultPageViewController != null &&
          defaultPageViewController!.hasClients &&
          defaultPageViewController!.page != null
      ? defaultPageViewController!.page!.round()
      : 0;
  PagingController<DocumentSnapshot?, PostsRecord>?
      defaultPageViewPagingController;
  Query? defaultPageViewPagingQuery;
  List<StreamSubscription?> defaultPageViewStreamSubscriptions = [];

  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in Icon widget.
  DocumentReference? shotUser;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in comment widget.
  DocumentReference? shotUsers;
  // Model for navbar component.
  late NavbarModel navbarModel;

  /// Query cache managers for this widget.

  final _kickinShotsManager = StreamRequestManager<List<PostsRecord>>();
  Stream<List<PostsRecord>> kickinShots({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<PostsRecord>> Function() requestFn,
  }) =>
      _kickinShotsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearKickinShotsCache() => _kickinShotsManager.clear();
  void clearKickinShotsCacheKey(String? uniqueKey) =>
      _kickinShotsManager.clearRequest(uniqueKey);

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

  @override
  void initState(BuildContext context) {
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    defaultPageViewStreamSubscriptions.forEach((s) => s?.cancel());
    defaultPageViewPagingController?.dispose();

    navbarModel.dispose();

    /// Dispose query cache managers for this widget.

    clearKickinShotsCache();

    clearInfoCache();
  }

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, PostsRecord> setDefaultPageViewController(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    defaultPageViewPagingController ??=
        _createDefaultPageViewController(query, parent);
    if (defaultPageViewPagingQuery != query) {
      defaultPageViewPagingQuery = query;
      defaultPageViewPagingController?.refresh();
    }
    return defaultPageViewPagingController!;
  }

  PagingController<DocumentSnapshot?, PostsRecord>
      _createDefaultPageViewController(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, PostsRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryPostsRecordPage(
          queryBuilder: (_) => defaultPageViewPagingQuery ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: defaultPageViewStreamSubscriptions,
          controller: controller,
          pageSize: 15,
          isStream: true,
        ),
      );
  }
}
