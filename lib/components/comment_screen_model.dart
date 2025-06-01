import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import 'comment_screen_widget.dart' show CommentScreenWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CommentScreenModel extends FlutterFlowModel<CommentScreenWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for comments widget.

  PagingController<DocumentSnapshot?, CommentsRecord>? commentsPagingController;
  Query? commentsPagingQuery;
  List<StreamSubscription?> commentsStreamSubscriptions = [];

  // State field(s) for comment widget.
  FocusNode? commentFocusNode;
  TextEditingController? commentTextController;
  String? Function(BuildContext, String?)? commentTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  CommentsRecord? commented;

  /// Query cache managers for this widget.

  final _commenstManager = StreamRequestManager<List<CommentsRecord>>();
  Stream<List<CommentsRecord>> commenst({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<CommentsRecord>> Function() requestFn,
  }) =>
      _commenstManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCommenstCache() => _commenstManager.clear();
  void clearCommenstCacheKey(String? uniqueKey) =>
      _commenstManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    commentsStreamSubscriptions.forEach((s) => s?.cancel());
    commentsPagingController?.dispose();

    commentFocusNode?.dispose();
    commentTextController?.dispose();

    /// Dispose query cache managers for this widget.

    clearCommenstCache();
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
          queryBuilder: (_) => commentsPagingQuery ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: commentsStreamSubscriptions,
          controller: controller,
          pageSize: 15,
          isStream: true,
        ),
      );
  }
}
