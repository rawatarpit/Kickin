import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/comment_screen_widget.dart';
import '/components/media_widget.dart';
import '/components/navbar_widget.dart';
import '/components/share_widget.dart';
import '/components/users_list_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'home';
  static String routePath = 'home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'home'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('HOME_PAGE_home_ON_INIT_STATE');
      if (loggedIn == true) {
        logFirebaseEvent('home_custom_action');
        await actions.forceRefreshToken();
        logFirebaseEvent('home_backend_call');

        await currentUserReference!.update(createUsersRecordData(
          uid: currentUserReference?.id,
        ));
        logFirebaseEvent('home_firestore_query');
        _model.userLists = await queryUsersRecordOnce(
          queryBuilder: (usersRecord) => usersRecord.whereNotIn(
              'uid', (currentUserDocument?.blockedList.toList() ?? [])),
        );
        logFirebaseEvent('home_update_page_state');
        _model.userList = _model.userLists!
            .map((e) => e.reference.id)
            .toList()
            .toList()
            .cast<String>();
        safeSetState(() {});
      } else {
        logFirebaseEvent('home_navigate_to');

        context.pushNamed(WelcomeWidget.routeName);
      }
    });

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

    return Title(
        title: 'Home',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              body: Stack(
                children: [
                  Container(
                    height: 770.0,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
                      child: GestureDetector(
                        onHorizontalDragEnd: (details) async {
                          logFirebaseEvent(
                              'HOME_Column_6r0kwh5q_ON_HORIZONTAL_DRAG_');
                          logFirebaseEvent('Column_navigate_to');

                          context.pushNamed(
                            InboxWidget.routeName,
                            extra: <String, dynamic>{
                              kTransitionInfoKey: TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.rightToLeft,
                              ),
                            },
                          );
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 24.0, 8.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: SvgPicture.network(
                                        'https://grbbdskhtdettoddpxfl.supabase.co/storage/v1/object/public/storage/assest/Kickin%20Logo.svg',
                                        width: 50.0,
                                        height: 50.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Stack(
                                          alignment:
                                              AlignmentDirectional(1.0, 1.0),
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'HOME_PAGE_notifications_ON_TAP');
                                                logFirebaseEvent(
                                                    'notifications_navigate_to');

                                                context.pushNamed(
                                                  NotificationsWidget.routeName,
                                                  queryParameters: {
                                                    'tabIndex': serializeParam(
                                                      0,
                                                      ParamType.int,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: SvgPicture.asset(
                                                  'assets/images/bell.svg',
                                                  width: 27.0,
                                                  height: 27.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 1.0),
                                              child: FutureBuilder<
                                                  List<NotificationsRow>>(
                                                future: NotificationsTable()
                                                    .queryRows(
                                                  queryFn: (q) => q
                                                      .eqOrNull(
                                                        'receiver_id',
                                                        currentUserUid,
                                                      )
                                                      .eqOrNull(
                                                        'is_read',
                                                        false,
                                                      )
                                                      .order('created_at'),
                                                  limit: 10,
                                                ),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 80.0,
                                                        height: 80.0,
                                                        child:
                                                            CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  List<NotificationsRow>
                                                      notificationNotificationsRowList =
                                                      snapshot.data!;

                                                  return Container(
                                                    decoration: BoxDecoration(),
                                                    child: Visibility(
                                                      visible:
                                                          notificationNotificationsRowList
                                                                  .length >=
                                                              1,
                                                      child: Container(
                                                        width: 10.0,
                                                        height: 10.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(1.0, 1.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(1.0, 1.0),
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  logFirebaseEvent(
                                                      'HOME_PAGE_message_ON_TAP');
                                                  logFirebaseEvent(
                                                      'message_navigate_to');

                                                  context.pushNamed(
                                                      InboxWidget.routeName);
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: SvgPicture.asset(
                                                    'assets/images/send.svg',
                                                    width: 27.0,
                                                    height: 27.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, 1.0),
                                                child: StreamBuilder<
                                                    List<ChatsRecord>>(
                                                  stream: queryChatsRecord(
                                                    queryBuilder: (chatsRecord) =>
                                                        chatsRecord
                                                            .where(
                                                              'participant_id',
                                                              arrayContains:
                                                                  currentUserReference
                                                                      ?.id,
                                                            )
                                                            .orderBy(
                                                                'updated_at'),
                                                    limit: 10,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 80.0,
                                                          height: 80.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<ChatsRecord>
                                                        messagesChatsRecordList =
                                                        snapshot.data!;

                                                    return Container(
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Visibility(
                                                        visible:
                                                            messagesChatsRecordList
                                                                    .length >=
                                                                1,
                                                        child: Container(
                                                          width: 10.0,
                                                          height: 10.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  1.0, 1.0),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 17.0)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 40.0, 0.0, 24.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) =>
                                      StreamBuilder<List<PostsRecord>>(
                                    stream: _model.post(
                                      requestFn: () => queryPostsRecord(
                                        queryBuilder: (postsRecord) =>
                                            postsRecord
                                                .whereNotIn(
                                                    'user_post',
                                                    (currentUserDocument
                                                            ?.blockedList
                                                            .toList() ??
                                                        []))
                                                .where(
                                                  'for_everyone',
                                                  isEqualTo: true,
                                                )
                                                .orderBy('time_posted',
                                                    descending: true),
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
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      List<PostsRecord>
                                          singlePostPostsRecordList =
                                          snapshot.data!;
                                      // Return an empty Container when the item does not exist.
                                      if (snapshot.data!.isEmpty) {
                                        return Container();
                                      }
                                      final singlePostPostsRecord =
                                          singlePostPostsRecordList.isNotEmpty
                                              ? singlePostPostsRecordList.first
                                              : null;

                                      return Container(
                                        decoration: BoxDecoration(),
                                        child: ListView(
                                          padding: EdgeInsets.zero,
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      8.0, 16.0, 8.0, 12.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  StreamBuilder<
                                                      List<UsersRecord>>(
                                                    stream: queryUsersRecord(
                                                      queryBuilder:
                                                          (usersRecord) =>
                                                              usersRecord.where(
                                                        'uid',
                                                        isEqualTo:
                                                            singlePostPostsRecord
                                                                ?.userPost,
                                                      ),
                                                      singleRecord: true,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 80.0,
                                                            height: 80.0,
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                      Color>(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<UsersRecord>
                                                          rowUsersRecordList =
                                                          snapshot.data!;
                                                      final rowUsersRecord =
                                                          rowUsersRecordList
                                                                  .isNotEmpty
                                                              ? rowUsersRecordList
                                                                  .first
                                                              : null;

                                                      return InkWell(
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
                                                              'HOME_PAGE_Row_m7yu9wee_ON_TAP');
                                                          if (singlePostPostsRecord
                                                                  ?.userPost ==
                                                              currentUserReference
                                                                  ?.id) {
                                                            logFirebaseEvent(
                                                                'Row_navigate_to');

                                                            context.pushNamed(
                                                                ProfileWidget
                                                                    .routeName);
                                                          } else {
                                                            logFirebaseEvent(
                                                                'Row_navigate_to');

                                                            context.pushNamed(
                                                              OtherprofileWidget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'id':
                                                                    serializeParam(
                                                                  rowUsersRecord
                                                                      .reference
                                                                      .id,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          }
                                                        },
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                              width: 45.0,
                                                              height: 45.0,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
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
                                                                    rowUsersRecord!
                                                                        .photoUrl,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                rowUsersRecord
                                                                    .displayName,
                                                                'Display name of the user',
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
                                                          ].divide(SizedBox(
                                                              width: 4.0)),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                8.0, 0.0),
                                                    child: Text(
                                                      dateTimeFormat(
                                                        "relative",
                                                        singlePostPostsRecord!
                                                            .timePosted!,
                                                        locale: FFLocalizations
                                                                    .of(context)
                                                                .languageShortCode ??
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodySmall
                                                          .override(
                                                            font: GoogleFonts
                                                                .poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontStyle,
                                                            ),
                                                            color: Color(
                                                                0xFFB2B2B2),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 16.0, 12.0, 18.0),
                                              child: Text(
                                                singlePostPostsRecord
                                                    .postDescription,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                            if (singlePostPostsRecord
                                                    .postType !=
                                                'post')
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 8.0, 0.0, 16.0),
                                                child: Stack(
                                                  children: [
                                                    if ((singlePostPostsRecord
                                                                .postType ==
                                                            'image') ||
                                                        (singlePostPostsRecord
                                                                .postType ==
                                                            'shot'))
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
                                                              'HOME_PAGE_Container_ce9ui13z_ON_TAP');
                                                          if (singlePostPostsRecord
                                                                  .isShot ==
                                                              true) {
                                                            logFirebaseEvent(
                                                                'media_navigate_to');

                                                            context.pushNamed(
                                                              KickinShotWidget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'postID':
                                                                    serializeParam(
                                                                  singlePostPostsRecord
                                                                      .reference,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          } else {
                                                            logFirebaseEvent(
                                                                'media_navigate_to');

                                                            context.pushNamed(
                                                              IndiviualPostWidget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'postId':
                                                                    serializeParam(
                                                                  singlePostPostsRecord
                                                                      .reference
                                                                      .id,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          }
                                                        },
                                                        onDoubleTap: () async {
                                                          logFirebaseEvent(
                                                              'HOME_Container_ce9ui13z_ON_DOUBLE_TAP');
                                                          var _shouldSetState =
                                                              false;
                                                          logFirebaseEvent(
                                                              'media_backend_call');

                                                          await singlePostPostsRecord
                                                              .reference
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'likes': FieldValue
                                                                    .arrayUnion([
                                                                  currentUserReference
                                                                ]),
                                                              },
                                                            ),
                                                          });
                                                          if (singlePostPostsRecord
                                                                  .userPost ==
                                                              currentUserReference
                                                                  ?.id) {
                                                            if (_shouldSetState)
                                                              safeSetState(
                                                                  () {});
                                                            return;
                                                          }

                                                          logFirebaseEvent(
                                                              'media_backend_call');
                                                          await NotificationsTable()
                                                              .insert({
                                                            'receiver_id':
                                                                singlePostPostsRecord
                                                                    .userPost,
                                                            'sender_id':
                                                                currentUserReference
                                                                    ?.id,
                                                            'type':
                                                                NotificationType
                                                                    .Like.name,
                                                            'message':
                                                                '${currentUserDisplayName} liked your Post.',
                                                            'is_read': false,
                                                            'created_at':
                                                                supaSerialize<
                                                                        DateTime>(
                                                                    getCurrentTimestamp),
                                                            'post_id':
                                                                singlePostPostsRecord
                                                                    .reference
                                                                    .id,
                                                          });
                                                          logFirebaseEvent(
                                                              'media_custom_action');
                                                          _model.userPost =
                                                              await actions
                                                                  .getDocumentRefFromCollection(
                                                            'users',
                                                            singlePostPostsRecord
                                                                .userPost,
                                                          );
                                                          _shouldSetState =
                                                              true;
                                                          logFirebaseEvent(
                                                              'media_trigger_push_notification');
                                                          triggerPushNotification(
                                                            notificationTitle:
                                                                currentUserDisplayName,
                                                            notificationText:
                                                                'Liked Your Post.',
                                                            notificationSound:
                                                                'default',
                                                            userRefs: [
                                                              _model.userPost!
                                                            ],
                                                            initialPageName:
                                                                'indiviual_post',
                                                            parameterData: {
                                                              'postId':
                                                                  singlePostPostsRecord
                                                                      .reference
                                                                      .id,
                                                            },
                                                          );
                                                          if (_shouldSetState)
                                                            safeSetState(() {});
                                                        },
                                                        child: wrapWithModel(
                                                          model: _model
                                                              .mediaModel1,
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child: MediaWidget(
                                                            media:
                                                                singlePostPostsRecord
                                                                    .mediauUrl,
                                                          ),
                                                        ),
                                                      ),
                                                    if (singlePostPostsRecord
                                                            .postType ==
                                                        'event')
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    12.0,
                                                                    0.0,
                                                                    12.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0.0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            8.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            8.0),
                                                                  ),
                                                                ),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0.0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            8.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            8.0),
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    singlePostPostsRecord
                                                                        .eventDetails
                                                                        .imageUrl,
                                                                    width: 87.7,
                                                                    height:
                                                                        200.0,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            8.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            8.0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            0.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            0.0),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          24.0,
                                                                          16.0,
                                                                          24.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            singlePostPostsRecord.eventDetails.eventName,
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
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                4.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              singlePostPostsRecord.eventDetails.description,
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
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                8.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Text(
                                                                                  singlePostPostsRecord.eventDetails.date,
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
                                                                                  singlePostPostsRecord.eventDetails.time,
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
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                12.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Builder(
                                                                              builder: (context) {
                                                                                final auidence = (singlePostPostsRecord.eventDetails.audience.toList() ?? []).take(7).toList();

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
                                                                    ].divide(SizedBox(
                                                                        height:
                                                                            16.0)),
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 6.0, 8.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          if (singlePostPostsRecord
                                                                  .likes
                                                                  .contains(
                                                                      currentUserReference) ==
                                                              false)
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
                                                                    'HOME_PAGE_Icon_9qfamhap_ON_TAP');
                                                                var _shouldSetState =
                                                                    false;
                                                                logFirebaseEvent(
                                                                    'Icon_haptic_feedback');
                                                                HapticFeedback
                                                                    .heavyImpact();
                                                                logFirebaseEvent(
                                                                    'Icon_backend_call');

                                                                await singlePostPostsRecord
                                                                    .reference
                                                                    .update({
                                                                  ...mapToFirestore(
                                                                    {
                                                                      'likes':
                                                                          FieldValue
                                                                              .arrayUnion([
                                                                        currentUserReference
                                                                      ]),
                                                                    },
                                                                  ),
                                                                });
                                                                if (singlePostPostsRecord
                                                                        .userPost ==
                                                                    currentUserReference
                                                                        ?.id) {
                                                                  if (_shouldSetState)
                                                                    safeSetState(
                                                                        () {});
                                                                  return;
                                                                }

                                                                logFirebaseEvent(
                                                                    'Icon_backend_call');
                                                                await NotificationsTable()
                                                                    .insert({
                                                                  'receiver_id':
                                                                      singlePostPostsRecord
                                                                          .userPost,
                                                                  'sender_id':
                                                                      currentUserUid,
                                                                  'type':
                                                                      NotificationType
                                                                          .Like
                                                                          .name,
                                                                  'message':
                                                                      '${FFAppState().name} Liked Your Post',
                                                                  'is_read':
                                                                      false,
                                                                  'created_at':
                                                                      supaSerialize<
                                                                              DateTime>(
                                                                          getCurrentTimestamp),
                                                                  'post_id':
                                                                      singlePostPostsRecord
                                                                          .reference
                                                                          .id,
                                                                });
                                                                logFirebaseEvent(
                                                                    'Icon_custom_action');
                                                                _model.userPo =
                                                                    await actions
                                                                        .getDocumentRefFromCollection(
                                                                  'users',
                                                                  singlePostPostsRecord
                                                                      .userPost,
                                                                );
                                                                _shouldSetState =
                                                                    true;
                                                                logFirebaseEvent(
                                                                    'Icon_trigger_push_notification');
                                                                triggerPushNotification(
                                                                  notificationTitle:
                                                                      currentUserDisplayName,
                                                                  notificationText:
                                                                      'liked Your Post.',
                                                                  notificationSound:
                                                                      'default',
                                                                  userRefs: [
                                                                    _model
                                                                        .userPo!
                                                                  ],
                                                                  initialPageName:
                                                                      'indiviual_post',
                                                                  parameterData: {
                                                                    'postId':
                                                                        singlePostPostsRecord
                                                                            .reference
                                                                            .id,
                                                                  },
                                                                );
                                                                if (_shouldSetState)
                                                                  safeSetState(
                                                                      () {});
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .favorite_border,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 30.0,
                                                              ),
                                                            ),
                                                          if (singlePostPostsRecord
                                                                  .likes
                                                                  .contains(
                                                                      currentUserReference) ==
                                                              true)
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
                                                                    'HOME_PAGE_Icon_wbz7ec9b_ON_TAP');
                                                                logFirebaseEvent(
                                                                    'Icon_backend_call');

                                                                await singlePostPostsRecord
                                                                    .reference
                                                                    .update({
                                                                  ...mapToFirestore(
                                                                    {
                                                                      'likes':
                                                                          FieldValue
                                                                              .arrayRemove([
                                                                        currentUserReference
                                                                      ]),
                                                                    },
                                                                  ),
                                                                });
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .favorite_sharp,
                                                                color: Color(
                                                                    0xFFFF1726),
                                                                size: 30.0,
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                      Text(
                                                        formatNumber(
                                                          singlePostPostsRecord
                                                              .likes.length,
                                                          formatType: FormatType
                                                              .compact,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                              'HOME_PAGE_comment_ON_TAP');
                                                          logFirebaseEvent(
                                                              'comment_custom_action');
                                                          _model.use = await actions
                                                              .getDocumentRefFromCollection(
                                                            'users',
                                                            singlePostPostsRecord
                                                                .userPost,
                                                          );
                                                          logFirebaseEvent(
                                                              'comment_bottom_sheet');
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            context: context,
                                                            builder: (context) {
                                                              return WebViewAware(
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    FocusScope.of(
                                                                            context)
                                                                        .unfocus();
                                                                    FocusManager
                                                                        .instance
                                                                        .primaryFocus
                                                                        ?.unfocus();
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: MediaQuery
                                                                        .viewInsetsOf(
                                                                            context),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          MediaQuery.sizeOf(context).height *
                                                                              0.8,
                                                                      child:
                                                                          CommentScreenWidget(
                                                                        postId:
                                                                            singlePostPostsRecord,
                                                                        creator:
                                                                            _model.use!,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));

                                                          safeSetState(() {});
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/images/Comment.svg',
                                                            width: 25.0,
                                                            height: 25.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
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
                                                              'HOME_PAGE_shares_ON_TAP');
                                                          logFirebaseEvent(
                                                              'shares_bottom_sheet');
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            context: context,
                                                            builder: (context) {
                                                              return WebViewAware(
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    FocusScope.of(
                                                                            context)
                                                                        .unfocus();
                                                                    FocusManager
                                                                        .instance
                                                                        .primaryFocus
                                                                        ?.unfocus();
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: MediaQuery
                                                                        .viewInsetsOf(
                                                                            context),
                                                                    child:
                                                                        ShareWidget(
                                                                      link:
                                                                          'https://kickin.in/indiviualPost?postId=${singlePostPostsRecord.reference.id}',
                                                                      postId:
                                                                          singlePostPostsRecord,
                                                                      isTournament:
                                                                          false,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/images/send_white.svg',
                                                            width: 26.0,
                                                            height: 25.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 8.0)),
                                                  ),
                                                ].divide(SizedBox(width: 4.0)),
                                              ),
                                            ),
                                            if (singlePostPostsRecord
                                                    .numComments >=
                                                1)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 8.0, 12.0, 0.0),
                                                child: StreamBuilder<
                                                    List<CommentsRecord>>(
                                                  stream: _model.comments(
                                                    requestFn: () =>
                                                        queryCommentsRecord(
                                                      parent:
                                                          singlePostPostsRecord
                                                              .reference,
                                                      queryBuilder:
                                                          (commentsRecord) =>
                                                              commentsRecord
                                                                  .where(
                                                                    'post_id',
                                                                    isEqualTo:
                                                                        singlePostPostsRecord
                                                                            .reference,
                                                                  )
                                                                  .orderBy(
                                                                      'created_time',
                                                                      descending:
                                                                          true),
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
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<CommentsRecord>
                                                        listViewCommentsRecordList =
                                                        snapshot.data!;
                                                    // Return an empty Container when the item does not exist.
                                                    if (snapshot
                                                        .data!.isEmpty) {
                                                      return Container();
                                                    }
                                                    final listViewCommentsRecord =
                                                        listViewCommentsRecordList
                                                                .isNotEmpty
                                                            ? listViewCommentsRecordList
                                                                .first
                                                            : null;

                                                    return ListView(
                                                      padding: EdgeInsets.zero,
                                                      primary: false,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      children: [
                                                        StreamBuilder<
                                                            List<UsersRecord>>(
                                                          stream: _model.info(
                                                            requestFn: () =>
                                                                queryUsersRecord(
                                                              queryBuilder:
                                                                  (usersRecord) =>
                                                                      usersRecord
                                                                          .where(
                                                                'uid',
                                                                isEqualTo:
                                                                    listViewCommentsRecord
                                                                        ?.userId
                                                                        ?.id,
                                                              ),
                                                              singleRecord:
                                                                  true,
                                                            ),
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 80.0,
                                                                  height: 80.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    valueColor:
                                                                        AlwaysStoppedAnimation<
                                                                            Color>(
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            List<UsersRecord>
                                                                rowUsersRecordList =
                                                                snapshot.data!;
                                                            // Return an empty Container when the item does not exist.
                                                            if (snapshot.data!
                                                                .isEmpty) {
                                                              return Container();
                                                            }
                                                            final rowUsersRecord =
                                                                rowUsersRecordList
                                                                        .isNotEmpty
                                                                    ? rowUsersRecordList
                                                                        .first
                                                                    : null;

                                                            return Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          40.0,
                                                                      height:
                                                                          40.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          logFirebaseEvent(
                                                                              'HOME_PAGE_Image_mpwrrnrx_ON_TAP');
                                                                          logFirebaseEvent(
                                                                              'Image_navigate_to');

                                                                          context
                                                                              .pushNamed(
                                                                            OtherprofileWidget.routeName,
                                                                            queryParameters:
                                                                                {
                                                                              'id': serializeParam(
                                                                                listViewCommentsRecord?.reference.id,
                                                                                ParamType.String,
                                                                              ),
                                                                            }.withoutNulls,
                                                                          );
                                                                        },
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20.0),
                                                                          child:
                                                                              SvgPicture.network(
                                                                            rowUsersRecord!.photoUrl,
                                                                            height:
                                                                                200.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            [
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
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.8,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Text(
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
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          12.0)),
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
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 1.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Suggested Users',
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              font: GoogleFonts.oswald(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 12.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 244.0,
                                        decoration: BoxDecoration(),
                                        child: FutureBuilder<ApiCallResponse>(
                                          future: (_model
                                                      .apiRequestCompleter ??=
                                                  Completer<ApiCallResponse>()
                                                    ..complete(
                                                        SupabaseKickinEventGroup
                                                            .suggestedUsersCall
                                                            .call(
                                                      currentUid:
                                                          currentUserReference
                                                              ?.id,
                                                    )))
                                              .future,
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 80.0,
                                                  height: 80.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            final suggestedusersSuggestedUsersResponse =
                                                snapshot.data!;

                                            return Builder(
                                              builder: (context) {
                                                final suggestedUsers =
                                                    getJsonField(
                                                  suggestedusersSuggestedUsersResponse
                                                      .jsonBody,
                                                  r'''$''',
                                                ).toList().take(30).toList();

                                                return ListView.separated(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      suggestedUsers.length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(width: 8.0),
                                                  itemBuilder: (context,
                                                      suggestedUsersIndex) {
                                                    final suggestedUsersItem =
                                                        suggestedUsers[
                                                            suggestedUsersIndex];
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  4.0,
                                                                  6.0,
                                                                  4.0,
                                                                  6.0),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.5,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 4.0,
                                                              color: Color(
                                                                  0x34090F13),
                                                              offset: Offset(
                                                                0.0,
                                                                2.0,
                                                              ),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  12.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'HOME_PAGE_Image_9x2v5tt6_ON_TAP');
                                                                    logFirebaseEvent(
                                                                        'Image_navigate_to');

                                                                    context
                                                                        .pushNamed(
                                                                      OtherprofileWidget
                                                                          .routeName,
                                                                      queryParameters:
                                                                          {
                                                                        'id':
                                                                            serializeParam(
                                                                          getJsonField(
                                                                            suggestedUsersItem,
                                                                            r'''$.user_id''',
                                                                          ).toString(),
                                                                          ParamType
                                                                              .String,
                                                                        ),
                                                                      }.withoutNulls,
                                                                    );
                                                                  },
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50.0),
                                                                    child: Image
                                                                        .network(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        getJsonField(
                                                                          suggestedUsersItem,
                                                                          r'''$.profile_pic''',
                                                                        )?.toString(),
                                                                        'https://grbbdskhtdettoddpxfl.supabase.co/storage/v1/object/public/storage/Photos/Profile.svg',
                                                                      ),
                                                                      width:
                                                                          60.0,
                                                                      height:
                                                                          60.0,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      errorBuilder: (context,
                                                                              error,
                                                                              stackTrace) =>
                                                                          Image
                                                                              .asset(
                                                                        'assets/images/error_image.svg',
                                                                        width:
                                                                            60.0,
                                                                        height:
                                                                            60.0,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            8.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    getJsonField(
                                                                      suggestedUsersItem,
                                                                      r'''$.name''',
                                                                    )?.toString(),
                                                                    'Name',
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
                                                                    getJsonField(
                                                                      suggestedUsersItem,
                                                                      r'''$.role''',
                                                                    )?.toString(),
                                                                    'Player',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .poppins(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                              if (getJsonField(
                                                                    suggestedUsersItem,
                                                                    r'''$.mutual_user_ids''',
                                                                  ) ==
                                                                  null)
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          4.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      logFirebaseEvent(
                                                                          'HOME_PAGE_Text_ianvm5e5_ON_TAP');
                                                                      logFirebaseEvent(
                                                                          'RichText_bottom_sheet');
                                                                      await showModalBottomSheet(
                                                                        isScrollControlled:
                                                                            true,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return WebViewAware(
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                FocusScope.of(context).unfocus();
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                              },
                                                                              child: Padding(
                                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                                child: UsersListWidget(
                                                                                  userIds: (getJsonField(
                                                                                    suggestedUsersItem,
                                                                                    r'''$.mutual_user_ids''',
                                                                                    true,
                                                                                  ) as List)
                                                                                      .map<String>((s) => s.toString())
                                                                                      .toList(),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ).then((value) =>
                                                                          safeSetState(
                                                                              () {}));
                                                                    },
                                                                    child:
                                                                        RichText(
                                                                      textScaler:
                                                                          MediaQuery.of(context)
                                                                              .textScaler,
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                '${valueOrDefault<String>(
                                                                              getJsonField(
                                                                                suggestedUsersItem,
                                                                                r'''$.mutual_count''',
                                                                              )?.toString(),
                                                                              'Player',
                                                                            )} mutual connections',
                                                                            style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                  font: GoogleFonts.poppins(
                                                                                    fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).accent4,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                  decoration: TextDecoration.underline,
                                                                                ),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .override(
                                                                              font: GoogleFonts.poppins(
                                                                                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).accent4,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            16.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Stack(
                                                                  children: [
                                                                    if ((currentUserDocument?.requestedList.toList() ??
                                                                                [])
                                                                            .contains(getJsonField(
                                                                          suggestedUsersItem,
                                                                          r'''$.user_id''',
                                                                        ).toString()) ==
                                                                        true)
                                                                      AuthUserStreamWidget(
                                                                        builder:
                                                                            (context) =>
                                                                                FFButtonWidget(
                                                                          onPressed:
                                                                              () async {
                                                                            logFirebaseEvent('HOME_PAGE_Sent_ON_TAP');
                                                                            final firestoreBatch =
                                                                                FirebaseFirestore.instance.batch();
                                                                            try {
                                                                              logFirebaseEvent('Sent_backend_call');
                                                                              await ConnectionsTable().delete(
                                                                                matchingRows: (rows) => rows
                                                                                    .eqOrNull(
                                                                                      'from_user_id',
                                                                                      currentUserReference?.id,
                                                                                    )
                                                                                    .eqOrNull(
                                                                                      'to_user_id',
                                                                                      suggestedUsersItem.toString(),
                                                                                    ),
                                                                              );
                                                                              logFirebaseEvent('Sent_custom_action');
                                                                              _model.docs = await actions.getDocumentRefFromCollection(
                                                                                'users',
                                                                                getJsonField(
                                                                                  suggestedUsersItem,
                                                                                  r'''$.user_id''',
                                                                                ).toString(),
                                                                              );
                                                                              await Future.wait([
                                                                                Future(() async {
                                                                                  logFirebaseEvent('Sent_backend_call');

                                                                                  firestoreBatch.update(currentUserReference!, {
                                                                                    ...mapToFirestore(
                                                                                      {
                                                                                        'requestedList': FieldValue.arrayRemove([
                                                                                          getJsonField(
                                                                                            suggestedUsersItem,
                                                                                            r'''$.user_id''',
                                                                                          ).toString()
                                                                                        ]),
                                                                                      },
                                                                                    ),
                                                                                  });
                                                                                }),
                                                                                Future(() async {
                                                                                  logFirebaseEvent('Sent_backend_call');

                                                                                  firestoreBatch.update(_model.docs!, {
                                                                                    ...mapToFirestore(
                                                                                      {
                                                                                        'requestedList': FieldValue.arrayRemove([
                                                                                          currentUserReference?.id
                                                                                        ]),
                                                                                      },
                                                                                    ),
                                                                                  });
                                                                                }),
                                                                              ]);
                                                                              logFirebaseEvent('Sent_refresh_database_request');
                                                                              safeSetState(() => _model.apiRequestCompleter = null);
                                                                              await _model.waitForApiRequestCompleted(minWait: 1500, maxWait: 2000);
                                                                            } finally {
                                                                              await firestoreBatch.commit();
                                                                            }

                                                                            safeSetState(() {});
                                                                          },
                                                                          text:
                                                                              'Sent',
                                                                          options:
                                                                              FFButtonOptions(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 1.0,
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
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
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
                                                                            elevation:
                                                                                0.0,
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              width: 1.0,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    if ((currentUserDocument?.requestedList.toList() ??
                                                                                [])
                                                                            .contains(getJsonField(
                                                                          suggestedUsersItem,
                                                                          r'''$.user_id''',
                                                                        ).toString()) ==
                                                                        false)
                                                                      AuthUserStreamWidget(
                                                                        builder:
                                                                            (context) =>
                                                                                FFButtonWidget(
                                                                          onPressed:
                                                                              () async {
                                                                            logFirebaseEvent('HOME_PAGE_connect_ON_TAP');
                                                                            final firestoreBatch =
                                                                                FirebaseFirestore.instance.batch();
                                                                            try {
                                                                              logFirebaseEvent('connect_backend_call');
                                                                              _model.sent = await ConnectionsTable().insert({
                                                                                'from_user_id': currentUserUid,
                                                                                'to_user_id': getJsonField(
                                                                                  suggestedUsersItem,
                                                                                  r'''$.user_id''',
                                                                                ).toString(),
                                                                                'status': Status.sent.name,
                                                                                'created_at': supaSerialize<DateTime>(getCurrentTimestamp),
                                                                              });
                                                                              await Future.wait([
                                                                                Future(() async {
                                                                                  logFirebaseEvent('connect_custom_action');
                                                                                  _model.doc = await actions.getDocumentRefFromCollection(
                                                                                    'users',
                                                                                    getJsonField(
                                                                                      suggestedUsersItem,
                                                                                      r'''$.user_id''',
                                                                                    ).toString(),
                                                                                  );
                                                                                  logFirebaseEvent('connect_backend_call');

                                                                                  firestoreBatch.update(currentUserReference!, {
                                                                                    ...mapToFirestore(
                                                                                      {
                                                                                        'requestedList': FieldValue.arrayUnion([
                                                                                          getJsonField(
                                                                                            suggestedUsersItem,
                                                                                            r'''$.user_id''',
                                                                                          ).toString()
                                                                                        ]),
                                                                                      },
                                                                                    ),
                                                                                  });
                                                                                  logFirebaseEvent('connect_backend_call');

                                                                                  firestoreBatch.update(_model.doc!, {
                                                                                    ...mapToFirestore(
                                                                                      {
                                                                                        'requestedList': FieldValue.arrayUnion([
                                                                                          currentUserReference?.id
                                                                                        ]),
                                                                                      },
                                                                                    ),
                                                                                  });
                                                                                }),
                                                                                Future(() async {
                                                                                  logFirebaseEvent('connect_refresh_database_request');
                                                                                  safeSetState(() => _model.apiRequestCompleter = null);
                                                                                  await _model.waitForApiRequestCompleted();
                                                                                }),
                                                                              ]);
                                                                              logFirebaseEvent('connect_backend_call');
                                                                              _model.notification = await NotificationsTable().insert({
                                                                                'receiver_id': _model.sent?.toUserId,
                                                                                'sender_id': currentUserUid,
                                                                                'type': NotificationType.Request.name,
                                                                                'message': '${currentUserDisplayName} is trying to connect with you.',
                                                                                'is_read': false,
                                                                                'created_at': supaSerialize<DateTime>(getCurrentTimestamp),
                                                                              });
                                                                              logFirebaseEvent('connect_trigger_push_notification');
                                                                              triggerPushNotification(
                                                                                notificationTitle: currentUserDisplayName,
                                                                                notificationText: ' has sent you a connection reuqest.',
                                                                                notificationImageUrl: getJsonField(
                                                                                  suggestedUsersItem,
                                                                                  r'''$.profile_pic''',
                                                                                ).toString(),
                                                                                notificationSound: 'default',
                                                                                userRefs: [
                                                                                  _model.doc!
                                                                                ],
                                                                                initialPageName: 'notifications',
                                                                                parameterData: {
                                                                                  'tabIndex': 0,
                                                                                },
                                                                              );
                                                                            } finally {
                                                                              await firestoreBatch.commit();
                                                                            }

                                                                            safeSetState(() {});
                                                                          },
                                                                          text:
                                                                              'Connect',
                                                                          options:
                                                                              FFButtonOptions(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 1.0,
                                                                            height:
                                                                                48.0,
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                16.0,
                                                                                16.0,
                                                                                16.0,
                                                                                16.0),
                                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).tertiary,
                                                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  font: GoogleFonts.oswald(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                            elevation:
                                                                                0.0,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
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
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 16.0)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 80.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => PagedListView<
                                      DocumentSnapshot<Object?>?,
                                      PostsRecord>.separated(
                                    pagingController: _model.setPostsController(
                                      PostsRecord.collection
                                          .whereNotIn(
                                              'user_post',
                                              (currentUserDocument?.blockedList
                                                      .toList() ??
                                                  []))
                                          .where(
                                            'for_everyone',
                                            isEqualTo: true,
                                          )
                                          .orderBy('time_posted',
                                              descending: true),
                                    ),
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    shrinkWrap: true,
                                    reverse: false,
                                    scrollDirection: Axis.vertical,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(height: 8.0),
                                    builderDelegate:
                                        PagedChildBuilderDelegate<PostsRecord>(
                                      // Customize what your widget looks like when it's loading the first page.
                                      firstPageProgressIndicatorBuilder: (_) =>
                                          Center(
                                        child: SizedBox(
                                          width: 80.0,
                                          height: 80.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Customize what your widget looks like when it's loading another page.
                                      newPageProgressIndicatorBuilder: (_) =>
                                          Center(
                                        child: SizedBox(
                                          width: 80.0,
                                          height: 80.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      ),

                                      itemBuilder: (context, _, postsIndex) {
                                        final postsPostsRecord = _model
                                            .postsPagingController!
                                            .itemList![postsIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 24.0),
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: ListView(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 16.0, 8.0, 12.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      StreamBuilder<
                                                          List<UsersRecord>>(
                                                        stream:
                                                            queryUsersRecord(
                                                          queryBuilder:
                                                              (usersRecord) =>
                                                                  usersRecord
                                                                      .where(
                                                            'uid',
                                                            isEqualTo:
                                                                postsPostsRecord
                                                                    .userPost,
                                                          ),
                                                          singleRecord: true,
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 80.0,
                                                                height: 80.0,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor:
                                                                      AlwaysStoppedAnimation<
                                                                          Color>(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<UsersRecord>
                                                              rowUsersRecordList =
                                                              snapshot.data!;
                                                          final rowUsersRecord =
                                                              rowUsersRecordList
                                                                      .isNotEmpty
                                                                  ? rowUsersRecordList
                                                                      .first
                                                                  : null;

                                                          return InkWell(
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
                                                                  'HOME_PAGE_Row_pguab7ay_ON_TAP');
                                                              if (postsPostsRecord
                                                                      .userPost ==
                                                                  currentUserReference
                                                                      ?.id) {
                                                                logFirebaseEvent(
                                                                    'Row_navigate_to');

                                                                context.pushNamed(
                                                                    ProfileWidget
                                                                        .routeName);
                                                              } else {
                                                                logFirebaseEvent(
                                                                    'Row_navigate_to');

                                                                context
                                                                    .pushNamed(
                                                                  OtherprofileWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'id':
                                                                        serializeParam(
                                                                      rowUsersRecord
                                                                          .reference
                                                                          .id,
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              }
                                                            },
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                  width: 45.0,
                                                                  height: 45.0,
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
                                                                        rowUsersRecord!
                                                                            .photoUrl,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    rowUsersRecord
                                                                        .displayName,
                                                                    'Display name of the user',
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
                                                              ].divide(SizedBox(
                                                                  width: 4.0)),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    8.0,
                                                                    0.0),
                                                        child: Text(
                                                          dateTimeFormat(
                                                            "relative",
                                                            postsPostsRecord
                                                                .timePosted!,
                                                            locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageShortCode ??
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xFFB2B2B2),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 8.0)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(12.0, 16.0,
                                                          12.0, 18.0),
                                                  child: Text(
                                                    postsPostsRecord
                                                        .postDescription,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .poppins(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                                if (postsPostsRecord.postType !=
                                                    'post')
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 8.0,
                                                                0.0, 16.0),
                                                    child: Stack(
                                                      children: [
                                                        if ((postsPostsRecord
                                                                    .postType ==
                                                                'image') ||
                                                            (postsPostsRecord
                                                                    .postType ==
                                                                'shot'))
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
                                                                  'HOME_PAGE_Container_x4gyleaz_ON_TAP');
                                                              if (postsPostsRecord
                                                                      .isShot ==
                                                                  true) {
                                                                logFirebaseEvent(
                                                                    'media_navigate_to');

                                                                context
                                                                    .pushNamed(
                                                                  KickinShotWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'postID':
                                                                        serializeParam(
                                                                      postsPostsRecord
                                                                          .reference,
                                                                      ParamType
                                                                          .DocumentReference,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              } else {
                                                                logFirebaseEvent(
                                                                    'media_navigate_to');

                                                                context
                                                                    .pushNamed(
                                                                  IndiviualPostWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'postId':
                                                                        serializeParam(
                                                                      postsPostsRecord
                                                                          .reference
                                                                          .id,
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              }
                                                            },
                                                            onDoubleTap:
                                                                () async {
                                                              logFirebaseEvent(
                                                                  'HOME_Container_x4gyleaz_ON_DOUBLE_TAP');
                                                              var _shouldSetState =
                                                                  false;
                                                              logFirebaseEvent(
                                                                  'media_backend_call');

                                                              await postsPostsRecord
                                                                  .reference
                                                                  .update({
                                                                ...mapToFirestore(
                                                                  {
                                                                    'likes':
                                                                        FieldValue
                                                                            .arrayUnion([
                                                                      currentUserReference
                                                                    ]),
                                                                  },
                                                                ),
                                                              });
                                                              if (postsPostsRecord
                                                                      .userPost ==
                                                                  currentUserReference
                                                                      ?.id) {
                                                                if (_shouldSetState)
                                                                  safeSetState(
                                                                      () {});
                                                                return;
                                                              }

                                                              logFirebaseEvent(
                                                                  'media_backend_call');
                                                              await NotificationsTable()
                                                                  .insert({
                                                                'receiver_id':
                                                                    postsPostsRecord
                                                                        .userPost,
                                                                'sender_id':
                                                                    currentUserReference
                                                                        ?.id,
                                                                'type':
                                                                    NotificationType
                                                                        .Like
                                                                        .name,
                                                                'message':
                                                                    '${currentUserDisplayName} liked your Post.',
                                                                'is_read':
                                                                    false,
                                                                'created_at':
                                                                    supaSerialize<
                                                                            DateTime>(
                                                                        getCurrentTimestamp),
                                                                'post_id':
                                                                    postsPostsRecord
                                                                        .reference
                                                                        .id,
                                                              });
                                                              logFirebaseEvent(
                                                                  'media_custom_action');
                                                              _model.userPosts =
                                                                  await actions
                                                                      .getDocumentRefFromCollection(
                                                                'users',
                                                                postsPostsRecord
                                                                    .userPost,
                                                              );
                                                              _shouldSetState =
                                                                  true;
                                                              logFirebaseEvent(
                                                                  'media_trigger_push_notification');
                                                              triggerPushNotification(
                                                                notificationTitle:
                                                                    currentUserDisplayName,
                                                                notificationText:
                                                                    'Liked Your Post.',
                                                                notificationSound:
                                                                    'default',
                                                                userRefs: [
                                                                  _model
                                                                      .userPosts!
                                                                ],
                                                                initialPageName:
                                                                    'indiviual_post',
                                                                parameterData: {
                                                                  'postId':
                                                                      postsPostsRecord
                                                                          .reference
                                                                          .id,
                                                                },
                                                              );
                                                              if (_shouldSetState)
                                                                safeSetState(
                                                                    () {});
                                                            },
                                                            child:
                                                                wrapWithModel(
                                                              model: _model
                                                                  .mediaModels2
                                                                  .getModel(
                                                                postsPostsRecord
                                                                    .reference
                                                                    .id,
                                                                postsIndex,
                                                              ),
                                                              updateCallback: () =>
                                                                  safeSetState(
                                                                      () {}),
                                                              child:
                                                                  MediaWidget(
                                                                key: Key(
                                                                  'Keyx4g_${postsPostsRecord.reference.id}',
                                                                ),
                                                                media: postsPostsRecord
                                                                    .mediauUrl,
                                                              ),
                                                            ),
                                                          ),
                                                        if (postsPostsRecord
                                                                .postType ==
                                                            'event')
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        0.0,
                                                                        12.0,
                                                                        0.0),
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Container(
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        bottomLeft:
                                                                            Radius.circular(0.0),
                                                                        bottomRight:
                                                                            Radius.circular(0.0),
                                                                        topLeft:
                                                                            Radius.circular(8.0),
                                                                        topRight:
                                                                            Radius.circular(8.0),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        bottomLeft:
                                                                            Radius.circular(0.0),
                                                                        bottomRight:
                                                                            Radius.circular(0.0),
                                                                        topLeft:
                                                                            Radius.circular(8.0),
                                                                        topRight:
                                                                            Radius.circular(8.0),
                                                                      ),
                                                                      child: Image
                                                                          .network(
                                                                        postsPostsRecord
                                                                            .eventDetails
                                                                            .imageUrl,
                                                                        width:
                                                                            87.7,
                                                                        height:
                                                                            200.0,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        bottomLeft:
                                                                            Radius.circular(8.0),
                                                                        bottomRight:
                                                                            Radius.circular(8.0),
                                                                        topLeft:
                                                                            Radius.circular(0.0),
                                                                        topRight:
                                                                            Radius.circular(0.0),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          16.0,
                                                                          24.0,
                                                                          16.0,
                                                                          24.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            [
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
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
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 6.0, 8.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              if (postsPostsRecord
                                                                      .likes
                                                                      .contains(
                                                                          currentUserReference) ==
                                                                  false)
                                                                InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'HOME_PAGE_Icon_4vn7q4u5_ON_TAP');
                                                                    var _shouldSetState =
                                                                        false;
                                                                    logFirebaseEvent(
                                                                        'Icon_haptic_feedback');
                                                                    HapticFeedback
                                                                        .heavyImpact();
                                                                    logFirebaseEvent(
                                                                        'Icon_backend_call');

                                                                    await postsPostsRecord
                                                                        .reference
                                                                        .update({
                                                                      ...mapToFirestore(
                                                                        {
                                                                          'likes':
                                                                              FieldValue.arrayUnion([
                                                                            currentUserReference
                                                                          ]),
                                                                        },
                                                                      ),
                                                                    });
                                                                    if (postsPostsRecord
                                                                            .userPost ==
                                                                        currentUserReference
                                                                            ?.id) {
                                                                      if (_shouldSetState)
                                                                        safeSetState(
                                                                            () {});
                                                                      return;
                                                                    }

                                                                    logFirebaseEvent(
                                                                        'Icon_backend_call');
                                                                    await NotificationsTable()
                                                                        .insert({
                                                                      'receiver_id':
                                                                          postsPostsRecord
                                                                              .userPost,
                                                                      'sender_id':
                                                                          currentUserUid,
                                                                      'type': NotificationType
                                                                          .Like
                                                                          .name,
                                                                      'message':
                                                                          '${FFAppState().name} Liked Your Post',
                                                                      'is_read':
                                                                          false,
                                                                      'created_at':
                                                                          supaSerialize<DateTime>(
                                                                              getCurrentTimestamp),
                                                                      'post_id':
                                                                          postsPostsRecord
                                                                              .reference
                                                                              .id,
                                                                    });
                                                                    logFirebaseEvent(
                                                                        'Icon_custom_action');
                                                                    _model.userPos =
                                                                        await actions
                                                                            .getDocumentRefFromCollection(
                                                                      'users',
                                                                      postsPostsRecord
                                                                          .userPost,
                                                                    );
                                                                    _shouldSetState =
                                                                        true;
                                                                    logFirebaseEvent(
                                                                        'Icon_trigger_push_notification');
                                                                    triggerPushNotification(
                                                                      notificationTitle:
                                                                          currentUserDisplayName,
                                                                      notificationText:
                                                                          'liked Your Post.',
                                                                      notificationSound:
                                                                          'default',
                                                                      userRefs: [
                                                                        _model
                                                                            .userPos!
                                                                      ],
                                                                      initialPageName:
                                                                          'indiviual_post',
                                                                      parameterData: {
                                                                        'postId': postsPostsRecord
                                                                            .reference
                                                                            .id,
                                                                      },
                                                                    );
                                                                    if (_shouldSetState)
                                                                      safeSetState(
                                                                          () {});
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    size: 30.0,
                                                                  ),
                                                                ),
                                                              if (postsPostsRecord
                                                                      .likes
                                                                      .contains(
                                                                          currentUserReference) ==
                                                                  true)
                                                                InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    logFirebaseEvent(
                                                                        'HOME_PAGE_Icon_gmosy196_ON_TAP');
                                                                    logFirebaseEvent(
                                                                        'Icon_backend_call');

                                                                    await postsPostsRecord
                                                                        .reference
                                                                        .update({
                                                                      ...mapToFirestore(
                                                                        {
                                                                          'likes':
                                                                              FieldValue.arrayRemove([
                                                                            currentUserReference
                                                                          ]),
                                                                        },
                                                                      ),
                                                                    });
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .favorite_sharp,
                                                                    color: Color(
                                                                        0xFFFF1726),
                                                                    size: 30.0,
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                          Text(
                                                            formatNumber(
                                                              postsPostsRecord
                                                                  .likes.length,
                                                              formatType:
                                                                  FormatType
                                                                      .compact,
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
                                                                  'HOME_PAGE_comment_ON_TAP');
                                                              logFirebaseEvent(
                                                                  'comment_custom_action');
                                                              _model.uses =
                                                                  await actions
                                                                      .getDocumentRefFromCollection(
                                                                'users',
                                                                postsPostsRecord
                                                                    .userPost,
                                                              );
                                                              logFirebaseEvent(
                                                                  'comment_bottom_sheet');
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
                                                                            Container(
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.8,
                                                                          child:
                                                                              CommentScreenWidget(
                                                                            postId:
                                                                                postsPostsRecord,
                                                                            creator:
                                                                                _model.uses!,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));

                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/images/Comment.svg',
                                                                width: 25.0,
                                                                height: 25.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
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
                                                                  'HOME_PAGE_shares_ON_TAP');
                                                              logFirebaseEvent(
                                                                  'shares_bottom_sheet');
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
                                                                            ShareWidget(
                                                                          link:
                                                                              'https://kickin.in/indiviualPost?postId=${postsPostsRecord.reference.id}',
                                                                          postId:
                                                                              postsPostsRecord,
                                                                          isTournament:
                                                                              false,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/images/send_white.svg',
                                                                width: 26.0,
                                                                height: 25.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 8.0)),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 4.0)),
                                                  ),
                                                ),
                                                if (postsPostsRecord
                                                        .numComments >=
                                                    1)
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 8.0,
                                                                12.0, 0.0),
                                                    child: StreamBuilder<
                                                        List<CommentsRecord>>(
                                                      stream:
                                                          queryCommentsRecord(
                                                        parent: postsPostsRecord
                                                            .reference,
                                                        queryBuilder: (commentsRecord) =>
                                                            commentsRecord
                                                                .where(
                                                                  'post_id',
                                                                  isEqualTo:
                                                                      postsPostsRecord
                                                                          .reference,
                                                                )
                                                                .orderBy(
                                                                    'created_time',
                                                                    descending:
                                                                        true),
                                                        singleRecord: true,
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 80.0,
                                                              height: 80.0,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                        Color>(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        List<CommentsRecord>
                                                            listViewCommentsRecordList =
                                                            snapshot.data!;
                                                        // Return an empty Container when the item does not exist.
                                                        if (snapshot
                                                            .data!.isEmpty) {
                                                          return Container();
                                                        }
                                                        final listViewCommentsRecord =
                                                            listViewCommentsRecordList
                                                                    .isNotEmpty
                                                                ? listViewCommentsRecordList
                                                                    .first
                                                                : null;

                                                        return ListView(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          primary: false,
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          children: [
                                                            StreamBuilder<
                                                                List<
                                                                    UsersRecord>>(
                                                              stream:
                                                                  _model.info(
                                                                requestFn: () =>
                                                                    queryUsersRecord(
                                                                  queryBuilder:
                                                                      (usersRecord) =>
                                                                          usersRecord
                                                                              .where(
                                                                    'uid',
                                                                    isEqualTo:
                                                                        listViewCommentsRecord
                                                                            ?.userId
                                                                            ?.id,
                                                                  ),
                                                                  singleRecord:
                                                                      true,
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
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<UsersRecord>
                                                                    rowUsersRecordList =
                                                                    snapshot
                                                                        .data!;
                                                                // Return an empty Container when the item does not exist.
                                                                if (snapshot
                                                                    .data!
                                                                    .isEmpty) {
                                                                  return Container();
                                                                }
                                                                final rowUsersRecord =
                                                                    rowUsersRecordList
                                                                            .isNotEmpty
                                                                        ? rowUsersRecordList
                                                                            .first
                                                                        : null;

                                                                return Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children:
                                                                          [
                                                                        Container(
                                                                          width:
                                                                              40.0,
                                                                          height:
                                                                              40.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              logFirebaseEvent('HOME_PAGE_Image_k7ph0oy0_ON_TAP');
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
                                                                            child:
                                                                                ClipRRect(
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
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
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
                                                                      ].divide(SizedBox(
                                                                              width: 12.0)),
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: wrapWithModel(
                      model: _model.navbarModel,
                      updateCallback: () => safeSetState(() {}),
                      updateOnChange: true,
                      child: NavbarWidget(
                        pageName: MenItems.home,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(1.0, 1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 100.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          logFirebaseEvent('HOME_PAGE_Ktm_ON_TAP');
                          logFirebaseEvent('Ktm_haptic_feedback');
                          HapticFeedback.lightImpact();
                          logFirebaseEvent('Ktm_navigate_to');

                          context.pushNamed(
                            EventsWidget.routeName,
                            queryParameters: {
                              'tabIndex': serializeParam(
                                0,
                                ParamType.int,
                              ),
                            }.withoutNulls,
                          );
                        },
                        child: Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).tertiary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.3,
                              height: MediaQuery.sizeOf(context).width * 1.3,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                'assets/images/event.svg',
                                fit: BoxFit.contain,
                                alignment: Alignment(0.0, 0.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
