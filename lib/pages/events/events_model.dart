import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'dart:async';
import 'events_widget.dart' show EventsWidget;
import 'package:flutter/material.dart';

class EventsModel extends FlutterFlowModel<EventsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Query Rows] action in TextField widget.
  List<TournamentsRow>? tournamentsSearched;
  // State field(s) for event widget.
  TabController? eventController;
  int get eventCurrentIndex =>
      eventController != null ? eventController!.index : 0;
  int get eventPreviousIndex =>
      eventController != null ? eventController!.previousIndex : 0;

  // Stores action output result for [Backend Call - Query Rows] action in Participation widget.
  List<KtmTeamsRow>? usersteam;
  // Stores action output result for [Backend Call - Query Rows] action in Created widget.
  List<TournamentsRow>? createdTournaments;
  // Stores action output result for [Backend Call - API (Nearby Tournaments)] action in Nearby_tournaments widget.
  ApiCallResponse? eventss;
  bool requestCompleted2 = false;
  String? requestLastUniqueKey2;
  bool requestCompleted1 = false;
  String? requestLastUniqueKey1;
  // Model for navbar component.
  late NavbarModel navbarModel;

  /// Query cache managers for this widget.

  final _eventsManager = FutureRequestManager<List<TournamentsRow>>();
  Future<List<TournamentsRow>> events({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<TournamentsRow>> Function() requestFn,
  }) =>
      _eventsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearEventsCache() => _eventsManager.clear();
  void clearEventsCacheKey(String? uniqueKey) =>
      _eventsManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {
    navbarModel = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    eventController?.dispose();
    navbarModel.dispose();

    /// Dispose query cache managers for this widget.

    clearEventsCache();
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
}
