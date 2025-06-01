import '/backend/backend.dart';
import '/components/media_widget.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'indiviual_post_widget.dart' show IndiviualPostWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class IndiviualPostModel extends FlutterFlowModel<IndiviualPostWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for media component.
  late MediaModel mediaModel;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in unfiled widget.
  DocumentReference? notify;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  CommentsRecord? commented;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in IconButton widget.
  DocumentReference? notifyUser;
  // State field(s) for comments widget.

  PagingController<DocumentSnapshot?, CommentsRecord>? commentsPagingController;
  Query? commentsPagingQuery;
  List<StreamSubscription?> commentsStreamSubscriptions = [];

  // Model for navbar component.
  late NavbarModel navbarModel;

  /// Query cache managers for this widget.

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

  @override
  void initState(BuildContext context) {
    mediaModel = createModel(context, () => MediaModel());
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    mediaModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    commentsStreamSubscriptions.forEach((s) => s?.cancel());
    commentsPagingController?.dispose();

    navbarModel.dispose();

    /// Dispose query cache managers for this widget.

    clearPostCache();
  }

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, CommentsRecord> setCommentsController(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    commentsPagingController ??= _createCommentsController(query, parent);
    if (commentsPagingQuery != query) {
      commentsPagingQuery = query;
      commentsPagingController?.refresh();
    }
    return commentsPagingController!;
  }

  PagingController<DocumentSnapshot?, CommentsRecord> _createCommentsController(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, CommentsRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryCommentsRecordPage(
          parent: parent,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: commentsStreamSubscriptions,
          controller: controller,
          pageSize: 15,
          isStream: true,
        ),
      );
  }
}
