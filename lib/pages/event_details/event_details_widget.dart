import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/empty_widget.dart';
import '/components/image_preview_widget.dart';
import '/components/invite_players_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'event_details_model.dart';
export 'event_details_model.dart';

class EventDetailsWidget extends StatefulWidget {
  const EventDetailsWidget({
    super.key,
    required this.tabNumber,
    required this.tournamentid,
  });

  final int? tabNumber;
  final String? tournamentid;

  static String routeName = 'event_details';
  static String routePath = 'eventDetails';

  @override
  State<EventDetailsWidget> createState() => _EventDetailsWidgetState();
}

class _EventDetailsWidgetState extends State<EventDetailsWidget>
    with TickerProviderStateMixin {
  late EventDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventDetailsModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'event_details'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('EVENT_DETAILS_event_details_ON_INIT_STAT');
      if (currentUserUid == '') {
        logFirebaseEvent('event_details_navigate_to');

        context.goNamed(WelcomeWidget.routeName);
      } else {
        logFirebaseEvent('event_details_backend_call');
        _model.media = await EventPageMediaCall.call(
          pTournamentId: widget.tournamentid,
        );

        for (int loop1Index = 0;
            loop1Index < (_model.media?.jsonBody ?? '').length;
            loop1Index++) {
          final currentLoop1Item = (_model.media?.jsonBody ?? '')[loop1Index];
          logFirebaseEvent('event_details_backend_call');
          _model.view = await KickinMediaAdsCall.call(
            pAdId: getJsonField(
              currentLoop1Item,
              r'''$.id''',
            ).toString().toString(),
            pUserId: currentUserReference?.id,
            pMode: 'view',
          );
        }
      }
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 6,
      initialIndex: 1,
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
    return FutureBuilder<List<KtmTeamsRow>>(
      future: KtmTeamsTable().querySingleRow(
        queryFn: (q) => q
            .eqOrNull(
              'tournament_id',
              widget.tournamentid,
            )
            .containsOrNull(
              'Members',
              '{${currentUserReference?.id}}',
            ),
      ),
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
        List<KtmTeamsRow> eventDetailsKtmTeamsRowList = snapshot.data!;

        final eventDetailsKtmTeamsRow = eventDetailsKtmTeamsRowList.isNotEmpty
            ? eventDetailsKtmTeamsRowList.first
            : null;

        return Title(
            title: 'event_details',
            color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                key: scaffoldKey,
                resizeToAvoidBottomInset: false,
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                body: FutureBuilder<List<TournamentsRow>>(
                  future: TournamentsTable().querySingleRow(
                    queryFn: (q) => q.eqOrNull(
                      'tournament_id',
                      widget.tournamentid,
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
                    List<TournamentsRow> stackTournamentsRowList =
                        snapshot.data!;

                    final stackTournamentsRow =
                        stackTournamentsRowList.isNotEmpty
                            ? stackTournamentsRowList.first
                            : null;

                    return Stack(
                      children: [
                        Builder(
                          builder: (context) {
                            final mediaAds = (_model.media?.jsonBody ?? '')
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
                                          'EVENT_DETAILS_PAGE_Image_cxvjolid_ON_TAP');
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
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                carouselController:
                                    _model.carouselController ??=
                                        CarouselSliderController(),
                                options: CarouselOptions(
                                  initialPage:
                                      max(0, min(0, mediaAds.length - 1)),
                                  viewportFraction: 1.0,
                                  disableCenter: true,
                                  enlargeCenterPage: true,
                                  enlargeFactor: 1.0,
                                  enableInfiniteScroll: true,
                                  scrollDirection: Axis.horizontal,
                                  autoPlay: valueOrDefault<bool>(
                                    EventPageMediaCall.media(
                                              (_model.media?.jsonBody ?? ''),
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 12.0, 0.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 12.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
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
                                                          Container(
                                                            width: 180.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                stackTournamentsRow
                                                                    ?.name,
                                                                'Event Name',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
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
                                                                stackTournamentsRow
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
                                                              dateTimeFormat(
                                                                "yMMMd",
                                                                stackTournamentsRow!
                                                                    .startDate!,
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
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
                                                      Container(
                                                        width: 160.0,
                                                        height: 100.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Builder(
                                                            builder: (context) {
                                                          final _googleMapMarker =
                                                              functions.toLatLng(
                                                                  stackTournamentsRow
                                                                      .lat!,
                                                                  stackTournamentsRow
                                                                      .lng!);
                                                          return FlutterFlowGoogleMap(
                                                            controller: _model
                                                                .googleMapsController,
                                                            onCameraIdle: (latLng) =>
                                                                safeSetState(() =>
                                                                    _model.googleMapsCenter =
                                                                        latLng),
                                                            initialLocation: _model
                                                                    .googleMapsCenter ??=
                                                                functions.toLatLng(
                                                                    stackTournamentsRow
                                                                        .lat!,
                                                                    stackTournamentsRow
                                                                        .lng!),
                                                            markers: [
                                                              FlutterFlowMarker(
                                                                _googleMapMarker
                                                                    .serialize(),
                                                                _googleMapMarker,
                                                                () async {
                                                                  logFirebaseEvent(
                                                                      'EVENT_DETAILS_GoogleMap_63157yv5_ON_MARK');
                                                                  logFirebaseEvent(
                                                                      'GoogleMap_launch_map');
                                                                  await launchMap(
                                                                    location: functions.toLatLng(
                                                                        stackTournamentsRow
                                                                            .lat!,
                                                                        stackTournamentsRow
                                                                            .lng!),
                                                                    title: '',
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                            markerColor:
                                                                GoogleMarkerColor
                                                                    .yellow,
                                                            mapType:
                                                                MapType.normal,
                                                            style:
                                                                GoogleMapStyle
                                                                    .dark,
                                                            initialZoom: 14.0,
                                                            allowInteraction:
                                                                true,
                                                            allowZoom: true,
                                                            showZoomControls:
                                                                false,
                                                            showLocation: true,
                                                            showCompass: false,
                                                            showMapToolbar:
                                                                false,
                                                            showTraffic: false,
                                                            centerMapOnMarkerTap:
                                                                true,
                                                          );
                                                        }),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 12.0,
                                                                0.0, 0.0),
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment(0.0, 0),
                                                          child: TabBar(
                                                            isScrollable: true,
                                                            tabAlignment:
                                                                TabAlignment
                                                                    .center,
                                                            labelColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            unselectedLabelColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                            labelStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .oswald(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
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
                                                                TextStyle(),
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
                                                                text:
                                                                    'My Matches',
                                                              ),
                                                              Tab(
                                                                text: 'Squad',
                                                              ),
                                                              Tab(
                                                                text:
                                                                    'Fixtures',
                                                              ),
                                                              Tab(
                                                                text:
                                                                    'Score Card',
                                                              ),
                                                              Tab(
                                                                text:
                                                                    'Highlights',
                                                              ),
                                                              Tab(
                                                                text:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  stackTournamentsRow
                                                                              .tournamentFormat ==
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
                                                                      'EVENT_DETAILS_PAGE_Tab_6p0h5z2w_ON_TAP');
                                                                  logFirebaseEvent(
                                                                      'Tab_refresh_database_request');
                                                                  safeSetState(
                                                                      () {
                                                                    _model
                                                                        .clearFixturesCache();
                                                                    _model.requestCompleted1 =
                                                                        false;
                                                                  });
                                                                  await _model
                                                                      .waitForRequestCompleted1();
                                                                },
                                                                () async {
                                                                  logFirebaseEvent(
                                                                      'EVENT_DETAILS_PAGE_Tab_r2i2q60c_ON_TAP');
                                                                  logFirebaseEvent(
                                                                      'Tab_backend_call');
                                                                  _model.teamMembers =
                                                                      await KtmTeamMembersTable()
                                                                          .queryRows(
                                                                    queryFn: (q) => q
                                                                        .eqOrNull(
                                                                          'team_id',
                                                                          eventDetailsKtmTeamsRow
                                                                              ?.teamId,
                                                                        )
                                                                        .eqOrNull(
                                                                          'tournament_id',
                                                                          widget
                                                                              .tournamentid,
                                                                        ),
                                                                  );
                                                                  logFirebaseEvent(
                                                                      'Tab_refresh_database_request');
                                                                  safeSetState(
                                                                      () {
                                                                    _model
                                                                        .clearFixturesCache();
                                                                    _model.requestCompleted1 =
                                                                        false;
                                                                  });
                                                                  await _model
                                                                      .waitForRequestCompleted1();

                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                () async {
                                                                  logFirebaseEvent(
                                                                      'EVENT_DETAILS_PAGE_Fixtures_ON_TAP');
                                                                  logFirebaseEvent(
                                                                      'Fixtures_refresh_database_request');
                                                                  safeSetState(
                                                                      () {
                                                                    _model
                                                                        .clearFixturesCache();
                                                                    _model.requestCompleted2 =
                                                                        false;
                                                                  });
                                                                  await _model
                                                                      .waitForRequestCompleted2();
                                                                },
                                                                () async {},
                                                                () async {},
                                                                () async {
                                                                  logFirebaseEvent(
                                                                      'EVENT_DETAILS_PAGE_groups_ON_TAP');
                                                                  logFirebaseEvent(
                                                                      'groups_refresh_database_request');
                                                                  safeSetState(
                                                                      () {
                                                                    _model
                                                                        .clearGroupCache();
                                                                    _model.apiRequestCompleted =
                                                                        false;
                                                                  });
                                                                  await _model
                                                                      .waitForApiRequestCompleted();
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
                                                              Visibility(
                                                                visible: stackTournamentsRow
                                                                        .status ==
                                                                    'fixture',
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          32.0,
                                                                          12.0,
                                                                          24.0),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    primary:
                                                                        false,
                                                                    child:
                                                                        Column(
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
                                                                          child:
                                                                              FutureBuilder<ApiCallResponse>(
                                                                            future:
                                                                                _model.rounds(
                                                                              requestFn: () => SupabaseKickinEventGroup.getTournamentRoundsCall.call(
                                                                                tournamentUuid: stackTournamentsRow.tournamentId,
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
                                                                              final fixturesRoundsGetTournamentRoundsResponse = snapshot.data!;

                                                                              return FlutterFlowChoiceChips(
                                                                                options: SupabaseKickinEventGroup.getTournamentRoundsCall
                                                                                    .rounds(
                                                                                      fixturesRoundsGetTournamentRoundsResponse.jsonBody,
                                                                                    )!
                                                                                    .map((label) => ChipData(label))
                                                                                    .toList(),
                                                                                onChanged: (val) => safeSetState(() => _model.fixturesRoundsValue1 = val?.firstOrNull),
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
                                                                                initialized: _model.fixturesRoundsValue1 != null,
                                                                                alignment: WrapAlignment.start,
                                                                                controller: _model.fixturesRoundsValueController1 ??= FormFieldController<List<String>>(
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
                                                                          child:
                                                                              FutureBuilder<List<KtmMatchesRow>>(
                                                                            future: _model
                                                                                .fixtures(
                                                                              requestFn: () => KtmMatchesTable().queryRows(
                                                                                queryFn: (q) => q
                                                                                    .eqOrNull(
                                                                                      'team1_id',
                                                                                      eventDetailsKtmTeamsRow?.teamId,
                                                                                    )
                                                                                    .eqOrNull(
                                                                                      'team2_id',
                                                                                      eventDetailsKtmTeamsRow?.teamId,
                                                                                    )
                                                                                    .eqOrNull(
                                                                                      'round',
                                                                                      _model.fixturesRoundsValue1,
                                                                                    )
                                                                                    .order('created_at', ascending: true),
                                                                                limit: 10,
                                                                              ),
                                                                            )
                                                                                .then((result) {
                                                                              _model.requestCompleted1 = true;
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
                                                                              List<KtmMatchesRow> fixturesKtmMatchesRowList = snapshot.data!;

                                                                              if (fixturesKtmMatchesRowList.isEmpty) {
                                                                                return Center(
                                                                                  child: EmptyWidget(
                                                                                    heading: 'My Matches',
                                                                                    text: 'All Your Matches Will Be Shown Here',
                                                                                    icon: Icon(
                                                                                      Icons.sports_soccer_outlined,
                                                                                      color: FlutterFlowTheme.of(context).accent4,
                                                                                      size: 60.0,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }

                                                                              return ListView.builder(
                                                                                padding: EdgeInsets.zero,
                                                                                shrinkWrap: true,
                                                                                scrollDirection: Axis.vertical,
                                                                                itemCount: fixturesKtmMatchesRowList.length,
                                                                                itemBuilder: (context, fixturesIndex) {
                                                                                  final fixturesKtmMatchesRow = fixturesKtmMatchesRowList[fixturesIndex];
                                                                                  return Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                        border: Border.all(
                                                                                          color: Color(0xA2FFFFFF),
                                                                                          width: 1.0,
                                                                                        ),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(12.0, 32.0, 12.0, 32.0),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                          children: [
                                                                                            if (fixturesKtmMatchesRow.status == 'completed')
                                                                                              Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  Container(
                                                                                                    width: 100.0,
                                                                                                    decoration: BoxDecoration(),
                                                                                                    child: Visibility(
                                                                                                      visible: fixturesKtmMatchesRow.winnerId == fixturesKtmMatchesRow.team1Id,
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
                                                                                                      visible: fixturesKtmMatchesRow.team1Score == fixturesKtmMatchesRow.team2Score,
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
                                                                                                      visible: fixturesKtmMatchesRow.winnerId == fixturesKtmMatchesRow.team2Id,
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
                                                                                                          fixturesKtmMatchesRow.team1Name,
                                                                                                          'NameTesting FC',
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
                                                                                                          'Team 2 If FC',
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
                                                                                          ].divide(SizedBox(height: 16.0)),
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
                                                              Padding(
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
                                                                    children: [
                                                                      if (eventDetailsKtmTeamsRow
                                                                              ?.keyMemeberId ==
                                                                          currentUserReference
                                                                              ?.id)
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            Expanded(
                                                                              child: FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  logFirebaseEvent('EVENT_DETAILS_INVITE_PLAYERS_BTN_ON_TAP');
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
                                                                                            child: InvitePlayersWidget(
                                                                                              tournamentId: stackTournamentsRow,
                                                                                              teamId: eventDetailsKtmTeamsRow!.teamId,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ).then((value) => safeSetState(() {}));
                                                                                },
                                                                                text: 'Invite Players',
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
                                                                          ].divide(SizedBox(width: 24.0)),
                                                                        ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            60.0),
                                                                        child:
                                                                            Builder(
                                                                          builder:
                                                                              (context) {
                                                                            final teams =
                                                                                (_model.teamMembers?.toList() ?? []).take(15).toList();

                                                                            return ListView.builder(
                                                                              padding: EdgeInsets.zero,
                                                                              reverse: true,
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.vertical,
                                                                              itemCount: teams.length,
                                                                              itemBuilder: (context, teamsIndex) {
                                                                                final teamsItem = teams[teamsIndex];
                                                                                return Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                                                                                  child: FutureBuilder<List<UsersRow>>(
                                                                                    future: _model.teamMemebrss(
                                                                                      requestFn: () => UsersTable().querySingleRow(
                                                                                        queryFn: (q) => q
                                                                                            .eqOrNull(
                                                                                              'user_id',
                                                                                              teamsItem.userId,
                                                                                            )
                                                                                            .order('created_at', ascending: true),
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
                                                                                      List<UsersRow> containerUsersRowList = snapshot.data!;

                                                                                      // Return an empty Container when the item does not exist.
                                                                                      if (snapshot.data!.isEmpty) {
                                                                                        return Container();
                                                                                      }
                                                                                      final containerUsersRow = containerUsersRowList.isNotEmpty ? containerUsersRowList.first : null;

                                                                                      return Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.44,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                                          border: Border.all(
                                                                                            color: FlutterFlowTheme.of(context).accent4,
                                                                                          ),
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(12.0, 24.0, 12.0, 24.0),
                                                                                          child: Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Container(
                                                                                                    width: 50.0,
                                                                                                    height: 50.0,
                                                                                                    clipBehavior: Clip.antiAlias,
                                                                                                    decoration: BoxDecoration(
                                                                                                      shape: BoxShape.circle,
                                                                                                    ),
                                                                                                    child: CachedNetworkImage(
                                                                                                      fadeInDuration: Duration(milliseconds: 500),
                                                                                                      fadeOutDuration: Duration(milliseconds: 500),
                                                                                                      imageUrl: containerUsersRow!.profilePic!,
                                                                                                      fit: BoxFit.cover,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          containerUsersRow.name,
                                                                                                          'Arpit',
                                                                                                        ),
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
                                                                                                      Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          containerUsersRow.role,
                                                                                                          'Arpit',
                                                                                                        ),
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
                                                                                                    ].divide(SizedBox(height: 4.0)),
                                                                                                  ),
                                                                                                  if (teamsItem.type == 'Captain')
                                                                                                    Icon(
                                                                                                      Icons.star,
                                                                                                      color: FlutterFlowTheme.of(context).tertiary,
                                                                                                      size: 19.0,
                                                                                                    ),
                                                                                                ].divide(SizedBox(width: 8.0)),
                                                                                              ),
                                                                                              if (teamsItem.type == 'Captain')
                                                                                                Expanded(
                                                                                                  child: FFButtonWidget(
                                                                                                    onPressed: () async {
                                                                                                      logFirebaseEvent('EVENT_DETAILS_PAGE_REMOVE_BTN_ON_TAP');
                                                                                                      logFirebaseEvent('Button_alert_dialog');
                                                                                                      var confirmDialogResponse = await showDialog<bool>(
                                                                                                            context: context,
                                                                                                            builder: (alertDialogContext) {
                                                                                                              return WebViewAware(
                                                                                                                child: AlertDialog(
                                                                                                                  title: Text('Team Removal'),
                                                                                                                  content: Text('Are you sure you want to remove ${containerUsersRow.name} ?'),
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
                                                                                                        logFirebaseEvent('Button_backend_call');
                                                                                                        await KtmTeamsTable().delete(
                                                                                                          matchingRows: (rows) => rows
                                                                                                              .eqOrNull(
                                                                                                                'tournament_id',
                                                                                                                teamsItem.tournamentId,
                                                                                                              )
                                                                                                              .eqOrNull(
                                                                                                                'team_id',
                                                                                                                teamsItem.teamId,
                                                                                                              ),
                                                                                                        );
                                                                                                      } else {
                                                                                                        logFirebaseEvent('Button_close_dialog_drawer_etc');
                                                                                                        Navigator.pop(context);
                                                                                                      }
                                                                                                    },
                                                                                                    text: 'Remove',
                                                                                                    options: FFButtonOptions(
                                                                                                      width: 81.0,
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
                                                                                            ].divide(SizedBox(width: 120.0)),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
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
                                                              Visibility(
                                                                visible: stackTournamentsRow
                                                                        .status ==
                                                                    'fixture',
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          32.0,
                                                                          12.0,
                                                                          24.0),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
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
                                                                          child:
                                                                              FutureBuilder<ApiCallResponse>(
                                                                            future:
                                                                                _model.rounds(
                                                                              requestFn: () => SupabaseKickinEventGroup.getTournamentRoundsCall.call(
                                                                                tournamentUuid: stackTournamentsRow.tournamentId,
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
                                                                              final myfixturesRoundsGetTournamentRoundsResponse = snapshot.data!;

                                                                              return FlutterFlowChoiceChips(
                                                                                options: SupabaseKickinEventGroup.getTournamentRoundsCall
                                                                                    .rounds(
                                                                                      myfixturesRoundsGetTournamentRoundsResponse.jsonBody,
                                                                                    )!
                                                                                    .map((label) => ChipData(label))
                                                                                    .toList(),
                                                                                onChanged: (val) => safeSetState(() => _model.myfixturesRoundsValue = val?.firstOrNull),
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
                                                                                initialized: _model.myfixturesRoundsValue != null,
                                                                                alignment: WrapAlignment.start,
                                                                                controller: _model.myfixturesRoundsValueController ??= FormFieldController<List<String>>(
                                                                                  [
                                                                                    SupabaseKickinEventGroup.getTournamentRoundsCall
                                                                                        .rounds(
                                                                                          myfixturesRoundsGetTournamentRoundsResponse.jsonBody,
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
                                                                                      stackTournamentsRow.tournamentId,
                                                                                    )
                                                                                    .eqOrNull(
                                                                                      'round',
                                                                                      _model.myfixturesRoundsValue,
                                                                                    )
                                                                                    .eqOrNull(
                                                                                      'status',
                                                                                      'upcoming',
                                                                                    )
                                                                                    .order('created_at'),
                                                                                limit: 15,
                                                                              ),
                                                                            )
                                                                                .then((result) {
                                                                              _model.requestCompleted2 = true;
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
                                                                              List<KtmMatchesRow> fixturesforallKtmMatchesRowList = snapshot.data!;

                                                                              if (fixturesforallKtmMatchesRowList.isEmpty) {
                                                                                return Center(
                                                                                  child: EmptyWidget(
                                                                                    heading: 'No Fixtures',
                                                                                    text: 'Switch Tabs To Refresh.',
                                                                                    icon: Icon(
                                                                                      Icons.sports_soccer_outlined,
                                                                                      color: FlutterFlowTheme.of(context).accent4,
                                                                                      size: 60.0,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }

                                                                              return ListView.builder(
                                                                                padding: EdgeInsets.zero,
                                                                                primary: false,
                                                                                shrinkWrap: true,
                                                                                scrollDirection: Axis.vertical,
                                                                                itemCount: fixturesforallKtmMatchesRowList.length,
                                                                                itemBuilder: (context, fixturesforallIndex) {
                                                                                  final fixturesforallKtmMatchesRow = fixturesforallKtmMatchesRowList[fixturesforallIndex];
                                                                                  return Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                      height: 160.0,
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
                                                                                                          fixturesforallKtmMatchesRow.team1Name,
                                                                                                          'NameTesting FC',
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
                                                                                                            fixturesforallKtmMatchesRow.team1Score?.toString(),
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
                                                                                                          fixturesforallKtmMatchesRow.team2Name,
                                                                                                          'Team 2 If FC',
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
                                                                                                            fixturesforallKtmMatchesRow.team2Score?.toString(),
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
                                                                                            if (fixturesforallKtmMatchesRow.status == 'completed')
                                                                                              Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  if (fixturesforallKtmMatchesRow.winnerId == fixturesforallKtmMatchesRow.team1Id)
                                                                                                    Container(
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
                                                                                                  if (fixturesforallKtmMatchesRow.team1Score == fixturesforallKtmMatchesRow.team2Score)
                                                                                                    Container(
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
                                                                                                  if (fixturesforallKtmMatchesRow.winnerId == fixturesforallKtmMatchesRow.team2Id)
                                                                                                    Container(
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
                                                                                                ],
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
                                                              Visibility(
                                                                visible: stackTournamentsRow
                                                                        .status ==
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
                                                                    child:
                                                                        Column(
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
                                                                          child:
                                                                              FutureBuilder<ApiCallResponse>(
                                                                            future:
                                                                                _model.rounds(
                                                                              requestFn: () => SupabaseKickinEventGroup.getTournamentRoundsCall.call(
                                                                                tournamentUuid: stackTournamentsRow.tournamentId,
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
                                                                              final fixturesRoundsGetTournamentRoundsResponse = snapshot.data!;

                                                                              return FlutterFlowChoiceChips(
                                                                                options: SupabaseKickinEventGroup.getTournamentRoundsCall
                                                                                    .rounds(
                                                                                      fixturesRoundsGetTournamentRoundsResponse.jsonBody,
                                                                                    )!
                                                                                    .map((label) => ChipData(label))
                                                                                    .toList(),
                                                                                onChanged: (val) => safeSetState(() => _model.fixturesRoundsValue2 = val?.firstOrNull),
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
                                                                                initialized: _model.fixturesRoundsValue2 != null,
                                                                                alignment: WrapAlignment.start,
                                                                                controller: _model.fixturesRoundsValueController2 ??= FormFieldController<List<String>>(
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
                                                                          child:
                                                                              FutureBuilder<List<KtmMatchesRow>>(
                                                                            future:
                                                                                _model.fixtures(
                                                                              requestFn: () => KtmMatchesTable().queryRows(
                                                                                queryFn: (q) => q
                                                                                    .eqOrNull(
                                                                                      'tournament_id',
                                                                                      stackTournamentsRow.tournamentId,
                                                                                    )
                                                                                    .eqOrNull(
                                                                                      'status',
                                                                                      'completed',
                                                                                    ),
                                                                                limit: 15,
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
                                                                              List<KtmMatchesRow> fixturesKtmMatchesRowList = snapshot.data!;

                                                                              if (fixturesKtmMatchesRowList.isEmpty) {
                                                                                return Center(
                                                                                  child: EmptyWidget(
                                                                                    heading: 'Match Result',
                                                                                    text: 'All Completed Matches Will Be Shown.',
                                                                                    icon: Icon(
                                                                                      Icons.sports_score_outlined,
                                                                                      color: FlutterFlowTheme.of(context).accent4,
                                                                                      size: 60.0,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }

                                                                              return ListView.builder(
                                                                                padding: EdgeInsets.zero,
                                                                                primary: false,
                                                                                shrinkWrap: true,
                                                                                scrollDirection: Axis.vertical,
                                                                                itemCount: fixturesKtmMatchesRowList.length,
                                                                                itemBuilder: (context, fixturesIndex) {
                                                                                  final fixturesKtmMatchesRow = fixturesKtmMatchesRowList[fixturesIndex];
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
                                                                                            if (fixturesKtmMatchesRow.status == 'completed')
                                                                                              Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  Container(
                                                                                                    width: 100.0,
                                                                                                    decoration: BoxDecoration(),
                                                                                                    child: Visibility(
                                                                                                      visible: fixturesKtmMatchesRow.winnerId == fixturesKtmMatchesRow.team1Id,
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
                                                                                                      visible: fixturesKtmMatchesRow.team1Score == fixturesKtmMatchesRow.team2Score,
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
                                                                                                      visible: fixturesKtmMatchesRow.winnerId == fixturesKtmMatchesRow.team2Id,
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
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        32.0,
                                                                        1.0,
                                                                        60.0),
                                                                child: FutureBuilder<
                                                                    List<
                                                                        TournamentMediaRow>>(
                                                                  future: _model
                                                                      .cont(
                                                                    requestFn: () =>
                                                                        TournamentMediaTable()
                                                                            .querySingleRow(
                                                                      queryFn:
                                                                          (q) =>
                                                                              q.eqOrNull(
                                                                        'tournament_id',
                                                                        stackTournamentsRow
                                                                            .tournamentId,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return Center(
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              80.0,
                                                                          height:
                                                                              80.0,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            valueColor:
                                                                                AlwaysStoppedAnimation<Color>(
                                                                              FlutterFlowTheme.of(context).primary,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    List<TournamentMediaRow>
                                                                        staggeredViewTournamentMediaRowList =
                                                                        snapshot
                                                                            .data!;

                                                                    if (staggeredViewTournamentMediaRowList
                                                                        .isEmpty) {
                                                                      return Center(
                                                                        child:
                                                                            EmptyWidget(
                                                                          heading:
                                                                              'Tournament Photos',
                                                                          text:
                                                                              'Download and  Share The Photos',
                                                                          icon:
                                                                              Icon(
                                                                            Icons.image_outlined,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).accent4,
                                                                            size:
                                                                                60.0,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    final staggeredViewTournamentMediaRow = staggeredViewTournamentMediaRowList
                                                                            .isNotEmpty
                                                                        ? staggeredViewTournamentMediaRowList
                                                                            .first
                                                                        : null;

                                                                    return Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final imageEvent = (staggeredViewTournamentMediaRow?.imageUrl.toList() ??
                                                                                [])
                                                                            .take(200)
                                                                            .toList();
                                                                        if (imageEvent
                                                                            .isEmpty) {
                                                                          return Center(
                                                                            child:
                                                                                EmptyWidget(
                                                                              heading: 'Tournament Photos',
                                                                              text: 'Download and  Share The Photos',
                                                                              icon: Icon(
                                                                                Icons.image_outlined,
                                                                                color: FlutterFlowTheme.of(context).accent4,
                                                                                size: 60.0,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }

                                                                        return MasonryGridView
                                                                            .builder(
                                                                          gridDelegate:
                                                                              SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                                                            crossAxisCount:
                                                                                2,
                                                                          ),
                                                                          crossAxisSpacing:
                                                                              16.0,
                                                                          mainAxisSpacing:
                                                                              16.0,
                                                                          itemCount:
                                                                              imageEvent.length,
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemBuilder:
                                                                              (context, imageEventIndex) {
                                                                            final imageEventItem =
                                                                                imageEvent[imageEventIndex];
                                                                            return InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                logFirebaseEvent('EVENT_DETAILS_PAGE_Image_ioj7e4o3_ON_TAP');
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
                                                                                            imagepath: imageEventItem,
                                                                                            url: imageEventItem,
                                                                                            isPlayer: true,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                ).then((value) => safeSetState(() {}));
                                                                              },
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                child: Image.network(
                                                                                  imageEventItem,
                                                                                  width: 200.0,
                                                                                  height: 200.0,
                                                                                  fit: BoxFit.cover,
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
                                                              Visibility(
                                                                visible:
                                                                    stackTournamentsRow
                                                                            .status ==
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
                                                                    child:
                                                                        Column(
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
                                                                          child:
                                                                              FutureBuilder<List<KtmGroupsRow>>(
                                                                            future:
                                                                                _model.grp(
                                                                              requestFn: () => KtmGroupsTable().queryRows(
                                                                                queryFn: (q) => q
                                                                                    .eqOrNull(
                                                                                      'tournament_id',
                                                                                      stackTournamentsRow.tournamentId,
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
                                                                              List<KtmGroupsRow> choiceChipsGroupsKtmGroupsRowList = snapshot.data!;

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
                                                                              .group(
                                                                            requestFn: () =>
                                                                                SupabaseKickinEventGroup.standingsCall.call(
                                                                              inputTournamentId: stackTournamentsRow.tournamentId,
                                                                              inputGroupId: _model.choiceChipsGroupsValue,
                                                                            ),
                                                                          )
                                                                              .then((result) {
                                                                            _model.apiRequestCompleted =
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
                                                                            final customScoreboardTableStandingsResponse =
                                                                                snapshot.data!;

                                                                            return Container(
                                                                              width: double.infinity,
                                                                              height: 500.0,
                                                                              child: custom_widgets.CustomScoreboardTable(
                                                                                width: double.infinity,
                                                                                height: 500.0,
                                                                                leftColumnWidth: 180.0,
                                                                                qualifiedCount: stackTournamentsRow.qualifiersPerGroup!,
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
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 24.0)),
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
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 8.0,
                                  borderWidth: 1.0,
                                  buttonSize: 40.0,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  icon: Icon(
                                    Icons.arrow_back_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 22.0,
                                  ),
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'EVENT_DETAILS_arrow_back_sharp_ICN_ON_TA');
                                    logFirebaseEvent(
                                        'IconButton_navigate_back');
                                    context.safePop();
                                  },
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
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                              'EVENT_DETAILS_PAGE_link_sharp_ICN_ON_TAP');
                                          logFirebaseEvent(
                                              'IconButton_copy_to_clipboard');
                                          await Clipboard.setData(ClipboardData(
                                              text: stackTournamentsRow
                                                  .tournamentLink!));
                                          logFirebaseEvent(
                                              'IconButton_show_snack_bar');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Copy to Clipboard',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          );
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
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                              'EVENT_DETAILS_home_filled_ICN_ON_TAP');
                                          logFirebaseEvent(
                                              'IconButton_navigate_to');

                                          context
                                              .pushNamed(HomeWidget.routeName);
                                        },
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 16.0)),
                                ),
                              ].divide(SizedBox(width: 16.0)),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ));
      },
    );
  }
}
