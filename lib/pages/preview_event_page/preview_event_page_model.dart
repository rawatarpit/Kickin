import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import 'preview_event_page_widget.dart' show PreviewEventPageWidget;
import 'package:flutter/material.dart';

class PreviewEventPageModel extends FlutterFlowModel<PreviewEventPageWidget> {
  ///  Local state fields for this page.

  bool? sposnsorOn = false;

  bool? pricing = true;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Switch widget.
  bool? switchValue;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // Stores action output result for [Custom Action - generateTournamentCode] action in Button widget.
  String? coded;

  /// Query cache managers for this widget.

  final _ccr1Manager = FutureRequestManager<List<TournamentsRow>>();
  Future<List<TournamentsRow>> ccr1({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<TournamentsRow>> Function() requestFn,
  }) =>
      _ccr1Manager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCcr1Cache() => _ccr1Manager.clear();
  void clearCcr1CacheKey(String? uniqueKey) =>
      _ccr1Manager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    /// Dispose query cache managers for this widget.

    clearCcr1Cache();
  }
}
