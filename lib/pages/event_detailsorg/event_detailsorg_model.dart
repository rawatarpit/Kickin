import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'dart:async';
import 'event_detailsorg_widget.dart' show EventDetailsorgWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class EventDetailsorgModel extends FlutterFlowModel<EventDetailsorgWidget> {
  ///  Local state fields for this page.

  List<String> groupsName = [];
  void addToGroupsName(String item) => groupsName.add(item);
  void removeFromGroupsName(String item) => groupsName.remove(item);
  void removeAtIndexFromGroupsName(int index) => groupsName.removeAt(index);
  void insertAtIndexInGroupsName(int index, String item) =>
      groupsName.insert(index, item);
  void updateGroupsNameAtIndex(int index, Function(String) updateFn) =>
      groupsName[index] = updateFn(groupsName[index]);

  List<DocumentReference> notifyUsers = [];
  void addToNotifyUsers(DocumentReference item) => notifyUsers.add(item);
  void removeFromNotifyUsers(DocumentReference item) =>
      notifyUsers.remove(item);
  void removeAtIndexFromNotifyUsers(int index) => notifyUsers.removeAt(index);
  void insertAtIndexInNotifyUsers(int index, DocumentReference item) =>
      notifyUsers.insert(index, item);
  void updateNotifyUsersAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      notifyUsers[index] = updateFn(notifyUsers[index]);

  bool fixturesbutton = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in event_Detailsorg widget.
  List<KtmTeamMembersRow>? ktmTeamMembers;
  // Stores action output result for [Custom Action - getDocumentRefFromCollection] action in event_Detailsorg widget.
  DocumentReference? userDocref;
  // Stores action output result for [Backend Call - API (Event Page Media)] action in event_Detailsorg widget.
  ApiCallResponse? medias;
  // Stores action output result for [Backend Call - API (kickin Media ads)] action in event_Detailsorg widget.
  ApiCallResponse? view;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 0;

  // Stores action output result for [Backend Call - API (kickin Media ads)] action in Image widget.
  ApiCallResponse? click;
  // Stores action output result for [Backend Call - API (KTM Generate Knockout  Inital Fixtures)] action in knockout_button widget.
  ApiCallResponse? apiResulthgz;
  bool requestCompleted4 = false;
  String? requestLastUniqueKey4;
  // Stores action output result for [Bottom Sheet - geenrateFixtures] action in knockout_button widget.
  bool? unlock;
  // Stores action output result for [Backend Call - API (KTM Assign Teams To Groups)] action in Assign_group widget.
  ApiCallResponse? assignGroup;
  bool requestCompleted5 = false;
  String? requestLastUniqueKey5;
  // Stores action output result for [Bottom Sheet - geenrateFixtures] action in Assign_group widget.
  bool? unlocks;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  bool apiRequestCompleted1 = false;
  String? apiRequestLastUniqueKey1;
  // State field(s) for fixtures_round widget.
  FormFieldController<List<String>>? fixturesRoundValueController;
  String? get fixturesRoundValue =>
      fixturesRoundValueController?.value?.firstOrNull;
  set fixturesRoundValue(String? val) =>
      fixturesRoundValueController?.value = val != null ? [val] : [];
  bool requestCompleted2 = false;
  String? requestLastUniqueKey2;
  bool requestCompleted3 = false;
  String? requestLastUniqueKey3;
  // State field(s) for fixtures_rounds widget.
  FormFieldController<List<String>>? fixturesRoundsValueController;
  String? get fixturesRoundsValue =>
      fixturesRoundsValueController?.value?.firstOrNull;
  set fixturesRoundsValue(String? val) =>
      fixturesRoundsValueController?.value = val != null ? [val] : [];
  bool isDataUploading_uploadDataJq1 = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataJq1 = [];
  List<String> uploadedFileUrls_uploadDataJq1 = [];

  bool requestCompleted1 = false;
  String? requestLastUniqueKey1;
  bool apiRequestCompleted2 = false;
  String? apiRequestLastUniqueKey2;
  // Stores action output result for [Backend Call - API (KTM Generate Group Fixtures)] action in group_fixtures_button widget.
  ApiCallResponse? fixturesList;
  // Stores action output result for [Backend Call - API (KTM Generate Group Knockout Fixtures)] action in Advance_knockout_button widget.
  ApiCallResponse? groupKnockout;
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

  final _eventDetailsManager = FutureRequestManager<List<TournamentsRow>>();
  Future<List<TournamentsRow>> eventDetails({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<TournamentsRow>> Function() requestFn,
  }) =>
      _eventDetailsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearEventDetailsCache() => _eventDetailsManager.clear();
  void clearEventDetailsCacheKey(String? uniqueKey) =>
      _eventDetailsManager.clearRequest(uniqueKey);

  final _resultsManager = FutureRequestManager<List<KtmMatchesRow>>();
  Future<List<KtmMatchesRow>> results({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<KtmMatchesRow>> Function() requestFn,
  }) =>
      _resultsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearResultsCache() => _resultsManager.clear();
  void clearResultsCacheKey(String? uniqueKey) =>
      _resultsManager.clearRequest(uniqueKey);

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

  final _groupsManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> groups({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _groupsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGroupsCache() => _groupsManager.clear();
  void clearGroupsCacheKey(String? uniqueKey) =>
      _groupsManager.clearRequest(uniqueKey);

  final _imagesEventManager = FutureRequestManager<List<TournamentMediaRow>>();
  Future<List<TournamentMediaRow>> imagesEvent({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<TournamentMediaRow>> Function() requestFn,
  }) =>
      _imagesEventManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearImagesEventCache() => _imagesEventManager.clear();
  void clearImagesEventCacheKey(String? uniqueKey) =>
      _imagesEventManager.clearRequest(uniqueKey);

  final _teamsssManager = FutureRequestManager<List<KtmTeamsRow>>();
  Future<List<KtmTeamsRow>> teamsss({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<KtmTeamsRow>> Function() requestFn,
  }) =>
      _teamsssManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearTeamsssCache() => _teamsssManager.clear();
  void clearTeamsssCacheKey(String? uniqueKey) =>
      _teamsssManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();

    /// Dispose query cache managers for this widget.

    clearRoundsCache();

    clearFixturesCache();

    clearEventDetailsCache();

    clearResultsCache();

    clearGrpCache();

    clearGroupsCache();

    clearImagesEventCache();

    clearTeamsssCache();
  }

  /// Additional helper methods.
  Future waitForRequestCompleted4({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleted4;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForRequestCompleted5({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleted5;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleted1;
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

  Future waitForRequestCompleted3({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleted3;
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

  Future waitForApiRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleted2;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
