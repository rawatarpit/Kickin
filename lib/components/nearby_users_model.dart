import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'nearby_users_widget.dart' show NearbyUsersWidget;
import 'package:flutter/material.dart';

class NearbyUsersModel extends FlutterFlowModel<NearbyUsersWidget> {
  ///  State fields for stateful widgets in this component.

  Completer<List<ConnectionsRow>>? requestCompleter;
  // Stores action output result for [Backend Call - Insert Row] action in connect widget.
  ConnectionsRow? request;
  // Stores action output result for [Firestore Query - Query a collection] action in connect widget.
  UsersRecord? user;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Connected widget.
  List<ConnectionsRow>? deleted;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

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
}
