import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import 'dart:async';
import 'invite_players_widget.dart' show InvitePlayersWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InvitePlayersModel extends FlutterFlowModel<InvitePlayersWidget> {
  ///  Local state fields for this component.

  bool searchOn = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in Invite_players widget.
  List<UsersRecord>? user;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<UsersRecord> simpleSearchResults = [];
  // State field(s) for defaultList widget.

  PagingController<DocumentSnapshot?, UsersRecord>? defaultListPagingController;
  Query? defaultListPagingQuery;
  List<StreamSubscription?> defaultListStreamSubscriptions = [];

  Completer<List<KtmTeamInvitationsRow>>? requestCompleter1;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  KtmTeamInvitationsRow? invited;
  Completer<List<KtmTeamInvitationsRow>>? requestCompleter2;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  KtmTeamInvitationsRow? invitedPlayers;

  /// Query cache managers for this widget.

  final _teamsManager = FutureRequestManager<List<KtmTeamsRow>>();
  Future<List<KtmTeamsRow>> teams({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<KtmTeamsRow>> Function() requestFn,
  }) =>
      _teamsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTeamsCache() => _teamsManager.clear();
  void clearTeamsCacheKey(String? uniqueKey) =>
      _teamsManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    defaultListStreamSubscriptions.forEach((s) => s?.cancel());
    defaultListPagingController?.dispose();

    /// Dispose query cache managers for this widget.

    clearTeamsCache();
  }

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, UsersRecord> setDefaultListController(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    defaultListPagingController ??= _createDefaultListController(query, parent);
    if (defaultListPagingQuery != query) {
      defaultListPagingQuery = query;
      defaultListPagingController?.refresh();
    }
    return defaultListPagingController!;
  }

  PagingController<DocumentSnapshot?, UsersRecord> _createDefaultListController(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, UsersRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryUsersRecordPage(
          queryBuilder: (_) => defaultListPagingQuery ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: defaultListStreamSubscriptions,
          controller: controller,
          pageSize: 15,
          isStream: true,
        ),
      );
  }

  Future waitForRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter1?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
