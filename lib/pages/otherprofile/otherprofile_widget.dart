import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/comment_screen_widget.dart';
import '/components/media_widget.dart';
import '/components/navbar_widget.dart';
import '/components/otherusersettings_widget.dart';
import '/components/share_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'otherprofile_model.dart';
export 'otherprofile_model.dart';

class OtherprofileWidget extends StatefulWidget {
  const OtherprofileWidget({
    super.key,
    this.id,
  });

  final String? id;

  static String routeName = 'Otherprofile';
  static String routePath = 'user';

  @override
  State<OtherprofileWidget> createState() => _OtherprofileWidgetState();
}

class _OtherprofileWidgetState extends State<OtherprofileWidget>
    with TickerProviderStateMixin {
  late OtherprofileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OtherprofileModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'Otherprofile'});
    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
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
    context.watch<FFAppState>();

    return StreamBuilder<List<UsersRecord>>(
      stream: queryUsersRecord(
        queryBuilder: (usersRecord) => usersRecord.where(
          'uid',
          isEqualTo: widget.id,
        ),
        singleRecord: true,
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
        List<UsersRecord> otherprofileUsersRecordList =
            snapshot.data!.where((u) => u.uid != currentUserUid).toList();
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final otherprofileUsersRecord = otherprofileUsersRecordList.isNotEmpty
            ? otherprofileUsersRecordList.first
            : null;

        return Title(
            title: 'profile',
            color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    alignment: AlignmentDirectional(0.0, -1.0),
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: CachedNetworkImage(
                          fadeInDuration: Duration(milliseconds: 500),
                          fadeOutDuration: Duration(milliseconds: 500),
                          imageUrl: otherprofileUsersRecord!.photoUrl,
                          width: double.infinity,
                          height: 400.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, -0.91),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 32.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: SvgPicture.network(
                                  'https://grbbdskhtdettoddpxfl.supabase.co/storage/v1/object/public/storage/assest/Kickin%20Logo.svg',
                                  width: 45.0,
                                  height: 45.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (isWeb == false)
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
                                      child: Visibility(
                                        visible: isWeb == false,
                                        child: Builder(
                                          builder: (context) =>
                                              FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 8.0,
                                            borderWidth: 1.0,
                                            buttonSize: 40.0,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            icon: Icon(
                                              Icons.ios_share,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 20.0,
                                            ),
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'OTHERPROFILE_PAGE_ios_share_ICN_ON_TAP');
                                              logFirebaseEvent(
                                                  'IconButton_share');
                                              await Share.share(
                                                'kickin://kickin.in${GoRouterState.of(context).uri.toString()}',
                                                sharePositionOrigin:
                                                    getWidgetBoundingBox(
                                                        context),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 8.0,
                                    borderWidth: 1.0,
                                    buttonSize: 40.0,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    icon: Icon(
                                      Icons.settings_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 20.0,
                                    ),
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'OTHERPROFILE_settings_outlined_ICN_ON_TA');
                                      logFirebaseEvent(
                                          'IconButton_bottom_sheet');
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return WebViewAware(
                                            child: GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child: OtherusersettingsWidget(
                                                  user:
                                                      otherprofileUsersRecord,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                            ].divide(SizedBox(width: 16.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 140.0, 0.0, 85.0),
                        child: SingleChildScrollView(
                          primary: false,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 218.0, 0.0, 0.0),
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 0.0, 12.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      valueOrDefault<String>(
                                                        otherprofileUsersRecord
                                                            .displayName,
                                                        'Name of the player could be huge',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineSmall
                                                              .override(
                                                                font:
                                                                    GoogleFonts
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
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            dateTimeFormat(
                                                              "d/M/y",
                                                              otherprofileUsersRecord
                                                                  .dateofBirth,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ),
                                                            '27/04/2005',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .poppins(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                        Text(
                                                          '|',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .poppins(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .accent4,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            otherprofileUsersRecord
                                                                .role,
                                                            'User Type',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .poppins(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 8.0)),
                                                    ),
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        logFirebaseEvent(
                                                            'OTHERPROFILE_PAGE_Row_8thrk3xp_ON_TAP');
                                                        if (otherprofileUsersRecord
                                                                .connectedList
                                                                .length >=
                                                            1) {
                                                          logFirebaseEvent(
                                                              'Row_navigate_to');

                                                          context.pushNamed(
                                                            MyNetworkWidget
                                                                .routeName,
                                                            queryParameters: {
                                                              'userId':
                                                                  serializeParam(
                                                                otherprofileUsersRecord
                                                                    .reference
                                                                    .id,
                                                                ParamType
                                                                    .String,
                                                              ),
                                                              'curentuser':
                                                                  serializeParam(
                                                                false,
                                                                ParamType.bool,
                                                              ),
                                                              'name':
                                                                  serializeParam(
                                                                otherprofileUsersRecord
                                                                    .displayName,
                                                                ParamType
                                                                    .String,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        } else {
                                                          return;
                                                        }
                                                      },
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              AuthUserStreamWidget(
                                                                builder:
                                                                    (context) =>
                                                                        Text(
                                                                  formatNumber(
                                                                    (currentUserDocument?.connectedList.toList() ??
                                                                            [])
                                                                        .length,
                                                                    formatType:
                                                                        FormatType
                                                                            .compact,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .poppins(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                              Text(
                                                                ' Connections',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .poppins(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          if (otherprofileUsersRecord
                                                                  .connectedList
                                                                  .length >=
                                                              1)
                                                            InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                logFirebaseEvent(
                                                                    'OTHERPROFILE_RichText_g8ly55ru_ON_TAP');
                                                                logFirebaseEvent(
                                                                    'RichText_navigate_to');

                                                                context
                                                                    .pushNamed(
                                                                  MyNetworkWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'userId':
                                                                        serializeParam(
                                                                      otherprofileUsersRecord
                                                                          .reference
                                                                          .id,
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                    'curentuser':
                                                                        serializeParam(
                                                                      false,
                                                                      ParamType
                                                                          .bool,
                                                                    ),
                                                                    'name':
                                                                        serializeParam(
                                                                      otherprofileUsersRecord
                                                                          .displayName,
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              },
                                                              child: RichText(
                                                                textScaler: MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          'View All',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.poppins(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).tertiary,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            decoration:
                                                                                TextDecoration.underline,
                                                                          ),
                                                                    )
                                                                  ],
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .poppins(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child:
                                                            AuthUserStreamWidget(
                                                          builder: (context) =>
                                                              Text(
                                                            valueOrDefault(
                                                                currentUserDocument
                                                                    ?.bio,
                                                                ''),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .poppins(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 8.0)),
                                                ),
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  decoration: BoxDecoration(),
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          child: Stack(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    1.0, 0.0),
                                                            children: [
                                                              if (otherprofileUsersRecord
                                                                      .requestedList
                                                                      .contains(
                                                                          currentUserReference
                                                                              ?.id) ==
                                                                  true)
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'OTHERPROFILE_PAGE_sent_ON_TAP');
                                                                    final firestoreBatch =
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .batch();
                                                                    try {
                                                                      logFirebaseEvent(
                                                                          'sent_backend_call');

                                                                      firestoreBatch
                                                                          .update(
                                                                              otherprofileUsersRecord.reference,
                                                                              {
                                                                            ...mapToFirestore(
                                                                              {
                                                                                'connectedList': FieldValue.arrayRemove([
                                                                                  currentUserReference?.id
                                                                                ]),
                                                                              },
                                                                            ),
                                                                          });
                                                                      logFirebaseEvent(
                                                                          'sent_backend_call');

                                                                      firestoreBatch
                                                                          .update(
                                                                              currentUserReference!,
                                                                              {
                                                                            ...mapToFirestore(
                                                                              {
                                                                                'connectedList': FieldValue.arrayRemove([
                                                                                  otherprofileUsersRecord.reference.id
                                                                                ]),
                                                                              },
                                                                            ),
                                                                          });
                                                                      logFirebaseEvent(
                                                                          'sent_backend_call');
                                                                      _model.apiResultmc6Copy = await SupabaseKickinEventGroup
                                                                          .deleteConnectionsCall
                                                                          .call();
                                                                    } finally {
                                                                      await firestoreBatch
                                                                          .commit();
                                                                    }

                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  text: 'Sent',
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    height:
                                                                        48.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.oswald(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Colors.white,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                ),
                                                              if ((otherprofileUsersRecord
                                                                          .connectedList
                                                                          .contains(currentUserReference
                                                                              ?.id) ==
                                                                      false) &&
                                                                  (otherprofileUsersRecord
                                                                          .requestedList
                                                                          .contains(
                                                                              currentUserReference?.id) ==
                                                                      false))
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'OTHERPROFILE_PAGE_connect_ON_TAP');
                                                                    final firestoreBatch =
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .batch();
                                                                    try {
                                                                      await Future
                                                                          .wait([
                                                                        Future(
                                                                            () async {
                                                                          logFirebaseEvent(
                                                                              'connect_backend_call');

                                                                          firestoreBatch.update(
                                                                              currentUserReference!,
                                                                              {
                                                                                ...mapToFirestore(
                                                                                  {
                                                                                    'requestedList': FieldValue.arrayUnion([
                                                                                      otherprofileUsersRecord.reference.id
                                                                                    ]),
                                                                                  },
                                                                                ),
                                                                              });
                                                                        }),
                                                                        Future(
                                                                            () async {
                                                                          logFirebaseEvent(
                                                                              'connect_backend_call');

                                                                          firestoreBatch.update(
                                                                              otherprofileUsersRecord.reference,
                                                                              {
                                                                                ...mapToFirestore(
                                                                                  {
                                                                                    'requestedList': FieldValue.arrayUnion([
                                                                                      currentUserReference?.id
                                                                                    ]),
                                                                                  },
                                                                                ),
                                                                              });
                                                                        }),
                                                                      ]);
                                                                      logFirebaseEvent(
                                                                          'connect_backend_call');
                                                                      _model.request =
                                                                          await ConnectionsTable()
                                                                              .insert({
                                                                        'from_user_id':
                                                                            currentUserUid,
                                                                        'to_user_id':
                                                                            otherprofileUsersRecord.uid,
                                                                        'status': Status
                                                                            .sent
                                                                            .name,
                                                                        'created_at':
                                                                            supaSerialize<DateTime>(getCurrentTimestamp),
                                                                      });
                                                                      logFirebaseEvent(
                                                                          'connect_backend_call');
                                                                      await NotificationsTable()
                                                                          .insert({
                                                                        'receiver_id':
                                                                            otherprofileUsersRecord.uid,
                                                                        'sender_id':
                                                                            currentUserUid,
                                                                        'type': NotificationType
                                                                            .Request
                                                                            .name,
                                                                        'message':
                                                                            '${FFAppState().name} is trying to connect with you',
                                                                        'is_read':
                                                                            false,
                                                                        'created_at':
                                                                            supaSerialize<DateTime>(getCurrentTimestamp),
                                                                      });
                                                                      logFirebaseEvent(
                                                                          'connect_trigger_push_notification');
                                                                      triggerPushNotification(
                                                                        notificationTitle:
                                                                            otherprofileUsersRecord.displayName,
                                                                        notificationText:
                                                                            ' accepted your connection request',
                                                                        notificationImageUrl:
                                                                            otherprofileUsersRecord.photoUrl,
                                                                        notificationSound:
                                                                            'default',
                                                                        userRefs: [
                                                                          otherprofileUsersRecord
                                                                              .reference
                                                                        ],
                                                                        initialPageName:
                                                                            'Otherprofile',
                                                                        parameterData: {
                                                                          'id': otherprofileUsersRecord
                                                                              .reference
                                                                              .id,
                                                                        },
                                                                      );
                                                                    } finally {
                                                                      await firestoreBatch
                                                                          .commit();
                                                                    }

                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  text:
                                                                      'Connect',
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    height:
                                                                        48.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            16.0,
                                                                            16.0,
                                                                            16.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.oswald(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                ),
                                                              if (otherprofileUsersRecord
                                                                      .connectedList
                                                                      .contains(
                                                                          currentUserReference
                                                                              ?.id) ==
                                                                  true)
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child:
                                                                      FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      logFirebaseEvent(
                                                                          'OTHERPROFILE_PAGE_connected_ON_TAP');
                                                                      final firestoreBatch = FirebaseFirestore
                                                                          .instance
                                                                          .batch();
                                                                      try {
                                                                        logFirebaseEvent(
                                                                            'connected_alert_dialog');
                                                                        var confirmDialogResponse = await showDialog<bool>(
                                                                              context: context,
                                                                              builder: (alertDialogContext) {
                                                                                return WebViewAware(
                                                                                  child: AlertDialog(
                                                                                    title: Text('Remove ${otherprofileUsersRecord.displayName}?'),
                                                                                    content: Text('Are you sure?'),
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
                                                                          logFirebaseEvent(
                                                                              'connected_backend_call');

                                                                          firestoreBatch.update(
                                                                              otherprofileUsersRecord.reference,
                                                                              {
                                                                                ...mapToFirestore(
                                                                                  {
                                                                                    'connectedList': FieldValue.arrayRemove([
                                                                                      currentUserReference?.id
                                                                                    ]),
                                                                                  },
                                                                                ),
                                                                              });
                                                                          logFirebaseEvent(
                                                                              'connected_backend_call');

                                                                          firestoreBatch.update(
                                                                              currentUserReference!,
                                                                              {
                                                                                ...mapToFirestore(
                                                                                  {
                                                                                    'connectedList': FieldValue.arrayRemove([
                                                                                      otherprofileUsersRecord.reference.id
                                                                                    ]),
                                                                                  },
                                                                                ),
                                                                              });
                                                                          logFirebaseEvent(
                                                                              'connected_backend_call');
                                                                          _model.apiResultmc6 = await SupabaseKickinEventGroup
                                                                              .deleteConnectionsCall
                                                                              .call();
                                                                        } else {
                                                                          logFirebaseEvent(
                                                                              'connected_close_dialog_drawer_etc');
                                                                          Navigator.pop(
                                                                              context);
                                                                        }
                                                                      } finally {
                                                                        await firestoreBatch
                                                                            .commit();
                                                                      }

                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    text:
                                                                        'Connected',
                                                                    options:
                                                                        FFButtonOptions(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.45,
                                                                      height:
                                                                          48.0,
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.oswald(
                                                                              fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Colors.white,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                      elevation:
                                                                          0.0,
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      if (otherprofileUsersRecord
                                                              .connectedList
                                                              .contains(
                                                                  currentUserReference
                                                                      ?.id) ==
                                                          true)
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  1.0, 0.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              logFirebaseEvent(
                                                                  'OTHERPROFILE_PAGE_message_ON_TAP');
                                                              logFirebaseEvent(
                                                                  'message_navigate_to');

                                                              context.pushNamed(
                                                                ChatMessageWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'userId':
                                                                      serializeParam(
                                                                    otherprofileUsersRecord
                                                                        .reference,
                                                                    ParamType
                                                                        .DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            text: 'Message',
                                                            options:
                                                                FFButtonOptions(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.45,
                                                              height: 48.0,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          32.0,
                                                                          0.0,
                                                                          32.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
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
                                                                        color: Colors
                                                                            .white,
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
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 16.0)),
                                            ),
                                          ),
                                          if (otherprofileUsersRecord
                                                  .connectedList
                                                  .contains(
                                                      currentUserReference
                                                          ?.id) ==
                                              true)
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (!((otherprofileUsersRecord
                                                            .role ==
                                                        'Player') ||
                                                    (otherprofileUsersRecord
                                                            .role ==
                                                        'Coach') ||
                                                    (otherprofileUsersRecord
                                                            .role ==
                                                        'Agent')))
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                12.0, 0.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          1.0,
                                                      height: 56.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent4,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    12.0,
                                                                    0.0,
                                                                    12.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Location',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .poppins(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                otherprofileUsersRecord
                                                                    .locations
                                                                    .firstOrNull,
                                                                'Location',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .poppins(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ].divide(SizedBox(height: 16.0)),
                                            ),
                                          if (otherprofileUsersRecord
                                                  .connectedList
                                                  .contains(
                                                      currentUserReference
                                                          ?.id) ==
                                              true)
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, 1.0),
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 1.0),
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  12.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Column(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                Alignment(
                                                                    -1.0, 0),
                                                            child: TabBar(
                                                              isScrollable:
                                                                  true,
                                                              tabAlignment:
                                                                  TabAlignment
                                                                      .start,
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
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                              unselectedLabelStyle:
                                                                  TextStyle(),
                                                              indicatorColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiary,
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          0.0,
                                                                          12.0,
                                                                          0.0),
                                                              tabs: [
                                                                Tab(
                                                                  text: (otherprofileUsersRecord.role == 'Player') ||
                                                                          (otherprofileUsersRecord.role ==
                                                                              'Coach') ||
                                                                          (otherprofileUsersRecord.role ==
                                                                              'Agent')
                                                                      ? 'Experience'
                                                                      : 'Location',
                                                                ),
                                                                Tab(
                                                                  text:
                                                                      'Achievements',
                                                                ),
                                                                Tab(
                                                                  text: 'Posts',
                                                                ),
                                                              ],
                                                              controller: _model
                                                                  .tabBarController,
                                                              onTap: (i) async {
                                                                [
                                                                  () async {},
                                                                  () async {
                                                                    logFirebaseEvent(
                                                                        'OTHERPROFILE_PAGE_Tab_j0cwm8dt_ON_TAP');
                                                                    logFirebaseEvent(
                                                                        'Tab_refresh_database_request');
                                                                    safeSetState(() =>
                                                                        _model.requestCompleter =
                                                                            null);
                                                                    await _model
                                                                        .waitForRequestCompleted();
                                                                  },
                                                                  () async {}
                                                                ][i]();
                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: TabBarView(
                                                              controller: _model
                                                                  .tabBarController,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    if ((otherprofileUsersRecord.role == UserType.Player.name) ||
                                                                        (otherprofileUsersRecord.role ==
                                                                            UserType
                                                                                .Coach.name) ||
                                                                        (otherprofileUsersRecord.role ==
                                                                            UserType.Agent.name))
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            12.0,
                                                                            24.0,
                                                                            12.0,
                                                                            0.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 24.0),
                                                                              child: StreamBuilder<List<UserExperienceRow>>(
                                                                                stream: _model.lcation(
                                                                                  requestFn: () => _model.listViewSupabaseStream ??= SupaFlow.client
                                                                                      .from("user_experience")
                                                                                      .stream(primaryKey: ['id'])
                                                                                      .eqOrNull(
                                                                                        'user_id',
                                                                                        otherprofileUsersRecord.uid,
                                                                                      )
                                                                                      .order('created_at', ascending: true)
                                                                                      .limit(20)
                                                                                      .map((list) => list.map((item) => UserExperienceRow(item)).toList()),
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
                                                                                  List<UserExperienceRow> listViewUserExperienceRowList = snapshot.data!;

                                                                                  return ListView.builder(
                                                                                    padding: EdgeInsets.zero,
                                                                                    shrinkWrap: true,
                                                                                    scrollDirection: Axis.vertical,
                                                                                    itemCount: listViewUserExperienceRowList.length,
                                                                                    itemBuilder: (context, listViewIndex) {
                                                                                      final listViewUserExperienceRow = listViewUserExperienceRowList[listViewIndex];
                                                                                      return Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                                                                        child: Container(
                                                                                          width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                          height: 100.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            borderRadius: BorderRadius.circular(8.0),
                                                                                            border: Border.all(
                                                                                              color: Color(0xA2FFFFFF),
                                                                                              width: 1.0,
                                                                                            ),
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 12.0, 16.0),
                                                                                            child: Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: [
                                                                                                Container(
                                                                                                  width: 4.0,
                                                                                                  height: double.infinity,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).tertiary,
                                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                                                    child: Column(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          valueOrDefault<String>(
                                                                                                            listViewUserExperienceRow.teamName,
                                                                                                            'Team Name',
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                                font: GoogleFonts.oswald(
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                                ),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                        if (otherprofileUsersRecord.role == 'Player')
                                                                                                          Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                                            child: Text(
                                                                                                              valueOrDefault<String>(
                                                                                                                listViewUserExperienceRow.position,
                                                                                                                'GoalKeeper',
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                                    font: GoogleFonts.oswald(
                                                                                                                      fontWeight: FontWeight.w300,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                                    ),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w300,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                                                  child: Column(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        valueOrDefault<String>(
                                                                                                          listViewUserExperienceRow.startYear,
                                                                                                          '2023',
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                              font: GoogleFonts.oswald(
                                                                                                                fontWeight: FontWeight.w300,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                              ),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w300,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
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
                                                                    if ((otherprofileUsersRecord.role == UserType.Club.name) ||
                                                                        (otherprofileUsersRecord.role ==
                                                                            UserType
                                                                                .Academy.name) ||
                                                                        (otherprofileUsersRecord.role ==
                                                                            UserType.Agency.name))
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            12.0,
                                                                            24.0,
                                                                            12.0,
                                                                            0.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 24.0),
                                                                              child: Builder(
                                                                                builder: (context) {
                                                                                  final location = (otherprofileUsersRecord.locations.toList() ?? []).take(12).toList();

                                                                                  return ListView.builder(
                                                                                    padding: EdgeInsets.zero,
                                                                                    shrinkWrap: true,
                                                                                    scrollDirection: Axis.vertical,
                                                                                    itemCount: location.length,
                                                                                    itemBuilder: (context, locationIndex) {
                                                                                      final locationItem = location[locationIndex];
                                                                                      return Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                                                                        child: Container(
                                                                                          width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                          height: 80.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            borderRadius: BorderRadius.circular(8.0),
                                                                                            border: Border.all(
                                                                                              color: Color(0xA2FFFFFF),
                                                                                              width: 1.0,
                                                                                            ),
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 12.0, 16.0),
                                                                                            child: Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: [
                                                                                                Container(
                                                                                                  width: 4.0,
                                                                                                  height: double.infinity,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).tertiary,
                                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                                                    child: Column(
                                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          locationItem,
                                                                                                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                                font: GoogleFonts.oswald(
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                                ),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
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
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          24.0,
                                                                          12.0,
                                                                          24.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      FutureBuilder<
                                                                          List<
                                                                              AchievementsRow>>(
                                                                        future: (_model.requestCompleter ??= Completer<List<AchievementsRow>>()
                                                                              ..complete(AchievementsTable().queryRows(
                                                                                queryFn: (q) => q
                                                                                    .eqOrNull(
                                                                                      'user_id',
                                                                                      otherprofileUsersRecord.reference.id,
                                                                                    )
                                                                                    .order('created_at'),
                                                                              )))
                                                                            .future,
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
                                                                          List<AchievementsRow>
                                                                              achievemtnsAchievementsRowList =
                                                                              snapshot.data!;

                                                                          return ListView
                                                                              .separated(
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            shrinkWrap:
                                                                                true,
                                                                            scrollDirection:
                                                                                Axis.vertical,
                                                                            itemCount:
                                                                                achievemtnsAchievementsRowList.length,
                                                                            separatorBuilder: (_, __) =>
                                                                                SizedBox(height: 16.0),
                                                                            itemBuilder:
                                                                                (context, achievemtnsIndex) {
                                                                              final achievemtnsAchievementsRow = achievemtnsAchievementsRowList[achievemtnsIndex];
                                                                              return Container(
                                                                                width: MediaQuery.sizeOf(context).width * 1.0,
                                                                                height: 100.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                  border: Border.all(
                                                                                    color: Color(0xA2FFFFFF),
                                                                                    width: 1.0,
                                                                                  ),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 12.0, 16.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 4.0,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).tertiary,
                                                                                          borderRadius: BorderRadius.circular(4.0),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Text(
                                                                                                valueOrDefault<String>(
                                                                                                  achievemtnsAchievementsRow.title,
                                                                                                  'title',
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                      font: GoogleFonts.oswald(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                      ),
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  valueOrDefault<String>(
                                                                                                    achievemtnsAchievementsRow.content,
                                                                                                    'content',
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                        font: GoogleFonts.oswald(
                                                                                                          fontWeight: FontWeight.w300,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                        ),
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w300,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                                                          children: [
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                                                                                              child: Text(
                                                                                                dateTimeFormat(
                                                                                                  "relative",
                                                                                                  achievemtnsAchievementsRow.createdAt,
                                                                                                  locale: FFLocalizations.of(context).languageShortCode ?? FFLocalizations.of(context).languageCode,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                      font: GoogleFonts.oswald(
                                                                                                        fontWeight: FontWeight.w300,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                      ),
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w300,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                PagedListView<
                                                                    DocumentSnapshot<
                                                                        Object?>?,
                                                                    PostsRecord>.separated(
                                                                  pagingController:
                                                                      _model
                                                                          .setPostsController(
                                                                    PostsRecord
                                                                        .collection
                                                                        .where(
                                                                          'user_post',
                                                                          isEqualTo: otherprofileUsersRecord
                                                                              .reference
                                                                              .id,
                                                                        )
                                                                        .orderBy(
                                                                            'time_posted',
                                                                            descending:
                                                                                true),
                                                                  ),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  primary:
                                                                      false,
                                                                  shrinkWrap:
                                                                      true,
                                                                  reverse:
                                                                      false,
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  separatorBuilder: (_,
                                                                          __) =>
                                                                      SizedBox(
                                                                          height:
                                                                              8.0),
                                                                  builderDelegate:
                                                                      PagedChildBuilderDelegate<
                                                                          PostsRecord>(
                                                                    // Customize what your widget looks like when it's loading the first page.
                                                                    firstPageProgressIndicatorBuilder:
                                                                        (_) =>
                                                                            Center(
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
                                                                    ),
                                                                    // Customize what your widget looks like when it's loading another page.
                                                                    newPageProgressIndicatorBuilder:
                                                                        (_) =>
                                                                            Center(
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
                                                                    ),

                                                                    itemBuilder:
                                                                        (context,
                                                                            _,
                                                                            postsIndex) {
                                                                      final postsPostsRecord = _model
                                                                          .postsPagingController!
                                                                          .itemList![postsIndex];
                                                                      return Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            24.0),
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              ListView(
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            primary:
                                                                                false,
                                                                            shrinkWrap:
                                                                                true,
                                                                            scrollDirection:
                                                                                Axis.vertical,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 16.0, 8.0, 12.0),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    StreamBuilder<List<UsersRecord>>(
                                                                                      stream: queryUsersRecord(
                                                                                        queryBuilder: (usersRecord) => usersRecord.where(
                                                                                          'uid',
                                                                                          isEqualTo: postsPostsRecord.userPost,
                                                                                        ),
                                                                                        singleRecord: true,
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
                                                                                        List<UsersRecord> rowUsersRecordList = snapshot.data!;
                                                                                        final rowUsersRecord = rowUsersRecordList.isNotEmpty ? rowUsersRecordList.first : null;

                                                                                        return InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            logFirebaseEvent('OTHERPROFILE_PAGE_Row_jb1jh1ui_ON_TAP');
                                                                                            if (postsPostsRecord.userPost == currentUserReference?.id) {
                                                                                              logFirebaseEvent('Row_navigate_to');

                                                                                              context.pushNamed(ProfileWidget.routeName);
                                                                                            } else {
                                                                                              logFirebaseEvent('Row_navigate_to');

                                                                                              context.pushNamed(
                                                                                                OtherprofileWidget.routeName,
                                                                                                queryParameters: {
                                                                                                  'id': serializeParam(
                                                                                                    rowUsersRecord.reference.id,
                                                                                                    ParamType.String,
                                                                                                  ),
                                                                                                }.withoutNulls,
                                                                                              );
                                                                                            }
                                                                                          },
                                                                                          child: Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: 45.0,
                                                                                                height: 45.0,
                                                                                                clipBehavior: Clip.antiAlias,
                                                                                                decoration: BoxDecoration(
                                                                                                  shape: BoxShape.circle,
                                                                                                ),
                                                                                                child: CachedNetworkImage(
                                                                                                  fadeInDuration: Duration(milliseconds: 500),
                                                                                                  fadeOutDuration: Duration(milliseconds: 500),
                                                                                                  imageUrl: rowUsersRecord!.photoUrl,
                                                                                                  fit: BoxFit.cover,
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                valueOrDefault<String>(
                                                                                                  rowUsersRecord.displayName,
                                                                                                  'Display name of the user',
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
                                                                                            ].divide(SizedBox(width: 4.0)),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                                                                                      child: Text(
                                                                                        dateTimeFormat(
                                                                                          "relative",
                                                                                          postsPostsRecord.timePosted!,
                                                                                          locale: FFLocalizations.of(context).languageShortCode ?? FFLocalizations.of(context).languageCode,
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                              font: GoogleFonts.poppins(
                                                                                                fontWeight: FontWeight.w500,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                              ),
                                                                                              color: Color(0xFFB2B2B2),
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(SizedBox(width: 8.0)),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 12.0, 18.0),
                                                                                child: Text(
                                                                                  postsPostsRecord.postDescription,
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
                                                                              if (postsPostsRecord.postType != 'post')
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 16.0),
                                                                                  child: Stack(
                                                                                    children: [
                                                                                      if ((postsPostsRecord.postType == 'image') || (postsPostsRecord.postType == 'shot'))
                                                                                        InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            logFirebaseEvent('OTHERPROFILE_Container_olj423bs_ON_TAP');
                                                                                            if (postsPostsRecord.isShot == true) {
                                                                                              logFirebaseEvent('media_navigate_to');

                                                                                              context.pushNamed(
                                                                                                KickinShotWidget.routeName,
                                                                                                queryParameters: {
                                                                                                  'postID': serializeParam(
                                                                                                    postsPostsRecord.reference,
                                                                                                    ParamType.DocumentReference,
                                                                                                  ),
                                                                                                }.withoutNulls,
                                                                                              );
                                                                                            } else {
                                                                                              logFirebaseEvent('media_navigate_to');

                                                                                              context.pushNamed(
                                                                                                IndiviualPostWidget.routeName,
                                                                                                queryParameters: {
                                                                                                  'postId': serializeParam(
                                                                                                    postsPostsRecord.reference.id,
                                                                                                    ParamType.String,
                                                                                                  ),
                                                                                                }.withoutNulls,
                                                                                              );
                                                                                            }
                                                                                          },
                                                                                          onDoubleTap: () async {
                                                                                            logFirebaseEvent('OTHERPROFILE_Container_olj423bs_ON_DOUBL');
                                                                                            var _shouldSetState = false;
                                                                                            logFirebaseEvent('media_backend_call');

                                                                                            await postsPostsRecord.reference.update({
                                                                                              ...mapToFirestore(
                                                                                                {
                                                                                                  'likes': FieldValue.arrayUnion([
                                                                                                    currentUserReference
                                                                                                  ]),
                                                                                                },
                                                                                              ),
                                                                                            });
                                                                                            if (postsPostsRecord.userPost == currentUserReference?.id) {
                                                                                              if (_shouldSetState) safeSetState(() {});
                                                                                              return;
                                                                                            }

                                                                                            logFirebaseEvent('media_backend_call');
                                                                                            await NotificationsTable().insert({
                                                                                              'receiver_id': postsPostsRecord.userPost,
                                                                                              'sender_id': currentUserReference?.id,
                                                                                              'type': NotificationType.Like.name,
                                                                                              'message': '${currentUserDisplayName} liked your Post.',
                                                                                              'is_read': false,
                                                                                              'created_at': supaSerialize<DateTime>(getCurrentTimestamp),
                                                                                              'post_id': postsPostsRecord.reference.id,
                                                                                            });
                                                                                            logFirebaseEvent('media_custom_action');
                                                                                            _model.userPost = await actions.getDocumentRefFromCollection(
                                                                                              'users',
                                                                                              postsPostsRecord.userPost,
                                                                                            );
                                                                                            _shouldSetState = true;
                                                                                            logFirebaseEvent('media_trigger_push_notification');
                                                                                            triggerPushNotification(
                                                                                              notificationTitle: currentUserDisplayName,
                                                                                              notificationText: 'Liked Your Post.',
                                                                                              notificationSound: 'default',
                                                                                              userRefs: [
                                                                                                _model.userPost!
                                                                                              ],
                                                                                              initialPageName: 'indiviual_post',
                                                                                              parameterData: {
                                                                                                'postId': postsPostsRecord.reference.id,
                                                                                              },
                                                                                            );
                                                                                            if (_shouldSetState) safeSetState(() {});
                                                                                          },
                                                                                          child: wrapWithModel(
                                                                                            model: _model.mediaModels.getModel(
                                                                                              postsPostsRecord.reference.id,
                                                                                              postsIndex,
                                                                                            ),
                                                                                            updateCallback: () => safeSetState(() {}),
                                                                                            child: MediaWidget(
                                                                                              key: Key(
                                                                                                'Keyolj_${postsPostsRecord.reference.id}',
                                                                                              ),
                                                                                              media: postsPostsRecord.mediauUrl,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      if (postsPostsRecord.postType == 'event')
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                                                                          child: Container(
                                                                                            width: double.infinity,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: [
                                                                                                Container(
                                                                                                  width: double.infinity,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                    borderRadius: BorderRadius.only(
                                                                                                      bottomLeft: Radius.circular(0.0),
                                                                                                      bottomRight: Radius.circular(0.0),
                                                                                                      topLeft: Radius.circular(8.0),
                                                                                                      topRight: Radius.circular(8.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                  child: ClipRRect(
                                                                                                    borderRadius: BorderRadius.only(
                                                                                                      bottomLeft: Radius.circular(0.0),
                                                                                                      bottomRight: Radius.circular(0.0),
                                                                                                      topLeft: Radius.circular(8.0),
                                                                                                      topRight: Radius.circular(8.0),
                                                                                                    ),
                                                                                                    child: Image.network(
                                                                                                      postsPostsRecord.eventDetails.imageUrl,
                                                                                                      width: 87.7,
                                                                                                      height: 200.0,
                                                                                                      fit: BoxFit.contain,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Container(
                                                                                                  width: double.infinity,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                    borderRadius: BorderRadius.only(
                                                                                                      bottomLeft: Radius.circular(8.0),
                                                                                                      bottomRight: Radius.circular(8.0),
                                                                                                      topLeft: Radius.circular(0.0),
                                                                                                      topRight: Radius.circular(0.0),
                                                                                                    ),
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
                                                                                                    child: Column(
                                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      children: [
                                                                                                        Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              postsPostsRecord.eventDetails.eventName,
                                                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                                    font: GoogleFonts.oswald(
                                                                                                                      fontWeight: FontWeight.normal,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                                    ),
                                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                postsPostsRecord.eventDetails.description,
                                                                                                                textAlign: TextAlign.start,
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.poppins(
                                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      color: FlutterFlowTheme.of(context).accent4,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                                              child: Row(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                children: [
                                                                                                                  Text(
                                                                                                                    postsPostsRecord.eventDetails.date,
                                                                                                                    textAlign: TextAlign.center,
                                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                          font: GoogleFonts.poppins(
                                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                          color: FlutterFlowTheme.of(context).accent4,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                  SizedBox(
                                                                                                                    height: 25.0,
                                                                                                                    child: VerticalDivider(
                                                                                                                      thickness: 1.0,
                                                                                                                      color: FlutterFlowTheme.of(context).accent4,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  Text(
                                                                                                                    postsPostsRecord.eventDetails.time,
                                                                                                                    textAlign: TextAlign.center,
                                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                          font: GoogleFonts.poppins(
                                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                          color: FlutterFlowTheme.of(context).accent4,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                            Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                                                                              child: Builder(
                                                                                                                builder: (context) {
                                                                                                                  final auidence = postsPostsRecord.eventDetails.audience.toList().take(7).toList();

                                                                                                                  return Wrap(
                                                                                                                    spacing: 16.0,
                                                                                                                    runSpacing: 12.0,
                                                                                                                    alignment: WrapAlignment.start,
                                                                                                                    crossAxisAlignment: WrapCrossAlignment.start,
                                                                                                                    direction: Axis.horizontal,
                                                                                                                    runAlignment: WrapAlignment.start,
                                                                                                                    verticalDirection: VerticalDirection.down,
                                                                                                                    clipBehavior: Clip.none,
                                                                                                                    children: List.generate(auidence.length, (auidenceIndex) {
                                                                                                                      final auidenceItem = auidence[auidenceIndex];
                                                                                                                      return Container(
                                                                                                                        decoration: BoxDecoration(
                                                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                                          borderRadius: BorderRadius.circular(24.0),
                                                                                                                          border: Border.all(
                                                                                                                            color: FlutterFlowTheme.of(context).accent4,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        child: Padding(
                                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 10.0, 24.0, 10.0),
                                                                                                                          child: Text(
                                                                                                                            valueOrDefault<String>(
                                                                                                                              auidenceItem,
                                                                                                                              'Player',
                                                                                                                            ),
                                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                                  font: GoogleFonts.poppins(
                                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                  ),
                                                                                                                                  color: FlutterFlowTheme.of(context).accent4,
                                                                                                                                  fontSize: 14.0,
                                                                                                                                  letterSpacing: 0.0,
                                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                                ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      );
                                                                                                                    }),
                                                                                                                  );
                                                                                                                },
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ].divide(SizedBox(height: 16.0)),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 6.0, 8.0, 0.0),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Stack(
                                                                                          children: [
                                                                                            if (postsPostsRecord.likes.contains(currentUserReference) == false)
                                                                                              InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  logFirebaseEvent('OTHERPROFILE_PAGE_Icon_rbv5rfua_ON_TAP');
                                                                                                  var _shouldSetState = false;
                                                                                                  logFirebaseEvent('Icon_haptic_feedback');
                                                                                                  HapticFeedback.heavyImpact();
                                                                                                  logFirebaseEvent('Icon_backend_call');

                                                                                                  await postsPostsRecord.reference.update({
                                                                                                    ...mapToFirestore(
                                                                                                      {
                                                                                                        'likes': FieldValue.arrayUnion([currentUserReference]),
                                                                                                      },
                                                                                                    ),
                                                                                                  });
                                                                                                  if (postsPostsRecord.userPost == currentUserReference?.id) {
                                                                                                    if (_shouldSetState) safeSetState(() {});
                                                                                                    return;
                                                                                                  }

                                                                                                  logFirebaseEvent('Icon_backend_call');
                                                                                                  await NotificationsTable().insert({
                                                                                                    'receiver_id': postsPostsRecord.userPost,
                                                                                                    'sender_id': currentUserUid,
                                                                                                    'type': NotificationType.Like.name,
                                                                                                    'message': '${FFAppState().name} Liked Your Post',
                                                                                                    'is_read': false,
                                                                                                    'created_at': supaSerialize<DateTime>(getCurrentTimestamp),
                                                                                                    'post_id': postsPostsRecord.reference.id,
                                                                                                  });
                                                                                                  logFirebaseEvent('Icon_custom_action');
                                                                                                  _model.userPo = await actions.getDocumentRefFromCollection(
                                                                                                    'users',
                                                                                                    postsPostsRecord.userPost,
                                                                                                  );
                                                                                                  _shouldSetState = true;
                                                                                                  logFirebaseEvent('Icon_trigger_push_notification');
                                                                                                  triggerPushNotification(
                                                                                                    notificationTitle: currentUserDisplayName,
                                                                                                    notificationText: 'liked Your Post.',
                                                                                                    notificationSound: 'default',
                                                                                                    userRefs: [_model.userPo!],
                                                                                                    initialPageName: 'indiviual_post',
                                                                                                    parameterData: {
                                                                                                      'postId': postsPostsRecord.reference.id,
                                                                                                    },
                                                                                                  );
                                                                                                  if (_shouldSetState) safeSetState(() {});
                                                                                                },
                                                                                                child: Icon(
                                                                                                  Icons.favorite_border,
                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                  size: 30.0,
                                                                                                ),
                                                                                              ),
                                                                                            if (postsPostsRecord.likes.contains(currentUserReference) == true)
                                                                                              InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  logFirebaseEvent('OTHERPROFILE_PAGE_Icon_38wbf7n7_ON_TAP');
                                                                                                  logFirebaseEvent('Icon_backend_call');

                                                                                                  await postsPostsRecord.reference.update({
                                                                                                    ...mapToFirestore(
                                                                                                      {
                                                                                                        'likes': FieldValue.arrayRemove([currentUserReference]),
                                                                                                      },
                                                                                                    ),
                                                                                                  });
                                                                                                },
                                                                                                child: Icon(
                                                                                                  Icons.favorite_sharp,
                                                                                                  color: Color(0xFFFF1726),
                                                                                                  size: 30.0,
                                                                                                ),
                                                                                              ),
                                                                                          ],
                                                                                        ),
                                                                                        Text(
                                                                                          formatNumber(
                                                                                            postsPostsRecord.likes.length,
                                                                                            formatType: FormatType.compact,
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
                                                                                        InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            logFirebaseEvent('OTHERPROFILE_PAGE_comment_ON_TAP');
                                                                                            logFirebaseEvent('comment_custom_action');
                                                                                            _model.use = await actions.getDocumentRefFromCollection(
                                                                                              'users',
                                                                                              postsPostsRecord.userPost,
                                                                                            );
                                                                                            logFirebaseEvent('comment_bottom_sheet');
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
                                                                                                      child: Container(
                                                                                                        height: MediaQuery.sizeOf(context).height * 0.8,
                                                                                                        child: CommentScreenWidget(
                                                                                                          postId: postsPostsRecord,
                                                                                                          creator: _model.use!,
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            ).then((value) => safeSetState(() {}));

                                                                                            safeSetState(() {});
                                                                                          },
                                                                                          child: ClipRRect(
                                                                                            borderRadius: BorderRadius.circular(8.0),
                                                                                            child: SvgPicture.asset(
                                                                                              'assets/images/Comment.svg',
                                                                                              width: 25.0,
                                                                                              height: 25.0,
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            logFirebaseEvent('OTHERPROFILE_PAGE_shares_ON_TAP');
                                                                                            logFirebaseEvent('shares_bottom_sheet');
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
                                                                                                      child: ShareWidget(
                                                                                                        link: 'https://kickin.in/indiviualPost?postId=${postsPostsRecord.reference.id}',
                                                                                                        postId: postsPostsRecord,
                                                                                                        isTournament: false,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                            ).then((value) => safeSetState(() {}));
                                                                                          },
                                                                                          child: ClipRRect(
                                                                                            borderRadius: BorderRadius.circular(8.0),
                                                                                            child: SvgPicture.asset(
                                                                                              'assets/images/send_white.svg',
                                                                                              width: 26.0,
                                                                                              height: 25.0,
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ].divide(SizedBox(width: 8.0)),
                                                                                    ),
                                                                                  ].divide(SizedBox(width: 4.0)),
                                                                                ),
                                                                              ),
                                                                              if (postsPostsRecord.numComments >= 1)
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 0.0),
                                                                                  child: StreamBuilder<List<CommentsRecord>>(
                                                                                    stream: queryCommentsRecord(
                                                                                      parent: postsPostsRecord.reference,
                                                                                      queryBuilder: (commentsRecord) => commentsRecord
                                                                                          .where(
                                                                                            'post_id',
                                                                                            isEqualTo: postsPostsRecord.reference,
                                                                                          )
                                                                                          .orderBy('created_time', descending: true),
                                                                                      singleRecord: true,
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
                                                                                      List<CommentsRecord> listViewCommentsRecordList = snapshot.data!;
                                                                                      // Return an empty Container when the item does not exist.
                                                                                      if (snapshot.data!.isEmpty) {
                                                                                        return Container();
                                                                                      }
                                                                                      final listViewCommentsRecord = listViewCommentsRecordList.isNotEmpty ? listViewCommentsRecordList.first : null;

                                                                                      return ListView(
                                                                                        padding: EdgeInsets.zero,
                                                                                        primary: false,
                                                                                        shrinkWrap: true,
                                                                                        scrollDirection: Axis.vertical,
                                                                                        children: [
                                                                                          StreamBuilder<List<UsersRecord>>(
                                                                                            stream: _model.postss(
                                                                                              requestFn: () => queryUsersRecord(
                                                                                                queryBuilder: (usersRecord) => usersRecord.where(
                                                                                                  'uid',
                                                                                                  isEqualTo: listViewCommentsRecord?.userId?.id,
                                                                                                ),
                                                                                                singleRecord: true,
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
                                                                                              List<UsersRecord> rowUsersRecordList = snapshot.data!.where((u) => u.uid != currentUserUid).toList();
                                                                                              // Return an empty Container when the item does not exist.
                                                                                              if (snapshot.data!.isEmpty) {
                                                                                                return Container();
                                                                                              }
                                                                                              final rowUsersRecord = rowUsersRecordList.isNotEmpty ? rowUsersRecordList.first : null;

                                                                                              return Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        width: 40.0,
                                                                                                        height: 40.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                          shape: BoxShape.circle,
                                                                                                        ),
                                                                                                        child: InkWell(
                                                                                                          splashColor: Colors.transparent,
                                                                                                          focusColor: Colors.transparent,
                                                                                                          hoverColor: Colors.transparent,
                                                                                                          highlightColor: Colors.transparent,
                                                                                                          onTap: () async {
                                                                                                            logFirebaseEvent('OTHERPROFILE_PAGE_Image_o8svtnbr_ON_TAP');
                                                                                                            logFirebaseEvent('Image_navigate_to');

                                                                                                            context.pushNamed(
                                                                                                              OtherprofileWidget.routeName,
                                                                                                              queryParameters: {
                                                                                                                'id': serializeParam(
                                                                                                                  listViewCommentsRecord?.reference.id,
                                                                                                                  ParamType.String,
                                                                                                                ),
                                                                                                              }.withoutNulls,
                                                                                                            );
                                                                                                          },
                                                                                                          child: ClipRRect(
                                                                                                            borderRadius: BorderRadius.circular(20.0),
                                                                                                            child: SvgPicture.network(
                                                                                                              rowUsersRecord!.photoUrl,
                                                                                                              height: 200.0,
                                                                                                              fit: BoxFit.cover,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Expanded(
                                                                                                        child: Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              valueOrDefault<String>(
                                                                                                                rowUsersRecord.displayName,
                                                                                                                'Name of the user Again',
                                                                                                              ),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.poppins(
                                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 16.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                            Container(
                                                                                                              width: MediaQuery.sizeOf(context).width * 0.8,
                                                                                                              decoration: BoxDecoration(),
                                                                                                              child: Text(
                                                                                                                valueOrDefault<String>(
                                                                                                                  listViewCommentsRecord?.commentText,
                                                                                                                  'comment text cpould be anything let\'s give it a shot could it break the screen.',
                                                                                                                ),
                                                                                                                style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                      font: GoogleFonts.poppins(
                                                                                                                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 14.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ].divide(SizedBox(height: 6.0)),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ].divide(SizedBox(width: 12.0)),
                                                                                                  ),
                                                                                                ],
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
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
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: wrapWithModel(
                          model: _model.navbarModel,
                          updateCallback: () => safeSetState(() {}),
                          child: NavbarWidget(
                            pageName: MenItems.profile,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
