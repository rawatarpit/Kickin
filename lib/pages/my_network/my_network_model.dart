import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import 'my_network_widget.dart' show MyNetworkWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyNetworkModel extends FlutterFlowModel<MyNetworkWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for registered_player widget.

  PagingController<DocumentSnapshot?, UsersRecord>?
      registeredPlayerPagingController;
  Query? registeredPlayerPagingQuery;
  List<StreamSubscription?> registeredPlayerStreamSubscriptions = [];

  // Stores action output result for [Backend Call - Insert Row] action in connect widget.
  ConnectionsRow? sent;
  // Stores action output result for [Backend Call - Insert Row] action in connect widget.
  NotificationsRow? notification;

  /// Query cache managers for this widget.

  final _playersManager = FutureRequestManager<List<UsersRecord>>();
  Future<List<UsersRecord>> players({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UsersRecord>> Function() requestFn,
  }) =>
      _playersManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPlayersCache() => _playersManager.clear();
  void clearPlayersCacheKey(String? uniqueKey) =>
      _playersManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    registeredPlayerStreamSubscriptions.forEach((s) => s?.cancel());
    registeredPlayerPagingController?.dispose();

    /// Dispose query cache managers for this widget.

    clearPlayersCache();
  }

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, UsersRecord>
      setRegisteredPlayerController(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    registeredPlayerPagingController ??=
        _createRegisteredPlayerController(query, parent);
    if (registeredPlayerPagingQuery != query) {
      registeredPlayerPagingQuery = query;
      registeredPlayerPagingController?.refresh();
    }
    return registeredPlayerPagingController!;
  }

  PagingController<DocumentSnapshot?, UsersRecord>
      _createRegisteredPlayerController(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, UsersRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryUsersRecordPage(
          queryBuilder: (_) => registeredPlayerPagingQuery ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: registeredPlayerStreamSubscriptions,
          controller: controller,
          pageSize: 25,
          isStream: true,
        ),
      );
  }
}
