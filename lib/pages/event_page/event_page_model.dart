import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'dart:async';
import 'event_page_widget.dart' show EventPageWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class EventPageModel extends FlutterFlowModel<EventPageWidget> {
  ///  Local state fields for this page.

  bool? sposnsorOn = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in event_page widget.
  List<KickinAdsRow>? sponsorsAds;
  // Stores action output result for [Backend Call - API (team Invitation )] action in event_page widget.
  ApiCallResponse? teamInvites;
  bool requestCompleted2 = false;
  String? requestLastUniqueKey2;
  bool requestCompleted1 = false;
  String? requestLastUniqueKey1;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 0;

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<KtmTeamInvitationsRow>? acceptedInvite;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in Button widget.
  DocumentReference? user;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in Button widget.
  DocumentReference? tournamentOrg;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();

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

  final _sponsorAdsManager = FutureRequestManager<List<KickinAdsRow>>();
  Future<List<KickinAdsRow>> sponsorAds({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<KickinAdsRow>> Function() requestFn,
  }) =>
      _sponsorAdsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearSponsorAdsCache() => _sponsorAdsManager.clear();
  void clearSponsorAdsCacheKey(String? uniqueKey) =>
      _sponsorAdsManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    /// Dispose query cache managers for this widget.

    clearCcr1Cache();

    clearSponsorAdsCache();
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
