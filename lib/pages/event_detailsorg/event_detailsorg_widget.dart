import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/geenrate_fixtures_widget.dart';
import '/components/image_preview_widget.dart';
import '/components/invite_teams_widget.dart';
import '/components/scores_widget.dart';
import '/components/team_players_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'event_detailsorg_model.dart';
export 'event_detailsorg_model.dart';

class EventDetailsorgWidget extends StatefulWidget {
  const EventDetailsorgWidget({
    super.key,
    int? tabNumber,
    required this.tournamentId,
  }) : this.tabNumber = tabNumber ?? 0;

  final int tabNumber;
  final String? tournamentId;

  static String routeName = 'event_Detailsorg';
  static String routePath = 'eventDetailsorg';

  @override
  State<EventDetailsorgWidget> createState() => _EventDetailsorgWidgetState();
}

class _EventDetailsorgWidgetState extends State<EventDetailsorgWidget>
    with TickerProviderStateMixin {
  late EventDetailsorgModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventDetailsorgModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'event_Detailsorg'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('EVENT_DETAILSORG_event_Detailsorg_ON_INI');
      await Future.wait([
        Future(() async {
          logFirebaseEvent('event_Detailsorg_backend_call');
          _model.ktmTeamMembers = await KtmTeamMembersTable().queryRows(
            queryFn: (q) => q.eqOrNull(
              'tournament_id',
              widget.tournamentId,
            ),
          );
          for (int loop1Index = 0;
              loop1Index <
                  _model.ktmTeamMembers!.map((e) => e.userId).toList().length;
              loop1Index++) {
            final currentLoop1Item = _model.ktmTeamMembers!
                .map((e) => e.userId)
                .toList()[loop1Index];
            logFirebaseEvent('event_Detailsorg_custom_action');
            _model.userDocref = await actions.getDocumentRefFromCollection(
              'users',
              currentLoop1Item,
            );
            logFirebaseEvent('event_Detailsorg_update_page_state');
            _model.addToNotifyUsers(_model.userDocref!);
            safeSetState(() {});
          }
        }),
        Future(() async {
          logFirebaseEvent('event_Detailsorg_backend_call');
          _model.medias = await EventPageMediaCall.call(
            pTournamentId: widget.tournamentId,
          );

          for (int loop2Index = 0;
              loop2Index < (_model.medias?.jsonBody ?? '').length;
              loop2Index++) {
            final currentLoop2Item =
                (_model.medias?.jsonBody ?? '')[loop2Index];
            logFirebaseEvent('event_Detailsorg_backend_call');
            _model.view = await KickinMediaAdsCall.call(
              pAdId: getJsonField(
                currentLoop2Item,
                r'''$.id''',
              ).toString().toString(),
              pUserId: currentUserReference?.id,
              pMode: 'view',
            );
          }
        }),
      ]);
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 5,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TournamentsRow>>(
      future: _model
          .eventDetails(
        requestFn: () => TournamentsTable().querySingleRow(
          queryFn: (q) => q.eqOrNull(
            'tournament_id',
            widget.tournamentId,
          ),
        ),
      )
          .then((result) {
        _model.requestCompleted5 = true;
        return result;
      }),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 80.0,
                height: 80.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<TournamentsRow> eventDetailsorgTournamentsRowList = snapshot.data!;

        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final eventDetailsorgTournamentsRow =
            eventDetailsorgTournamentsRowList.isNotEmpty
                ? eventDetailsorgTournamentsRowList.first
                : null;

        return Title(
            title: 'event_Detailsorg',
            color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                body: Stack(
                  children: [
                    Builder(
                      builder: (context) {
                        final mediaAds = (_model.medias?.jsonBody ?? '')
                            .toList()
                            .take(3)
                            .toList();

                        return Container(
                          width: double.infinity,
                          height: 400.0,
                          child: CarouselSlider.builder(
                            itemCount: mediaAds.length,
                            itemBuilder: (context, mediaAdsIndex, _) {
                              final mediaAdsItem = mediaAds[mediaAdsIndex];
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'EVENT_DETAILSORG_Image_gorori91_ON_TAP');
                                  if (getJsonField(
                                        mediaAdsItem,
                                        r'''$.redirect_url''',
                                      ) !=
                                      null) {
                                    logFirebaseEvent('Image_launch_u_r_l');
                                    await launchURL(getJsonField(
                                      mediaAdsItem,
                                      r'''$.redirect_url''',
                                    ).toString());
                                    logFirebaseEvent('Image_backend_call');
                                    _model.click =
                                        await KickinMediaAdsCall.call(
                                      pAdId: getJsonField(
                                        mediaAdsItem,
                                        r'''$.id''',
                                      ).toString(),
                                      pUserId: currentUserReference?.id,
                                      pMode: 'click',
                                    );
                                  }

                                  safeSetState(() {});
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    getJsonField(
                                      mediaAdsItem,
                                      r'''$.media_url''',
                                    ).toString(),
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            carouselController: _model.carouselController ??=
                                CarouselSliderController(),
                            options: CarouselOptions(
                              initialPage: max(0, min(0, mediaAds.length - 1)),
                              viewportFraction: 1.0,
                              disableCenter: true,
                              enlargeCenterPage: true,
                              enlargeFactor: 1.0,
                              enableInfiniteScroll: true,
                              scrollDirection: Axis.horizontal,
                              autoPlay: valueOrDefault<bool>(
                                EventPageMediaCall.media(
                                          (_model.medias?.jsonBody ?? ''),
                                        )!
                                            .length >=
                                        2
                                    ? true
                                    : false,
                                false,
                              ),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayInterval:
                                  Duration(milliseconds: (800 + 4000)),
                              autoPlayCurve: Curves.linear,
                              pauseAutoPlayInFiniteScroll: true,
                              onPageChanged: (index, _) =>
                                  _model.carouselCurrentIndex = index,
                            ),
                          ),
                        );
                      },
                    ),
                    SingleChildScrollView(
                      primary: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 160.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 200.0, 0.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 800.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            color: Color(0x320E151B),
                                            offset: Offset(
                                              0.0,
                                              -2.0,
                                            ),
                                          )
                                        ],
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 0.0, 12.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        valueOrDefault<String>(
                                                          eventDetailsorgTournamentsRow
                                                              ?.name,
                                                          'Event Name',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .oswald(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            eventDetailsorgTournamentsRow
                                                                ?.tournamentFormat,
                                                            'Group + Knockout',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .poppins(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            dateTimeFormat(
                                                              "yMMMd",
                                                              eventDetailsorgTournamentsRow
                                                                  ?.startDate,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ),
                                                            '25th April 2025',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .poppins(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Stack(
                                                    children: [
                                                      if ((eventDetailsorgTournamentsRow
                                                                  ?.tournamentFormat ==
                                                              'knockout') &&
                                                          (eventDetailsorgTournamentsRow
                                                                  ?.status ==
                                                              'upcoming'))
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            logFirebaseEvent(
                                                                'EVENT_DETAILSORG_knockout_button_ON_TAP');
                                                            if (_model
                                                                    .fixturesbutton ==
                                                                true) {
                                                              logFirebaseEvent(
                                                                  'knockout_button_backend_call');
                                                              _model.apiResulthgz =
                                                                  await SupabaseKickinEventGroup
                                                                      .kTMGenerateKnockoutInitalFixturesCall
                                                                      .call(
                                                                pTournamentId:
                                                                    eventDetailsorgTournamentsRow
                                                                        ?.tournamentId,
                                                              );

                                                              if ((_model
                                                                      .apiResulthgz
                                                                      ?.succeeded ??
                                                                  true)) {
                                                                logFirebaseEvent(
                                                                    'knockout_button_trigger_push_notificatio');
                                                                triggerPushNotification(
                                                                  notificationTitle:
                                                                      eventDetailsorgTournamentsRow!
                                                                          .name,
                                                                  notificationText:
                                                                      'fixtures has been generated.',
                                                                  notificationImageUrl:
                                                                      eventDetailsorgTournamentsRow
                                                                          .mediaUrl,
                                                                  notificationSound:
                                                                      'default',
                                                                  userRefs: _model
                                                                      .notifyUsers
                                                                      .toList(),
                                                                  initialPageName:
                                                                      'event_details',
                                                                  parameterData: {
                                                                    'tabNumber':
                                                                        0,
                                                                    'tournamentid':
                                                                        eventDetailsorgTournamentsRow
                                                                            .tournamentId,
                                                                  },
                                                                );
                                                                logFirebaseEvent(
                                                                    'knockout_button_backend_call');
                                                                await TournamentsTable()
                                                                    .update(
                                                                  data: {
                                                                    'status':
                                                                        'Knockout',
                                                                  },
                                                                  matchingRows:
                                                                      (rows) =>
                                                                          rows.eqOrNull(
                                                                    'tournament_id',
                                                                    widget
                                                                        .tournamentId,
                                                                  ),
                                                                );
                                                                logFirebaseEvent(
                                                                    'knockout_button_refresh_database_request');
                                                                safeSetState(
                                                                    () {
                                                                  _model
                                                                      .clearFixturesCache();
                                                                  _model.requestCompleted4 =
                                                                      false;
                                                                });
                                                                await _model
                                                                    .waitForRequestCompleted4();
                                                                logFirebaseEvent(
                                                                    'knockout_button_tab_bar');
                                                                safeSetState(
                                                                    () {
                                                                  _model
                                                                      .tabBarController!
                                                                      .animateTo(
                                                                    0,
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            300),
                                                                    curve: Curves
                                                                        .ease,
                                                                  );
                                                                });
                                                              } else {
                                                                logFirebaseEvent(
                                                                    'knockout_button_alert_dialog');
                                                                await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (alertDialogContext) {
                                                                    return WebViewAware(
                                                                      child:
                                                                          AlertDialog(
                                                                        title: Text(
                                                                            'Invite More Teams'),
                                                                        content: Text(SupabaseKickinEventGroup
                                                                            .kTMGenerateKnockoutInitalFixturesCall
                                                                            .errorMessage(
                                                                          (_model.apiResulthgz?.jsonBody ??
                                                                              ''),
                                                                        )!),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext),
                                                                            child:
                                                                                Text('Ok'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              }
                                                            } else {
                                                              logFirebaseEvent(
                                                                  'knockout_button_bottom_sheet');
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return WebViewAware(
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            GeenrateFixturesWidget(),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(() =>
                                                                      _model.unlock =
                                                                          value));

                                                              logFirebaseEvent(
                                                                  'knockout_button_update_page_state');
                                                              _model.fixturesbutton =
                                                                  _model
                                                                      .unlock!;
                                                              safeSetState(
                                                                  () {});
                                                            }

                                                            safeSetState(() {});
                                                          },
                                                          text:
                                                              'Generate Fixtures',
                                                          options:
                                                              FFButtonOptions(
                                                            height: 48.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        24.0,
                                                                        16.0,
                                                                        24.0,
                                                                        16.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .oswald(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      if ((eventDetailsorgTournamentsRow
                                                                  ?.tournamentFormat !=
                                                              'Knockout') &&
                                                          (eventDetailsorgTournamentsRow
                                                                  ?.status ==
                                                              'upcoming'))
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  1.0, 0.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              logFirebaseEvent(
                                                                  'EVENT_DETAILSORG_Assign_group_ON_TAP');
                                                              if (_model
                                                                      .fixturesbutton ==
                                                                  true) {
                                                                logFirebaseEvent(
                                                                    'Assign_group_backend_call');
                                                                _model.assignGroup =
                                                                    await SupabaseKickinEventGroup
                                                                        .kTMAssignTeamsToGroupsCall
                                                                        .call(
                                                                  pTournamentId:
                                                                      eventDetailsorgTournamentsRow
                                                                          ?.tournamentId,
                                                                  pTeamsPerGroup:
                                                                      eventDetailsorgTournamentsRow
                                                                          ?.teamsPerGroup
                                                                          ?.toString(),
                                                                );

                                                                if ((_model
                                                                        .assignGroup
                                                                        ?.succeeded ??
                                                                    true)) {
                                                                  logFirebaseEvent(
                                                                      'Assign_group_backend_call');
                                                                  await TournamentsTable()
                                                                      .update(
                                                                    data: {
                                                                      'status':
                                                                          'Group',
                                                                    },
                                                                    matchingRows:
                                                                        (rows) =>
                                                                            rows.eqOrNull(
                                                                      'tournament_id',
                                                                      eventDetailsorgTournamentsRow
                                                                          ?.tournamentId,
                                                                    ),
                                                                  );
                                                                  logFirebaseEvent(
                                                                      'Assign_group_refresh_database_request');
                                                                  safeSetState(
                                                                      () {
                                                                    _model
                                                                        .clearEventDetailsCache();
                                                                    _model.requestCompleted5 =
                                                                        false;
                                                                  });
                                                                  await _model
                                                                      .waitForRequestCompleted5();
                                                                  logFirebaseEvent(
                                                                      'Assign_group_tab_bar');
                                                                  safeSetState(
                                                                      () {
                                                                    _model
                                                                        .tabBarController!
                                                                        .animateTo(
                                                                      2,
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              300),
                                                                      curve: Curves
                                                                          .ease,
                                                                    );
                                                                  });
                                                                } else {
                                                                  logFirebaseEvent(
                                                                      'Assign_group_alert_dialog');
                                                                  await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (alertDialogContext) {
                                                                      return WebViewAware(
                                                                        child:
                                                                            AlertDialog(
                                                                          title:
                                                                              Text('Error'),
                                                                          content: Text(SupabaseKickinEventGroup
                                                                              .kTMAssignTeamsToGroupsCall
                                                                              .errorMessage(
                                                                            (_model.assignGroup?.jsonBody ??
                                                                                ''),
                                                                          )!),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () => Navigator.pop(alertDialogContext),
                                                                              child: Text('Ok'),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                }
                                                              } else {
                                                                logFirebaseEvent(
                                                                    'Assign_group_bottom_sheet');
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return WebViewAware(
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          FocusScope.of(context)
                                                                              .unfocus();
                                                                          FocusManager
                                                                              .instance
                                                                              .primaryFocus
                                                                              ?.unfocus();
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              MediaQuery.viewInsetsOf(context),
                                                                          child:
                                                                              GeenrateFixturesWidget(),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(() =>
                                                                        _model.unlocks =
                                                                            value));

                                                                logFirebaseEvent(
                                                                    'Assign_group_update_page_state');
                                                                _model.fixturesbutton =
                                                                    _model
                                                                        .unlocks!;
                                                                safeSetState(
                                                                    () {});
                                                              }

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            text:
                                                                'Assign Groups',
                                                            options:
                                                                FFButtonOptions(
                                                              height: 48.0,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          24.0,
                                                                          16.0,
                                                                          24.0,
                                                                          16.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .tertiary,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .oswald(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 12.0, 0.0, 0.0),
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment(-1.0, 0),
                                                      child: TabBar(
                                                        isScrollable: true,
                                                        tabAlignment:
                                                            TabAlignment.start,
                                                        labelColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        unselectedLabelColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .accent4,
                                                        labelPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    24.0,
                                                                    0.0,
                                                                    24.0,
                                                                    0.0),
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .oswald(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontStyle,
                                                                ),
                                                        unselectedLabelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .oswald(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontStyle,
                                                                ),
                                                        indicatorColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    12.0,
                                                                    0.0,
                                                                    12.0,
                                                                    0.0),
                                                        tabs: [
                                                          Tab(
                                                            text: 'Fixtures',
                                                          ),
                                                          Tab(
                                                            text: 'Teams',
                                                          ),
                                                          Tab(
                                                            text: 'Score Card',
                                                          ),
                                                          Tab(
                                                            text: 'Highlights',
                                                          ),
                                                          Tab(
                                                            text:
                                                                valueOrDefault<
                                                                    String>(
                                                              eventDetailsorgTournamentsRow
                                                                          ?.tournamentFormat ==
                                                                      'Knockout'
                                                                  ? ''
                                                                  : 'Standings',
                                                              'Standings',
                                                            ),
                                                          ),
                                                        ],
                                                        controller: _model
                                                            .tabBarController,
                                                        onTap: (i) async {
                                                          [
                                                            () async {
                                                              logFirebaseEvent(
                                                                  'EVENT_DETAILSORG_Tab_d3j66v93_ON_TAP');
                                                              logFirebaseEvent(
                                                                  'Tab_refresh_database_request');
                                                              safeSetState(() {
                                                                _model
                                                                    .clearRoundsCache();
                                                                _model.apiRequestCompleted1 =
                                                                    false;
                                                              });
                                                              await _model
                                                                  .waitForApiRequestCompleted1();
                                                              logFirebaseEvent(
                                                                  'Tab_refresh_database_request');
                                                              safeSetState(() {
                                                                _model
                                                                    .clearFixturesCache();
                                                                _model.requestCompleted4 =
                                                                    false;
                                                              });
                                                              await _model
                                                                  .waitForRequestCompleted4();
                                                            },
                                                            () async {
                                                              logFirebaseEvent(
                                                                  'EVENT_DETAILSORG_Tab_1gs16ghr_ON_TAP');
                                                              logFirebaseEvent(
                                                                  'Tab_refresh_database_request');
                                                              safeSetState(() {
                                                                _model
                                                                    .clearTeamsssCache();
                                                                _model.requestCompleted2 =
                                                                    false;
                                                              });
                                                              await _model
                                                                  .waitForRequestCompleted2();
                                                            },
                                                            () async {
                                                              logFirebaseEvent(
                                                                  'EVENT_DETAILSORG_Tab_5mwdbmoa_ON_TAP');
                                                              logFirebaseEvent(
                                                                  'Tab_refresh_database_request');
                                                              safeSetState(() {
                                                                _model
                                                                    .clearResultsCache();
                                                                _model.requestCompleted3 =
                                                                    false;
                                                              });
                                                              await _model
                                                                  .waitForRequestCompleted3();
                                                            },
                                                            () async {},
                                                            () async {
                                                              logFirebaseEvent(
                                                                  'EVENT_DETAILSORG_Tab_vl8sn0vf_ON_TAP');
                                                              logFirebaseEvent(
                                                                  'Tab_refresh_database_request');
                                                              safeSetState(() {
                                                                _model
                                                                    .clearGroupsCache();
                                                                _model.apiRequestCompleted2 =
                                                                    false;
                                                              });
                                                              await _model
                                                                  .waitForApiRequestCompleted2();
                                                            }
                                                          ][i]();
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: TabBarView(
                                                        controller: _model
                                                            .tabBarController,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        children: [
                                                          KeepAliveWidgetWrapper(
                                                            builder:
                                                                (context) =>
                                                                    Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                if (eventDetailsorgTournamentsRow
                                                                        ?.status ==
                                                                    'fixture')
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12.0,
                                                                            32.0,
                                                                            12.0,
                                                                            80.0),
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      primary:
                                                                          false,
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                16.0),
                                                                            child:
                                                                                FutureBuilder<ApiCallResponse>(
                                                                              future: _model
                                                                                  .rounds(
                                                                                requestFn: () => SupabaseKickinEventGroup.getTournamentRoundsCall.call(
                                                                                  tournamentUuid: eventDetailsorgTournamentsRow?.tournamentId,
                                                                                ),
                                                                              )
                                                                                  .then((result) {
                                                                                _model.apiRequestCompleted1 = true;
                                                                                return result;
                                                                              }),
                                                                              builder: (context, snapshot) {
                                                                                // Customize what your widget looks like when it's loading.
                                                                                if (!snapshot.hasData) {
                                                                                  return Center(
                                                                                    child: SizedBox(
                                                                                      width: 80.0,
                                                                                      height: 80.0,
                                                                                      child: CircularProgressIndicator(
                                                                                        valueColor: AlwaysStoppedAnimation<Color>(
                                                                                          FlutterFlowTheme.of(context).primary,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }
                                                                                final fixturesRoundGetTournamentRoundsResponse = snapshot.data!;

                                                                                return FlutterFlowChoiceChips(
                                                                                  options: SupabaseKickinEventGroup.getTournamentRoundsCall
                                                                                      .rounds(
                                                                                        fixturesRoundGetTournamentRoundsResponse.jsonBody,
                                                                                      )!
                                                                                      .map((label) => ChipData(label))
                                                                                      .toList(),
                                                                                  onChanged: (val) => safeSetState(() => _model.fixturesRoundValue = val?.firstOrNull),
                                                                                  selectedChipStyle: ChipStyle(
                                                                                    backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.poppins(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).info,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                    iconColor: FlutterFlowTheme.of(context).info,
                                                                                    iconSize: 16.0,
                                                                                    elevation: 0.0,
                                                                                    borderColor: FlutterFlowTheme.of(context).tertiary,
                                                                                    borderWidth: 1.0,
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                  unselectedChipStyle: ChipStyle(
                                                                                    backgroundColor: Color(0x00000000),
                                                                                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.poppins(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                    iconColor: Color(0x00000000),
                                                                                    iconSize: 16.0,
                                                                                    elevation: 0.0,
                                                                                    borderColor: FlutterFlowTheme.of(context).accent4,
                                                                                    borderWidth: 1.0,
                                                                                    borderRadius: BorderRadius.circular(21.0),
                                                                                  ),
                                                                                  chipSpacing: 16.0,
                                                                                  rowSpacing: 16.0,
                                                                                  multiselect: false,
                                                                                  initialized: _model.fixturesRoundValue != null,
                                                                                  alignment: WrapAlignment.start,
                                                                                  controller: _model.fixturesRoundValueController ??= FormFieldController<List<String>>(
                                                                                    [
                                                                                      SupabaseKickinEventGroup.getTournamentRoundsCall
                                                                                          .rounds(
                                                                                            fixturesRoundGetTournamentRoundsResponse.jsonBody,
                                                                                          )!
                                                                                          .firstOrNull!
                                                                                    ],
                                                                                  ),
                                                                                  wrapped: false,
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                60.0),
                                                                            child:
                                                                                FutureBuilder<List<KtmMatchesRow>>(
                                                                              future: _model
                                                                                  .fixtures(
                                                                                requestFn: () => KtmMatchesTable().queryRows(
                                                                                  queryFn: (q) => q
                                                                                      .eqOrNull(
                                                                                        'tournament_id',
                                                                                        eventDetailsorgTournamentsRow?.tournamentId,
                                                                                      )
                                                                                      .eqOrNull(
                                                                                        'status',
                                                                                        'upcoming',
                                                                                      )
                                                                                      .eqOrNull(
                                                                                        'round',
                                                                                        _model.fixturesRoundValue,
                                                                                      ),
                                                                                  limit: 15,
                                                                                ),
                                                                              )
                                                                                  .then((result) {
                                                                                _model.requestCompleted4 = true;
                                                                                return result;
                                                                              }),
                                                                              builder: (context, snapshot) {
                                                                                // Customize what your widget looks like when it's loading.
                                                                                if (!snapshot.hasData) {
                                                                                  return Center(
                                                                                    child: SizedBox(
                                                                                      width: 80.0,
                                                                                      height: 80.0,
                                                                                      child: CircularProgressIndicator(
                                                                                        valueColor: AlwaysStoppedAnimation<Color>(
                                                                                          FlutterFlowTheme.of(context).primary,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }
                                                                                List<KtmMatchesRow> fixturesKtmMatchesRowList = snapshot.data!;

                                                                                return ListView.builder(
                                                                                  padding: EdgeInsets.zero,
                                                                                  shrinkWrap: true,
                                                                                  scrollDirection: Axis.vertical,
                                                                                  itemCount: fixturesKtmMatchesRowList.length,
                                                                                  itemBuilder: (context, fixturesIndex) {
                                                                                    final fixturesKtmMatchesRow = fixturesKtmMatchesRowList[fixturesIndex];
                                                                                    return Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                                                                                      child: Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                        height: 150.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                          border: Border.all(
                                                                                            color: Color(0xA2FFFFFF),
                                                                                            width: 1.0,
                                                                                          ),
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 21.0, 16.0),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                            children: [
                                                                                              Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                children: [
                                                                                                  Expanded(
                                                                                                    child: Column(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          valueOrDefault<String>(
                                                                                                            fixturesKtmMatchesRow.team1Name,
                                                                                                            'Name',
                                                                                                          ),
                                                                                                          textAlign: TextAlign.center,
                                                                                                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                                font: GoogleFonts.oswald(
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                                ),
                                                                                                                fontSize: 16.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                                          child: Text(
                                                                                                            valueOrDefault<String>(
                                                                                                              fixturesKtmMatchesRow.team1Score?.toString(),
                                                                                                              '0',
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                                                  font: GoogleFonts.oswald(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                                                  ),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    child: Column(
                                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          'V/S',
                                                                                                          style: FlutterFlowTheme.of(context).headlineMedium.override(
                                                                                                                font: GoogleFonts.oswald(
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                                                                                                ),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    child: Column(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          valueOrDefault<String>(
                                                                                                            fixturesKtmMatchesRow.team2Name,
                                                                                                            'Name',
                                                                                                          ),
                                                                                                          textAlign: TextAlign.center,
                                                                                                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                                font: GoogleFonts.oswald(
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                                ),
                                                                                                                fontSize: 16.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                                          child: Text(
                                                                                                            valueOrDefault<String>(
                                                                                                              fixturesKtmMatchesRow.team2Score?.toString(),
                                                                                                              '0',
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                                                  font: GoogleFonts.oswald(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                                                  ),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ].divide(SizedBox(width: 6.0)),
                                                                                              ),
                                                                                              Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  FutureBuilder<List<KtmGroupsRow>>(
                                                                                                    future: KtmGroupsTable().querySingleRow(
                                                                                                      queryFn: (q) => q.eqOrNull(
                                                                                                        'group_id',
                                                                                                        fixturesKtmMatchesRow.groupId,
                                                                                                      ),
                                                                                                    ),
                                                                                                    builder: (context, snapshot) {
                                                                                                      // Customize what your widget looks like when it's loading.
                                                                                                      if (!snapshot.hasData) {
                                                                                                        return Center(
                                                                                                          child: SizedBox(
                                                                                                            width: 80.0,
                                                                                                            height: 80.0,
                                                                                                            child: CircularProgressIndicator(
                                                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                                                FlutterFlowTheme.of(context).primary,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        );
                                                                                                      }
                                                                                                      List<KtmGroupsRow> containerKtmGroupsRowList = snapshot.data!;

                                                                                                      final containerKtmGroupsRow = containerKtmGroupsRowList.isNotEmpty ? containerKtmGroupsRowList.first : null;

                                                                                                      return Container(
                                                                                                        decoration: BoxDecoration(),
                                                                                                        child: Text(
                                                                                                          valueOrDefault<String>(
                                                                                                            containerKtmGroupsRow?.groupName,
                                                                                                            'Group Name',
                                                                                                          ),
                                                                                                          textAlign: TextAlign.center,
                                                                                                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                                font: GoogleFonts.oswald(
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                                ),
                                                                                                                fontSize: 16.0,
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  ),
                                                                                                  Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                                    children: [
                                                                                                      InkWell(
                                                                                                        splashColor: Colors.transparent,
                                                                                                        focusColor: Colors.transparent,
                                                                                                        hoverColor: Colors.transparent,
                                                                                                        highlightColor: Colors.transparent,
                                                                                                        onTap: () async {
                                                                                                          logFirebaseEvent('EVENT_DETAILSORG_Icon_n6v67lgj_ON_TAP');
                                                                                                          logFirebaseEvent('Icon_bottom_sheet');
                                                                                                          await showModalBottomSheet(
                                                                                                            isScrollControlled: true,
                                                                                                            backgroundColor: Colors.transparent,
                                                                                                            context: context,
                                                                                                            builder: (context) {
                                                                                                              return WebViewAware(
                                                                                                                child: GestureDetector(
                                                                                                                  onTap: () {
                                                                                                                    FocusScope.of(context).unfocus();
                                                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                  },
                                                                                                                  child: Padding(
                                                                                                                    padding: MediaQuery.viewInsetsOf(context),
                                                                                                                    child: ScoresWidget(
                                                                                                                      ktmMatches: fixturesKtmMatchesRow,
                                                                                                                      notifyUsers: _model.notifyUsers,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              );
                                                                                                            },
                                                                                                          ).then((value) => safeSetState(() {}));

                                                                                                          logFirebaseEvent('Icon_refresh_database_request');
                                                                                                          safeSetState(() {
                                                                                                            _model.clearFixturesCache();
                                                                                                            _model.requestCompleted4 = false;
                                                                                                          });
                                                                                                          await _model.waitForRequestCompleted4();
                                                                                                        },
                                                                                                        child: Icon(
                                                                                                          Icons.ballot_outlined,
                                                                                                          color: FlutterFlowTheme.of(context).accent4,
                                                                                                          size: 26.0,
                                                                                                        ),
                                                                                                      ),
                                                                                                      InkWell(
                                                                                                        splashColor: Colors.transparent,
                                                                                                        focusColor: Colors.transparent,
                                                                                                        hoverColor: Colors.transparent,
                                                                                                        highlightColor: Colors.transparent,
                                                                                                        onTap: () async {
                                                                                                          logFirebaseEvent('EVENT_DETAILSORG_Icon_wtwekf50_ON_TAP');
                                                                                                          logFirebaseEvent('Icon_bottom_sheet');
                                                                                                          await showModalBottomSheet(
                                                                                                            isScrollControlled: true,
                                                                                                            backgroundColor: Colors.transparent,
                                                                                                            context: context,
                                                                                                            builder: (context) {
                                                                                                              return WebViewAware(
                                                                                                                child: GestureDetector(
                                                                                                                  onTap: () {
                                                                                                                    FocusScope.of(context).unfocus();
                                                                                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                                                                                  },
                                                                                                                  child: Padding(
                                                                                                                    padding: MediaQuery.viewInsetsOf(context),
                                                                                                                    child: ScoresWidget(
                                                                                                                      ktmMatches: fixturesKtmMatchesRow,
                                                                                                                      notifyUsers: _model.notifyUsers,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              );
                                                                                                            },
                                                                                                          ).then((value) => safeSetState(() {}));
                                                                                                        },
                                                                                                        child: Icon(
                                                                                                          Icons.edit,
                                                                                                          color: FlutterFlowTheme.of(context).accent4,
                                                                                                          size: 26.0,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ].divide(SizedBox(width: 16.0)),
                                                                                                  ),
                                                                                                ].divide(SizedBox(width: 16.0)),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                          KeepAliveWidgetWrapper(
                                                            builder:
                                                                (context) =>
                                                                    Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          32.0,
                                                                          12.0,
                                                                          80.0),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    if (eventDetailsorgTournamentsRow
                                                                            ?.creteadBy ==
                                                                        currentUserUid)
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children:
                                                                            [
                                                                          Expanded(
                                                                            child:
                                                                                FFButtonWidget(
                                                                              onPressed: () async {
                                                                                logFirebaseEvent('EVENT_DETAILSORG_PAGE_INVITE_BTN_ON_TAP');
                                                                                logFirebaseEvent('Button_bottom_sheet');
                                                                                await showModalBottomSheet(
                                                                                  isScrollControlled: true,
                                                                                  backgroundColor: Colors.transparent,
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return WebViewAware(
                                                                                      child: GestureDetector(
                                                                                        onTap: () {
                                                                                          FocusScope.of(context).unfocus();
                                                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                                                        },
                                                                                        child: Padding(
                                                                                          padding: MediaQuery.viewInsetsOf(context),
                                                                                          child: InviteTeamsWidget(
                                                                                            tournamentId: eventDetailsorgTournamentsRow!,
                                                                                            firstTime: false,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                ).then((value) => safeSetState(() {}));
                                                                              },
                                                                              text: 'Invite',
                                                                              options: FFButtonOptions(
                                                                                width: double.infinity,
                                                                                height: 48.0,
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                      font: GoogleFonts.oswald(
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                      ),
                                                                                      color: Colors.white,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                    ),
                                                                                elevation: 0.0,
                                                                                borderSide: BorderSide(
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  width: 1.0,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 16.0)),
                                                                      ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          60.0),
                                                                      child: FutureBuilder<
                                                                          List<
                                                                              KtmTeamsRow>>(
                                                                        future: _model
                                                                            .teamsss(
                                                                          requestFn: () =>
                                                                              KtmTeamsTable().queryRows(
                                                                            queryFn: (q) => q
                                                                                .eqOrNull(
                                                                                  'tournament_id',
                                                                                  eventDetailsorgTournamentsRow?.tournamentId,
                                                                                )
                                                                                .order('created_at', ascending: true),
                                                                            limit:
                                                                                40,
                                                                          ),
                                                                        )
                                                                            .then((result) {
                                                                          _model.requestCompleted2 =
                                                                              true;
                                                                          return result;
                                                                        }),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
                                                                            return Center(
                                                                              child: SizedBox(
                                                                                width: 80.0,
                                                                                height: 80.0,
                                                                                child: CircularProgressIndicator(
                                                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                                                    FlutterFlowTheme.of(context).primary,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                          List<KtmTeamsRow>
                                                                              teamsKtmTeamsRowList =
                                                                              snapshot.data!;

                                                                          return ListView
                                                                              .builder(
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            primary:
                                                                                false,
                                                                            shrinkWrap:
                                                                                true,
                                                                            scrollDirection:
                                                                                Axis.vertical,
                                                                            itemCount:
                                                                                teamsKtmTeamsRowList.length,
                                                                            itemBuilder:
                                                                                (context, teamsIndex) {
                                                                              final teamsKtmTeamsRow = teamsKtmTeamsRowList[teamsIndex];
                                                                              return Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                    border: Border.all(
                                                                                      color: FlutterFlowTheme.of(context).accent4,
                                                                                      width: 1.0,
                                                                                    ),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                                                                          child: Text(
                                                                                            valueOrDefault<String>(
                                                                                              teamsKtmTeamsRow.name,
                                                                                              'Name',
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                                  font: GoogleFonts.oswald(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                                  ),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                                                                          child: Text(
                                                                                            '${teamsKtmTeamsRow.members.length.toString()} members',
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.poppins(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          children: [
                                                                                            InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                logFirebaseEvent('EVENT_DETAILSORG_Icon_vl61wlr2_ON_TAP');
                                                                                                logFirebaseEvent('Icon_bottom_sheet');
                                                                                                await showModalBottomSheet(
                                                                                                  isScrollControlled: true,
                                                                                                  backgroundColor: Colors.transparent,
                                                                                                  context: context,
                                                                                                  builder: (context) {
                                                                                                    return WebViewAware(
                                                                                                      child: GestureDetector(
                                                                                                        onTap: () {
                                                                                                          FocusScope.of(context).unfocus();
                                                                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                                                                        },
                                                                                                        child: Padding(
                                                                                                          padding: MediaQuery.viewInsetsOf(context),
                                                                                                          child: TeamPlayersWidget(
                                                                                                            teamId: teamsKtmTeamsRow.teamId,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                ).then((value) => safeSetState(() {}));
                                                                                              },
                                                                                              child: Icon(
                                                                                                Icons.people_outline,
                                                                                                color: FlutterFlowTheme.of(context).accent4,
                                                                                                size: 26.0,
                                                                                              ),
                                                                                            ),
                                                                                            InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                logFirebaseEvent('EVENT_DETAILSORG_Icon_ke7sv9ma_ON_TAP');
                                                                                                logFirebaseEvent('Icon_alert_dialog');
                                                                                                var confirmDialogResponse = await showDialog<bool>(
                                                                                                      context: context,
                                                                                                      builder: (alertDialogContext) {
                                                                                                        return WebViewAware(
                                                                                                          child: AlertDialog(
                                                                                                            title: Text('Team Removal'),
                                                                                                            content: Text('Are you sure you want to remove ${teamsKtmTeamsRow.name} ?'),
                                                                                                            actions: [
                                                                                                              TextButton(
                                                                                                                onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                                                child: Text('Cancel'),
                                                                                                              ),
                                                                                                              TextButton(
                                                                                                                onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                                                child: Text('Confirm'),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                        );
                                                                                                      },
                                                                                                    ) ??
                                                                                                    false;
                                                                                                if (confirmDialogResponse) {
                                                                                                  logFirebaseEvent('Icon_backend_call');
                                                                                                  await KtmTeamsTable().delete(
                                                                                                    matchingRows: (rows) => rows
                                                                                                        .eqOrNull(
                                                                                                          'tournament_id',
                                                                                                          eventDetailsorgTournamentsRow?.tournamentId,
                                                                                                        )
                                                                                                        .eqOrNull(
                                                                                                          'team_id',
                                                                                                          teamsKtmTeamsRow.teamId,
                                                                                                        ),
                                                                                                  );
                                                                                                } else {
                                                                                                  logFirebaseEvent('Icon_close_dialog_drawer_etc');
                                                                                                  Navigator.pop(context);
                                                                                                }
                                                                                              },
                                                                                              child: Icon(
                                                                                                Icons.delete_outline,
                                                                                                color: FlutterFlowTheme.of(context).accent4,
                                                                                                size: 26.0,
                                                                                              ),
                                                                                            ),
                                                                                          ].divide(SizedBox(width: 16.0)),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          24.0)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          KeepAliveWidgetWrapper(
                                                            builder:
                                                                (context) =>
                                                                    Visibility(
                                                              visible:
                                                                  eventDetailsorgTournamentsRow
                                                                          ?.status ==
                                                                      'fixture',
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        32.0,
                                                                        12.0,
                                                                        0.0),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  primary:
                                                                      false,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            16.0),
                                                                        child: FutureBuilder<
                                                                            ApiCallResponse>(
                                                                          future:
                                                                              _model.rounds(
                                                                            requestFn: () =>
                                                                                SupabaseKickinEventGroup.getTournamentRoundsCall.call(
                                                                              tournamentUuid: eventDetailsorgTournamentsRow?.tournamentId,
                                                                            ),
                                                                          ),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            // Customize what your widget looks like when it's loading.
                                                                            if (!snapshot.hasData) {
                                                                              return Center(
                                                                                child: SizedBox(
                                                                                  width: 80.0,
                                                                                  height: 80.0,
                                                                                  child: CircularProgressIndicator(
                                                                                    valueColor: AlwaysStoppedAnimation<Color>(
                                                                                      FlutterFlowTheme.of(context).primary,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                            final fixturesRoundsGetTournamentRoundsResponse =
                                                                                snapshot.data!;

                                                                            return FlutterFlowChoiceChips(
                                                                              options: SupabaseKickinEventGroup.getTournamentRoundsCall
                                                                                  .rounds(
                                                                                    fixturesRoundsGetTournamentRoundsResponse.jsonBody,
                                                                                  )!
                                                                                  .map((label) => ChipData(label))
                                                                                  .toList(),
                                                                              onChanged: (val) => safeSetState(() => _model.fixturesRoundsValue = val?.firstOrNull),
                                                                              selectedChipStyle: ChipStyle(
                                                                                backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.poppins(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).info,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                iconColor: FlutterFlowTheme.of(context).info,
                                                                                iconSize: 16.0,
                                                                                elevation: 0.0,
                                                                                borderColor: FlutterFlowTheme.of(context).tertiary,
                                                                                borderWidth: 1.0,
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                              ),
                                                                              unselectedChipStyle: ChipStyle(
                                                                                backgroundColor: Color(0x00000000),
                                                                                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.poppins(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                iconColor: Color(0x00000000),
                                                                                iconSize: 16.0,
                                                                                elevation: 0.0,
                                                                                borderColor: FlutterFlowTheme.of(context).accent4,
                                                                                borderWidth: 1.0,
                                                                                borderRadius: BorderRadius.circular(21.0),
                                                                              ),
                                                                              chipSpacing: 16.0,
                                                                              rowSpacing: 16.0,
                                                                              multiselect: false,
                                                                              initialized: _model.fixturesRoundsValue != null,
                                                                              alignment: WrapAlignment.start,
                                                                              controller: _model.fixturesRoundsValueController ??= FormFieldController<List<String>>(
                                                                                [
                                                                                  SupabaseKickinEventGroup.getTournamentRoundsCall
                                                                                      .rounds(
                                                                                        fixturesRoundsGetTournamentRoundsResponse.jsonBody,
                                                                                      )!
                                                                                      .firstOrNull!
                                                                                ],
                                                                              ),
                                                                              wrapped: false,
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            60.0),
                                                                        child: FutureBuilder<
                                                                            List<KtmMatchesRow>>(
                                                                          future: _model
                                                                              .results(
                                                                            requestFn: () =>
                                                                                KtmMatchesTable().queryRows(
                                                                              queryFn: (q) => q
                                                                                  .eqOrNull(
                                                                                    'tournament_id',
                                                                                    eventDetailsorgTournamentsRow?.tournamentId,
                                                                                  )
                                                                                  .eqOrNull(
                                                                                    'status',
                                                                                    'completed',
                                                                                  )
                                                                                  .eqOrNull(
                                                                                    'round',
                                                                                    _model.fixturesRoundsValue,
                                                                                  ),
                                                                              limit: 15,
                                                                            ),
                                                                          )
                                                                              .then((result) {
                                                                            _model.requestCompleted3 =
                                                                                true;
                                                                            return result;
                                                                          }),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            // Customize what your widget looks like when it's loading.
                                                                            if (!snapshot.hasData) {
                                                                              return Center(
                                                                                child: SizedBox(
                                                                                  width: 80.0,
                                                                                  height: 80.0,
                                                                                  child: CircularProgressIndicator(
                                                                                    valueColor: AlwaysStoppedAnimation<Color>(
                                                                                      FlutterFlowTheme.of(context).primary,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                            List<KtmMatchesRow>
                                                                                scoreCardKtmMatchesRowList =
                                                                                snapshot.data!;

                                                                            return ListView.builder(
                                                                              padding: EdgeInsets.zero,
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.vertical,
                                                                              itemCount: scoreCardKtmMatchesRowList.length,
                                                                              itemBuilder: (context, scoreCardIndex) {
                                                                                final scoreCardKtmMatchesRow = scoreCardKtmMatchesRowList[scoreCardIndex];
                                                                                return Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                                                                                  child: Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                    height: 180.0,
                                                                                    decoration: BoxDecoration(
                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                      border: Border.all(
                                                                                        color: Color(0xA2FFFFFF),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 21.0, 16.0),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                        children: [
                                                                                          if (scoreCardKtmMatchesRow.status == 'completed')
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                Container(
                                                                                                  width: 100.0,
                                                                                                  decoration: BoxDecoration(),
                                                                                                  child: Visibility(
                                                                                                    visible: scoreCardKtmMatchesRow.winnerId == scoreCardKtmMatchesRow.team1Id,
                                                                                                    child: Container(
                                                                                                      width: 100.0,
                                                                                                      height: 35.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).tertiary,
                                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                                      ),
                                                                                                      child: Align(
                                                                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(6.0, 6.0, 6.0, 6.0),
                                                                                                          child: Text(
                                                                                                            'Winner',
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.poppins(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                                                  fontSize: 12.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Container(
                                                                                                  width: 100.0,
                                                                                                  decoration: BoxDecoration(),
                                                                                                  child: Visibility(
                                                                                                    visible: scoreCardKtmMatchesRow.team1Score == scoreCardKtmMatchesRow.team2Score,
                                                                                                    child: Container(
                                                                                                      width: 100.0,
                                                                                                      height: 35.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).accent4,
                                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                                      ),
                                                                                                      child: Align(
                                                                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(6.0, 6.0, 6.0, 6.0),
                                                                                                          child: Text(
                                                                                                            'Draw',
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.poppins(
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                                                  fontSize: 12.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Container(
                                                                                                  width: 100.0,
                                                                                                  decoration: BoxDecoration(),
                                                                                                  child: Visibility(
                                                                                                    visible: scoreCardKtmMatchesRow.winnerId == scoreCardKtmMatchesRow.team2Id,
                                                                                                    child: Container(
                                                                                                      width: 100.0,
                                                                                                      height: 35.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).tertiary,
                                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                                      ),
                                                                                                      child: Align(
                                                                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(6.0, 6.0, 6.0, 6.0),
                                                                                                          child: Text(
                                                                                                            'Winner',
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.poppins(
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                                                  fontSize: 12.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w600,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              Expanded(
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      valueOrDefault<String>(
                                                                                                        scoreCardKtmMatchesRow.team1Name,
                                                                                                        'Name',
                                                                                                      ),
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                            font: GoogleFonts.oswald(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: 16.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          scoreCardKtmMatchesRow.team1Score?.toString(),
                                                                                                          '0',
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                                              font: GoogleFonts.oswald(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                                              ),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      'V/S',
                                                                                                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                                                                                                            font: GoogleFonts.oswald(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                                                                                            ),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      valueOrDefault<String>(
                                                                                                        scoreCardKtmMatchesRow.team2Name,
                                                                                                        'Name',
                                                                                                      ),
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                            font: GoogleFonts.oswald(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: 16.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                                      child: Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          scoreCardKtmMatchesRow.team2Score?.toString(),
                                                                                                          '0',
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                                              font: GoogleFonts.oswald(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                                              ),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ].divide(SizedBox(width: 6.0)),
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              FutureBuilder<List<KtmGroupsRow>>(
                                                                                                future: KtmGroupsTable().querySingleRow(
                                                                                                  queryFn: (q) => q.eqOrNull(
                                                                                                    'group_id',
                                                                                                    scoreCardKtmMatchesRow.groupId,
                                                                                                  ),
                                                                                                ),
                                                                                                builder: (context, snapshot) {
                                                                                                  // Customize what your widget looks like when it's loading.
                                                                                                  if (!snapshot.hasData) {
                                                                                                    return Center(
                                                                                                      child: SizedBox(
                                                                                                        width: 80.0,
                                                                                                        height: 80.0,
                                                                                                        child: CircularProgressIndicator(
                                                                                                          valueColor: AlwaysStoppedAnimation<Color>(
                                                                                                            FlutterFlowTheme.of(context).primary,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    );
                                                                                                  }
                                                                                                  List<KtmGroupsRow> containerKtmGroupsRowList = snapshot.data!;

                                                                                                  final containerKtmGroupsRow = containerKtmGroupsRowList.isNotEmpty ? containerKtmGroupsRowList.first : null;

                                                                                                  return Container(
                                                                                                    decoration: BoxDecoration(),
                                                                                                    child: Text(
                                                                                                      valueOrDefault<String>(
                                                                                                        containerKtmGroupsRow?.groupName,
                                                                                                        'Group Name',
                                                                                                      ),
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                            font: GoogleFonts.oswald(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: 16.0,
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  );
                                                                                                },
                                                                                              ),
                                                                                              Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                                children: [
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      logFirebaseEvent('EVENT_DETAILSORG_Icon_m0tduunw_ON_TAP');
                                                                                                      logFirebaseEvent('Icon_bottom_sheet');
                                                                                                      await showModalBottomSheet(
                                                                                                        isScrollControlled: true,
                                                                                                        backgroundColor: Colors.transparent,
                                                                                                        context: context,
                                                                                                        builder: (context) {
                                                                                                          return WebViewAware(
                                                                                                            child: GestureDetector(
                                                                                                              onTap: () {
                                                                                                                FocusScope.of(context).unfocus();
                                                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                                                              },
                                                                                                              child: Padding(
                                                                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                                                                child: ScoresWidget(
                                                                                                                  ktmMatches: scoreCardKtmMatchesRow,
                                                                                                                  notifyUsers: _model.notifyUsers,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          );
                                                                                                        },
                                                                                                      ).then((value) => safeSetState(() {}));
                                                                                                    },
                                                                                                    child: Icon(
                                                                                                      Icons.edit,
                                                                                                      color: FlutterFlowTheme.of(context).accent4,
                                                                                                      size: 26.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                ].divide(SizedBox(width: 16.0)),
                                                                                              ),
                                                                                            ].divide(SizedBox(width: 16.0)),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          KeepAliveWidgetWrapper(
                                                            builder:
                                                                (context) =>
                                                                    Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          32.0,
                                                                          12.0,
                                                                          0.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      if (eventDetailsorgTournamentsRow
                                                                              ?.creteadBy ==
                                                                          currentUserUid)
                                                                        Expanded(
                                                                          child:
                                                                              FFButtonWidget(
                                                                            onPressed:
                                                                                () async {
                                                                              logFirebaseEvent('EVENT_DETAILSORG_UPLOAD_PHOTOS_BTN_ON_TA');
                                                                              logFirebaseEvent('Button_upload_media_to_supabase');
                                                                              final selectedMedia = await selectMedia(
                                                                                storageFolderPath: 'event/',
                                                                                maxWidth: 900.00,
                                                                                maxHeight: 1080.00,
                                                                                imageQuality: 85,
                                                                                mediaSource: MediaSource.photoGallery,
                                                                                multiImage: true,
                                                                              );
                                                                              if (selectedMedia != null && selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                                                                safeSetState(() => _model.isDataUploading_uploadDataJq1 = true);
                                                                                var selectedUploadedFiles = <FFUploadedFile>[];

                                                                                var downloadUrls = <String>[];
                                                                                try {
                                                                                  showUploadMessage(
                                                                                    context,
                                                                                    'Uploading file...',
                                                                                    showLoading: true,
                                                                                  );
                                                                                  selectedUploadedFiles = selectedMedia
                                                                                      .map((m) => FFUploadedFile(
                                                                                            name: m.storagePath.split('/').last,
                                                                                            bytes: m.bytes,
                                                                                            height: m.dimensions?.height,
                                                                                            width: m.dimensions?.width,
                                                                                            blurHash: m.blurHash,
                                                                                          ))
                                                                                      .toList();

                                                                                  downloadUrls = await uploadSupabaseStorageFiles(
                                                                                    bucketName: 'tournament-media',
                                                                                    selectedFiles: selectedMedia,
                                                                                  );
                                                                                } finally {
                                                                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                                  _model.isDataUploading_uploadDataJq1 = false;
                                                                                }
                                                                                if (selectedUploadedFiles.length == selectedMedia.length && downloadUrls.length == selectedMedia.length) {
                                                                                  safeSetState(() {
                                                                                    _model.uploadedLocalFiles_uploadDataJq1 = selectedUploadedFiles;
                                                                                    _model.uploadedFileUrls_uploadDataJq1 = downloadUrls;
                                                                                  });
                                                                                  showUploadMessage(context, 'Success!');
                                                                                } else {
                                                                                  safeSetState(() {});
                                                                                  showUploadMessage(context, 'Failed to upload data');
                                                                                  return;
                                                                                }
                                                                              }

                                                                              logFirebaseEvent('Button_backend_call');
                                                                              await TournamentMediaTable().insert({
                                                                                'created_at': supaSerialize<DateTime>(getCurrentTimestamp),
                                                                                'image_url': _model.uploadedFileUrls_uploadDataJq1,
                                                                                'tournament_id': eventDetailsorgTournamentsRow?.tournamentId,
                                                                              });
                                                                              logFirebaseEvent('Button_alert_dialog');
                                                                              await showDialog(
                                                                                context: context,
                                                                                builder: (alertDialogContext) {
                                                                                  return WebViewAware(
                                                                                    child: AlertDialog(
                                                                                      title: Text('Uploaded Sucessfully'),
                                                                                      content: Text('All Photos Have Been Sucessfully Uploaded.'),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                          onPressed: () => Navigator.pop(alertDialogContext),
                                                                                          child: Text('View Photos'),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              );
                                                                              logFirebaseEvent('Button_refresh_database_request');
                                                                              safeSetState(() {
                                                                                _model.clearImagesEventCache();
                                                                                _model.requestCompleted1 = false;
                                                                              });
                                                                              await _model.waitForRequestCompleted1();
                                                                              logFirebaseEvent('Button_trigger_push_notification');
                                                                              triggerPushNotification(
                                                                                notificationTitle: eventDetailsorgTournamentsRow!.name,
                                                                                notificationText: 'Images has been uploaded.',
                                                                                notificationImageUrl: eventDetailsorgTournamentsRow.mediaUrl,
                                                                                notificationSound: 'default',
                                                                                userRefs: _model.notifyUsers.toList(),
                                                                                initialPageName: 'event_details',
                                                                                parameterData: {
                                                                                  'tabNumber': 0,
                                                                                  'tournamentid': eventDetailsorgTournamentsRow.tournamentId,
                                                                                },
                                                                              );
                                                                            },
                                                                            text:
                                                                                'Upload Photos',
                                                                            options:
                                                                                FFButtonOptions(
                                                                              width: double.infinity,
                                                                              height: 48.0,
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              iconAlignment: IconAlignment.start,
                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              textStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                    font: GoogleFonts.poppins(
                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).accent4,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                  ),
                                                                              elevation: 0.0,
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            16.0)),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          40.0),
                                                                      child: FutureBuilder<
                                                                          List<
                                                                              TournamentMediaRow>>(
                                                                        future: _model
                                                                            .imagesEvent(
                                                                          requestFn: () =>
                                                                              TournamentMediaTable().querySingleRow(
                                                                            queryFn: (q) =>
                                                                                q.eqOrNull(
                                                                              'tournament_id',
                                                                              eventDetailsorgTournamentsRow?.tournamentId,
                                                                            ),
                                                                          ),
                                                                        )
                                                                            .then((result) {
                                                                          _model.requestCompleted1 =
                                                                              true;
                                                                          return result;
                                                                        }),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
                                                                            return Center(
                                                                              child: SizedBox(
                                                                                width: 80.0,
                                                                                height: 80.0,
                                                                                child: CircularProgressIndicator(
                                                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                                                    FlutterFlowTheme.of(context).primary,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                          List<TournamentMediaRow>
                                                                              gridViewTournamentMediaRowList =
                                                                              snapshot.data!;

                                                                          final gridViewTournamentMediaRow = gridViewTournamentMediaRowList.isNotEmpty
                                                                              ? gridViewTournamentMediaRowList.first
                                                                              : null;

                                                                          return Builder(
                                                                            builder:
                                                                                (context) {
                                                                              final images = (gridViewTournamentMediaRow?.imageUrl.toList() ?? []).take(200).toList();

                                                                              return GridView.builder(
                                                                                padding: EdgeInsets.zero,
                                                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                  crossAxisCount: 2,
                                                                                  crossAxisSpacing: 1.0,
                                                                                  mainAxisSpacing: 1.0,
                                                                                  childAspectRatio: 1.0,
                                                                                ),
                                                                                scrollDirection: Axis.vertical,
                                                                                itemCount: images.length,
                                                                                itemBuilder: (context, imagesIndex) {
                                                                                  final imagesItem = images[imagesIndex];
                                                                                  return InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      logFirebaseEvent('EVENT_DETAILSORG_Image_ls63doq4_ON_TAP');
                                                                                      logFirebaseEvent('Image_bottom_sheet');
                                                                                      await showModalBottomSheet(
                                                                                        isScrollControlled: true,
                                                                                        backgroundColor: Colors.transparent,
                                                                                        context: context,
                                                                                        builder: (context) {
                                                                                          return WebViewAware(
                                                                                            child: GestureDetector(
                                                                                              onTap: () {
                                                                                                FocusScope.of(context).unfocus();
                                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                                              },
                                                                                              child: Padding(
                                                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                                                child: ImagePreviewWidget(
                                                                                                  imagepath: imagesItem,
                                                                                                  url: imagesItem,
                                                                                                  isPlayer: false,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      ).then((value) => safeSetState(() {}));
                                                                                    },
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.only(
                                                                                        bottomLeft: Radius.circular(0.0),
                                                                                        bottomRight: Radius.circular(0.0),
                                                                                        topLeft: Radius.circular(0.0),
                                                                                        topRight: Radius.circular(0.0),
                                                                                      ),
                                                                                      child: CachedNetworkImage(
                                                                                        fadeInDuration: Duration(milliseconds: 500),
                                                                                        fadeOutDuration: Duration(milliseconds: 500),
                                                                                        imageUrl: imagesItem,
                                                                                        height: 200.0,
                                                                                        fit: BoxFit.contain,
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    height:
                                                                        24.0)),
                                                              ),
                                                            ),
                                                          ),
                                                          KeepAliveWidgetWrapper(
                                                            builder:
                                                                (context) =>
                                                                    Visibility(
                                                              visible:
                                                                  eventDetailsorgTournamentsRow
                                                                          ?.status ==
                                                                      'group',
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        24.0,
                                                                        12.0,
                                                                        0.0),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  primary:
                                                                      false,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            24.0),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            if (eventDetailsorgTournamentsRow?.status ==
                                                                                'Group')
                                                                              FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  logFirebaseEvent('EVENT_DETAILSORG_group_fixtures_button_O');
                                                                                  logFirebaseEvent('group_fixtures_button_backend_call');
                                                                                  _model.fixturesList = await SupabaseKickinEventGroup.kTMGenerateGroupFixturesCall.call(
                                                                                    pTournamentId: eventDetailsorgTournamentsRow?.tournamentId,
                                                                                    pMatchType: eventDetailsorgTournamentsRow?.roundRobinType,
                                                                                  );

                                                                                  if ((_model.fixturesList?.succeeded ?? true)) {
                                                                                    logFirebaseEvent('group_fixtures_button_refresh_database_r');
                                                                                    safeSetState(() {
                                                                                      _model.clearEventDetailsCache();
                                                                                      _model.requestCompleted5 = false;
                                                                                    });
                                                                                    await _model.waitForRequestCompleted5();
                                                                                    logFirebaseEvent('group_fixtures_button_refresh_database_r');
                                                                                    safeSetState(() {
                                                                                      _model.clearFixturesCache();
                                                                                      _model.requestCompleted4 = false;
                                                                                    });
                                                                                    await _model.waitForRequestCompleted4();
                                                                                    logFirebaseEvent('group_fixtures_button_tab_bar');
                                                                                    safeSetState(() {
                                                                                      _model.tabBarController!.animateTo(
                                                                                        0,
                                                                                        duration: Duration(milliseconds: 300),
                                                                                        curve: Curves.ease,
                                                                                      );
                                                                                    });
                                                                                  } else {
                                                                                    logFirebaseEvent('group_fixtures_button_alert_dialog');
                                                                                    await showDialog(
                                                                                      context: context,
                                                                                      builder: (alertDialogContext) {
                                                                                        return WebViewAware(
                                                                                          child: AlertDialog(
                                                                                            title: Text('Invite More Teams'),
                                                                                            content: Text((_model.fixturesList?.exceptionMessage ?? '')),
                                                                                            actions: [
                                                                                              TextButton(
                                                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                child: Text('Ok'),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                    );
                                                                                  }

                                                                                  safeSetState(() {});
                                                                                },
                                                                                text: 'Generate Group Fixtures',
                                                                                options: FFButtonOptions(
                                                                                  width: double.infinity,
                                                                                  height: 48.0,
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                  color: FlutterFlowTheme.of(context).tertiary,
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        font: GoogleFonts.oswald(
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                      ),
                                                                                  elevation: 0.0,
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                ),
                                                                              ),
                                                                            if (eventDetailsorgTournamentsRow?.status ==
                                                                                'Finals')
                                                                              FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  logFirebaseEvent('EVENT_DETAILSORG_Advance_knockout_button');
                                                                                  logFirebaseEvent('Advance_knockout_button_backend_call');
                                                                                  _model.groupKnockout = await SupabaseKickinEventGroup.kTMGenerateGroupKnockoutFixturesCall.call(
                                                                                    pTournamentId: eventDetailsorgTournamentsRow?.tournamentId,
                                                                                    pTopNPerGroup: eventDetailsorgTournamentsRow?.qualifiersPerGroup,
                                                                                  );

                                                                                  if ((_model.groupKnockout?.succeeded ?? true)) {
                                                                                    logFirebaseEvent('Advance_knockout_button_backend_call');
                                                                                    await TournamentsTable().update(
                                                                                      data: {
                                                                                        'status': 'Ongoing',
                                                                                      },
                                                                                      matchingRows: (rows) => rows.eqOrNull(
                                                                                        'tournament_id',
                                                                                        widget.tournamentId,
                                                                                      ),
                                                                                    );
                                                                                    logFirebaseEvent('Advance_knockout_button_refresh_database');
                                                                                    safeSetState(() {
                                                                                      _model.clearFixturesCache();
                                                                                      _model.requestCompleted4 = false;
                                                                                    });
                                                                                    await _model.waitForRequestCompleted4();
                                                                                    logFirebaseEvent('Advance_knockout_button_refresh_database');
                                                                                    safeSetState(() {
                                                                                      _model.clearRoundsCache();
                                                                                      _model.apiRequestCompleted1 = false;
                                                                                    });
                                                                                    await _model.waitForApiRequestCompleted1();
                                                                                    logFirebaseEvent('Advance_knockout_button_tab_bar');
                                                                                    safeSetState(() {
                                                                                      _model.tabBarController!.animateTo(
                                                                                        0,
                                                                                        duration: Duration(milliseconds: 300),
                                                                                        curve: Curves.ease,
                                                                                      );
                                                                                    });
                                                                                  } else {
                                                                                    logFirebaseEvent('Advance_knockout_button_alert_dialog');
                                                                                    await showDialog(
                                                                                      context: context,
                                                                                      builder: (alertDialogContext) {
                                                                                        return WebViewAware(
                                                                                          child: AlertDialog(
                                                                                            title: Text('Invite More Teams'),
                                                                                            content: Text((_model.groupKnockout?.exceptionMessage ?? '')),
                                                                                            actions: [
                                                                                              TextButton(
                                                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                child: Text('Ok'),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                    );
                                                                                  }

                                                                                  safeSetState(() {});
                                                                                },
                                                                                text: 'Generate Advance Knockout FIxtures',
                                                                                options: FFButtonOptions(
                                                                                  width: double.infinity,
                                                                                  height: 48.0,
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                  color: FlutterFlowTheme.of(context).tertiary,
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        font: GoogleFonts.oswald(
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).primary,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                      ),
                                                                                  elevation: 0.0,
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                ),
                                                                              ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            16.0),
                                                                        child: FutureBuilder<
                                                                            List<KtmGroupsRow>>(
                                                                          future:
                                                                              _model.grp(
                                                                            requestFn: () =>
                                                                                KtmGroupsTable().queryRows(
                                                                              queryFn: (q) => q
                                                                                  .eqOrNull(
                                                                                    'tournament_id',
                                                                                    eventDetailsorgTournamentsRow?.tournamentId,
                                                                                  )
                                                                                  .order('group_name', ascending: true),
                                                                              limit: 10,
                                                                            ),
                                                                          ),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            // Customize what your widget looks like when it's loading.
                                                                            if (!snapshot.hasData) {
                                                                              return Center(
                                                                                child: SizedBox(
                                                                                  width: 80.0,
                                                                                  height: 80.0,
                                                                                  child: CircularProgressIndicator(
                                                                                    valueColor: AlwaysStoppedAnimation<Color>(
                                                                                      FlutterFlowTheme.of(context).primary,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                            List<KtmGroupsRow>
                                                                                choiceChipsGroupsKtmGroupsRowList =
                                                                                snapshot.data!;

                                                                            return FlutterFlowChoiceChips(
                                                                              options: _model.groupsName.map((label) => ChipData(label)).toList(),
                                                                              onChanged: (val) => safeSetState(() => _model.choiceChipsGroupsValue = val?.firstOrNull),
                                                                              selectedChipStyle: ChipStyle(
                                                                                backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.poppins(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).info,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                iconColor: FlutterFlowTheme.of(context).info,
                                                                                iconSize: 16.0,
                                                                                elevation: 0.0,
                                                                                borderColor: FlutterFlowTheme.of(context).tertiary,
                                                                                borderWidth: 1.0,
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                              ),
                                                                              unselectedChipStyle: ChipStyle(
                                                                                backgroundColor: Color(0x00000000),
                                                                                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.poppins(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                iconColor: Color(0x00000000),
                                                                                iconSize: 16.0,
                                                                                elevation: 0.0,
                                                                                borderColor: FlutterFlowTheme.of(context).accent4,
                                                                                borderWidth: 1.0,
                                                                                borderRadius: BorderRadius.circular(21.0),
                                                                              ),
                                                                              chipSpacing: 16.0,
                                                                              rowSpacing: 16.0,
                                                                              multiselect: false,
                                                                              initialized: _model.choiceChipsGroupsValue != null,
                                                                              alignment: WrapAlignment.start,
                                                                              controller: _model.choiceChipsGroupsValueController ??= FormFieldController<List<String>>(
                                                                                [
                                                                                  choiceChipsGroupsKtmGroupsRowList.firstOrNull!.groupName
                                                                                ],
                                                                              ),
                                                                              wrapped: false,
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                      FutureBuilder<
                                                                          ApiCallResponse>(
                                                                        future: _model
                                                                            .groups(
                                                                          requestFn: () => SupabaseKickinEventGroup
                                                                              .standingsCall
                                                                              .call(
                                                                            inputTournamentId:
                                                                                eventDetailsorgTournamentsRow?.tournamentId,
                                                                            inputGroupId:
                                                                                _model.choiceChipsGroupsValue,
                                                                          ),
                                                                        )
                                                                            .then((result) {
                                                                          _model.apiRequestCompleted2 =
                                                                              true;
                                                                          return result;
                                                                        }),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
                                                                            return Center(
                                                                              child: SizedBox(
                                                                                width: 80.0,
                                                                                height: 80.0,
                                                                                child: CircularProgressIndicator(
                                                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                                                    FlutterFlowTheme.of(context).primary,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                          final customScoreboardTableStandingsResponse =
                                                                              snapshot.data!;

                                                                          return Container(
                                                                            width:
                                                                                double.infinity,
                                                                            height:
                                                                                500.0,
                                                                            child:
                                                                                custom_widgets.CustomScoreboardTable(
                                                                              width: double.infinity,
                                                                              height: 500.0,
                                                                              leftColumnWidth: 180.0,
                                                                              qualifiedCount: eventDetailsorgTournamentsRow!.qualifiersPerGroup!,
                                                                              standings: customScoreboardTableStandingsResponse.jsonBody,
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 16.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, -0.91),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.network(
                                'https://grbbdskhtdettoddpxfl.supabase.co/storage/v1/object/public/storage/assest/Kickin%20Logo.svg',
                                width: 48.0,
                                height: 48.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: Color(0x520E151B),
                                        offset: Offset(
                                          0.0,
                                          2.0,
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 8.0,
                                    borderWidth: 1.0,
                                    buttonSize: 40.0,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    icon: Icon(
                                      Icons.link_sharp,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 20.0,
                                    ),
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'EVENT_DETAILSORG_link_sharp_ICN_ON_TAP');
                                      logFirebaseEvent(
                                          'IconButton_copy_to_clipboard');
                                      await Clipboard.setData(ClipboardData(
                                          text: eventDetailsorgTournamentsRow!
                                              .tournamentLink!));
                                    },
                                  ),
                                ),
                                Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: Color(0x520E151B),
                                        offset: Offset(
                                          0.0,
                                          2.0,
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 8.0,
                                    borderWidth: 1.0,
                                    buttonSize: 40.0,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    icon: Icon(
                                      Icons.home_filled,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 20.0,
                                    ),
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'EVENT_DETAILSORG_home_filled_ICN_ON_TAP');
                                      logFirebaseEvent(
                                          'IconButton_navigate_to');

                                      context.pushNamed(HomeWidget.routeName);
                                    },
                                  ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                          ].divide(SizedBox(width: 16.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
