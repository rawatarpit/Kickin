import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'my_network_model.dart';
export 'my_network_model.dart';

class MyNetworkWidget extends StatefulWidget {
  const MyNetworkWidget({
    super.key,
    this.userId,
    bool? curentuser,
    required this.name,
  }) : this.curentuser = curentuser ?? false;

  final String? userId;
  final bool curentuser;
  final String? name;

  static String routeName = 'my_network';
  static String routePath = 'mynetwork';

  @override
  State<MyNetworkWidget> createState() => _MyNetworkWidgetState();
}

class _MyNetworkWidgetState extends State<MyNetworkWidget> {
  late MyNetworkModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyNetworkModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'my_network'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'My Network',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                              maxWidth: 970.0,
                            ),
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                              child: SingleChildScrollView(
                                primary: false,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 60.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              logFirebaseEvent(
                                                  'MY_NETWORK_PAGE_Icon_l7lhhtw0_ON_TAP');
                                              logFirebaseEvent(
                                                  'Icon_navigate_back');
                                              context.safePop();
                                            },
                                            child: Icon(
                                              Icons.arrow_back,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 30.0,
                                            ),
                                          ),
                                          Text(
                                            widget.curentuser == false
                                                ? '${widget.name}\'s Network'
                                                : 'My Network',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineLarge
                                                .override(
                                                  font: GoogleFonts.oswald(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineLarge
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineLarge
                                                          .fontStyle,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 16.0)),
                                      ),
                                    ),
                                    AuthUserStreamWidget(
                                      builder: (context) => PagedListView<
                                          DocumentSnapshot<Object?>?,
                                          UsersRecord>.separated(
                                        pagingController: _model
                                            .setRegisteredPlayerController(
                                          UsersRecord.collection
                                              .whereIn(
                                                  'uid',
                                                  (currentUserDocument
                                                          ?.connectedList
                                                          .toList() ??
                                                      []))
                                              .orderBy('created_time'),
                                        ),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        reverse: false,
                                        scrollDirection: Axis.vertical,
                                        separatorBuilder: (_, __) =>
                                            SizedBox(height: 16.0),
                                        builderDelegate:
                                            PagedChildBuilderDelegate<
                                                UsersRecord>(
                                          // Customize what your widget looks like when it's loading the first page.
                                          firstPageProgressIndicatorBuilder:
                                              (_) => Center(
                                            child: SizedBox(
                                              width: 80.0,
                                              height: 80.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Customize what your widget looks like when it's loading another page.
                                          newPageProgressIndicatorBuilder:
                                              (_) => Center(
                                            child: SizedBox(
                                              width: 80.0,
                                              height: 80.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          ),

                                          itemBuilder: (context, _,
                                              registeredPlayerIndex) {
                                            final registeredPlayerUsersRecord =
                                                _model.registeredPlayerPagingController!
                                                        .itemList![
                                                    registeredPlayerIndex];
                                            return Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              height: 80.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .accent4,
                                                ),
                                              ),
                                              child: Padding(
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
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.5,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            width: 35.0,
                                                            height: 35.0,
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child:
                                                                CachedNetworkImage(
                                                              fadeInDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          500),
                                                              fadeOutDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          500),
                                                              imageUrl:
                                                                  registeredPlayerUsersRecord
                                                                      .photoUrl,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 145.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            child: Text(
                                                              registeredPlayerUsersRecord
                                                                  .displayName,
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
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 16.0)),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.3,
                                                      child: Stack(
                                                        children: [
                                                          if ((currentUserDocument
                                                                          ?.connectedList
                                                                          .toList() ??
                                                                      [])
                                                                  .contains(
                                                                      registeredPlayerUsersRecord
                                                                          .reference
                                                                          .id) ==
                                                              false)
                                                            FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                logFirebaseEvent(
                                                                    'MY_NETWORK_PAGE_connect_ON_TAP');
                                                                logFirebaseEvent(
                                                                    'connect_backend_call');
                                                                _model.sent =
                                                                    await ConnectionsTable()
                                                                        .insert({
                                                                  'from_user_id':
                                                                      currentUserUid,
                                                                  'to_user_id':
                                                                      registeredPlayerUsersRecord
                                                                          .reference
                                                                          .id,
                                                                  'status':
                                                                      Status
                                                                          .sent
                                                                          .name,
                                                                  'created_at':
                                                                      supaSerialize<
                                                                              DateTime>(
                                                                          getCurrentTimestamp),
                                                                });
                                                                logFirebaseEvent(
                                                                    'connect_backend_call');
                                                                _model.notification =
                                                                    await NotificationsTable()
                                                                        .insert({
                                                                  'receiver_id':
                                                                      _model
                                                                          .sent
                                                                          ?.toUserId,
                                                                  'sender_id':
                                                                      currentUserUid,
                                                                  'type':
                                                                      NotificationType
                                                                          .Request
                                                                          .name,
                                                                  'message':
                                                                      '${registeredPlayerUsersRecord.displayName} is trying to connect with you.',
                                                                  'is_read':
                                                                      false,
                                                                  'created_at':
                                                                      supaSerialize<
                                                                              DateTime>(
                                                                          getCurrentTimestamp),
                                                                });
                                                                logFirebaseEvent(
                                                                    'connect_trigger_push_notification');
                                                                triggerPushNotification(
                                                                  notificationTitle:
                                                                      currentUserDisplayName,
                                                                  notificationText:
                                                                      ' has sent you a connection reuqest.',
                                                                  notificationImageUrl:
                                                                      registeredPlayerUsersRecord
                                                                          .photoUrl,
                                                                  notificationSound:
                                                                      'default',
                                                                  userRefs: [
                                                                    registeredPlayerUsersRecord
                                                                        .reference
                                                                  ],
                                                                  initialPageName:
                                                                      'notifications',
                                                                  parameterData: {
                                                                    'tabIndex':
                                                                        0,
                                                                  },
                                                                );

                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              text: 'Connect',
                                                              options:
                                                                  FFButtonOptions(
                                                                width: double
                                                                    .infinity,
                                                                height: 48.0,
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        16.0,
                                                                        16.0,
                                                                        16.0),
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
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
                                                                      font: GoogleFonts
                                                                          .oswald(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
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
                                                          if ((currentUserDocument
                                                                          ?.connectedList
                                                                          .toList() ??
                                                                      [])
                                                                  .contains(
                                                                      registeredPlayerUsersRecord
                                                                          .reference
                                                                          .id) ==
                                                              true)
                                                            FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                logFirebaseEvent(
                                                                    'MY_NETWORK_PAGE_connect_ON_TAP');
                                                                final firestoreBatch =
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .batch();
                                                                try {
                                                                  logFirebaseEvent(
                                                                      'connect_backend_call');

                                                                  firestoreBatch
                                                                      .update(
                                                                          currentUserReference!,
                                                                          {
                                                                        ...mapToFirestore(
                                                                          {
                                                                            'connectedList':
                                                                                FieldValue.arrayRemove([
                                                                              registeredPlayerUsersRecord.reference.id
                                                                            ]),
                                                                          },
                                                                        ),
                                                                      });
                                                                  logFirebaseEvent(
                                                                      'connect_backend_call');

                                                                  firestoreBatch.update(
                                                                      registeredPlayerUsersRecord
                                                                          .reference,
                                                                      {
                                                                        ...mapToFirestore(
                                                                          {
                                                                            'connectedList':
                                                                                FieldValue.arrayRemove([
                                                                              currentUserReference?.id
                                                                            ]),
                                                                          },
                                                                        ),
                                                                      });
                                                                  logFirebaseEvent(
                                                                      'connect_backend_call');
                                                                  await SupabaseKickinEventGroup
                                                                      .deleteConnectionsCall
                                                                      .call(
                                                                    userId1:
                                                                        registeredPlayerUsersRecord
                                                                            .reference
                                                                            .id,
                                                                    userId2:
                                                                        currentUserReference
                                                                            ?.id,
                                                                  );
                                                                } finally {
                                                                  await firestoreBatch
                                                                      .commit();
                                                                }
                                                              },
                                                              text: 'Remove',
                                                              options:
                                                                  FFButtonOptions(
                                                                width: double
                                                                    .infinity,
                                                                height: 48.0,
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
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
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 24.0)),
                                ),
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
        ));
  }
}
