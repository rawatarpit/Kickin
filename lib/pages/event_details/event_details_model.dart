import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'dart:async';
import 'event_details_widget.dart' show EventDetailsWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class EventDetailsModel extends FlutterFlowModel<EventDetailsWidget> {
  ///  Local state fields for this page.

  List<String> groupsName = [];
  void addToGroupsName(String item) => groupsName.add(item);
  void removeFromGroupsName(String item) => groupsName.remove(item);
  void removeAtIndexFromGroupsName(int index) => groupsName.removeAt(index);
  void insertAtIndexInGroupsName(int index, String item) =>
      groupsName.insert(index, item);
  void updateGroupsNameAtIndex(int index, Function(String) updateFn) =>
      groupsName[index] = updateFn(groupsName[index]);

  String? teamId;

  List<String> mediaList = [];
  void addToMediaList(String item) => mediaList.add(item);
  void removeFromMediaList(String item) => mediaList.remove(item);
  void removeAtIndexFromMediaList(int index) => mediaList.removeAt(index);
  void insertAtIndexInMediaList(int index, String item) =>
      mediaList.insert(index, item);
  void updateMediaListAtIndex(int index, Function(String) updateFn) =>
      mediaList[index] = updateFn(mediaList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Event Page Media)] action in event_details widget.
  ApiCallResponse? media;
  // Stores action output result for [Backend Call - API (kickin Media ads)] action in event_details widget.
  ApiCallResponse? view;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 0;

  // Stores action output result for [Backend Call - API (kickin Media ads)] action in Image widget.
  ApiCallResponse? click;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  bool requestCompleted1 = false;
  String? requestLastUniqueKey1;
  // State field(s) for fixtures_rounds widget.
  FormFieldController<List<String>>? fixturesRoundsValueController1;
  String? get fixturesRoundsValue1 =>
      fixturesRoundsValueController1?.value?.firstOrNull;
  set fixturesRoundsValue1(String? val) =>
      fixturesRoundsValueController1?.value = val != null ? [val] : [];
  // Stores action output result for [Backend Call - Query Rows] action in Tab widget.
  List<KtmTeamMembersRow>? teamMembers;
  bool requestCompleted2 = false;
  String? requestLastUniqueKey2;
  // State field(s) for myfixtures_rounds widget.
  FormFieldController<List<String>>? myfixturesRoundsValueController;
  String? get myfixturesRoundsValue =>
      myfixturesRoundsValueController?.value?.firstOrNull;
  set myfixturesRoundsValue(String? val) =>
      myfixturesRoundsValueController?.value = val != null ? [val] : [];
  // State field(s) for fixtures_rounds widget.
  FormFieldController<List<String>>? fixturesRoundsValueController2;
  String? get fixturesRoundsValue2 =>
      fixturesRoundsValueController2?.value?.firstOrNull;
  set fixturesRoundsValue2(String? val) =>
      fixturesRoundsValueController2?.value = val != null ? [val] : [];
  bool apiRequestCompleted = false;
  String? apiRequestLastUniqueKey;
  // State field(s) for ChoiceChips_groups widget.
  FormFieldController<List<String>>? choiceChipsGroupsValueController;
  String? get choiceChipsGroupsValue =>
      choiceChipsGroupsValueController?.value?.firstOrNull;
  set choiceChipsGroupsValue(String? val) =>
      choiceChipsGroupsValueController?.value = val != null ? [val] : [];

  /// Query cache managers for this widget.

  final _roundsManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> rounds({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _roundsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearRoundsCache() => _roundsManager.clear();
  void clearRoundsCacheKey(String? uniqueKey) =>
      _roundsManager.clearRequest(uniqueKey);

  final _fixturesManager = FutureRequestManager<List<KtmMatchesRow>>();
  Future<List<KtmMatchesRow>> fixtures({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<KtmMatchesRow>> Function() requestFn,
  }) =>
      _fixturesManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearFixturesCache() => _fixturesManager.clear();
  void clearFixturesCacheKey(String? uniqueKey) =>
      _fixturesManager.clearRequest(uniqueKey);

  final _teamMemebrssManager = FutureRequestManager<List<UsersRow>>();
  Future<List<UsersRow>> teamMemebrss({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UsersRow>> Function() requestFn,
  }) =>
      _teamMemebrssManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTeamMemebrssCache() => _teamMemebrssManager.clear();
  void clearTeamMemebrssCacheKey(String? uniqueKey) =>
      _teamMemebrssManager.clearRequest(uniqueKey);

  final _grpManager = FutureRequestManager<List<KtmGroupsRow>>();
  Future<List<KtmGroupsRow>> grp({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<KtmGroupsRow>> Function() requestFn,
  }) =>
      _grpManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGrpCache() => _grpManager.clear();
  void clearGrpCacheKey(String? uniqueKey) =>
      _grpManager.clearRequest(uniqueKey);

  final _contManager = FutureRequestManager<List<TournamentMediaRow>>();
  Future<List<TournamentMediaRow>> cont({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<TournamentMediaRow>> Function() requestFn,
  }) =>
      _contManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearContCache() => _contManager.clear();
  void clearContCacheKey(String? uniqueKey) =>
      _contManager.clearRequest(uniqueKey);

  final _groupManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> group({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _groupManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGroupCache() => _groupManager.clear();
  void clearGroupCacheKey(String? uniqueKey) =>
      _groupManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();

    /// Dispose query cache managers for this widget.

    clearRoundsCache();

    clearFixturesCache();

    clearTeamMemebrssCache();

    clearGrpCache();

    clearContCache();

    clearGroupCache();
  }

  /// Additional helper methods.
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

  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleted;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
