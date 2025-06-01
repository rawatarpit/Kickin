import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/comment_screen_widget.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'kickin_shot_model.dart';
export 'kickin_shot_model.dart';

class KickinShotWidget extends StatefulWidget {
  const KickinShotWidget({
    super.key,
    this.postID,
  });

  final DocumentReference? postID;

  static String routeName = 'kickin_shot';
  static String routePath = 'kickin_shot';

  @override
  State<KickinShotWidget> createState() => _KickinShotWidgetState();
}

class _KickinShotWidgetState extends State<KickinShotWidget> {
  late KickinShotModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => KickinShotModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'kickin_shot'});
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
        title: 'kickin_shot',
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
                ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      child: PagedPageView<DocumentSnapshot<Object?>?,
                          PostsRecord>(
                        pagingController: _model.setDefaultPageViewController(
                          PostsRecord.collection.where(
                            'is_shot',
                            isEqualTo: true,
                            isNull: (true) == null,
                          ),
                        ),
                        pageController: _model.defaultPageViewController ??=
                            PageController(
                                initialPage: max(
                                    0,
                                    min(
                                        0,
                                        _model.defaultPageViewLoadedLength -
                                            1))),
                        onPageChanged: (_) => safeSetState(() {
                          _model.defaultPageViewLoadedLength = _model
                              .defaultPageViewPagingController!
                              .itemList!
                              .length;
                        }),
                        scrollDirection: Axis.vertical,
                        builderDelegate: PagedChildBuilderDelegate<PostsRecord>(
                          // Customize what your widget looks like when it's loading the first page.
                          firstPageProgressIndicatorBuilder: (_) => Center(
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
                          // Customize what your widget looks like when it's loading another page.
                          newPageProgressIndicatorBuilder: (_) => Center(
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

                          itemBuilder: (context, _, defaultPageViewIndex) {
                            final defaultPageViewPostsRecord = _model
                                .defaultPageViewPagingController!
                                .itemList![defaultPageViewIndex];
                            return Stack(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              1.0,
                                      child: custom_widgets.DisplayMedia(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                1.0,
                                        url: defaultPageViewPostsRecord
                                            .mediauUrl.firstOrNull!,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 0.0, 120.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.75,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 12.0, 0.0),
                                        child: StreamBuilder<List<UsersRecord>>(
                                          stream: _model.info(
                                            requestFn: () => queryUsersRecord(
                                              queryBuilder: (usersRecord) =>
                                                  usersRecord.where(
                                                'uid',
                                                isEqualTo:
                                                    defaultPageViewPostsRecord
                                                        .userPost,
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
                                            if (snapshot.data!.isEmpty) {
                                              return Container();
                                            }
                                            final rowUsersRecord =
                                                rowUsersRecordList.isNotEmpty
                                                    ? rowUsersRecordList.first
                                                    : null;

                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
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
                                                        'KICKIN_SHOT_CircleImage_v88ulaja_ON_TAP');
                                                    logFirebaseEvent(
                                                        'CircleImage_navigate_to');

                                                    context.pushNamed(
                                                      OtherprofileWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'id': serializeParam(
                                                          rowUsersRecord
                                                              .reference.id,
                                                          ParamType.String,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 50.0,
                                                    height: 50.0,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: CachedNetworkImage(
                                                      fadeInDuration: Duration(
                                                          milliseconds: 500),
                                                      fadeOutDuration: Duration(
                                                          milliseconds: 500),
                                                      imageUrl: rowUsersRecord!
                                                          .photoUrl,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      valueOrDefault<String>(
                                                        rowUsersRecord
                                                            .displayName,
                                                        'Name',
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
                                                                fontSize: 16.0,
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
                                                    Container(
                                                      width: 210.0,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          defaultPageViewPostsRecord
                                                              .postDescription,
                                                          'caption about the kickin shot and if it\'s pretty long thne hwat am i gonna do?',
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
                                                    ),
                                                  ],
                                                ),
                                              ].divide(SizedBox(width: 16.0)),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 12.0, 200.0),
                                    child: Container(
                                      width: 70.0,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Stack(
                                            children: [
                                              if (defaultPageViewPostsRecord
                                                      .likes
                                                      .contains(
                                                          currentUserReference) ==
                                                  false)
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 8.0),
                                                  child: InkWell(
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
                                                          'KICKIN_SHOT_PAGE_Icon_6wiv27y5_ON_TAP');
                                                      var _shouldSetState =
                                                          false;
                                                      logFirebaseEvent(
                                                          'Icon_backend_call');

                                                      await defaultPageViewPostsRecord
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
                                                      if (defaultPageViewPostsRecord
                                                              .userPost ==
                                                          currentUserReference
                                                              ?.id) {
                                                        if (_shouldSetState)
                                                          safeSetState(() {});
                                                        return;
                                                      }

                                                      logFirebaseEvent(
                                                          'Icon_backend_call');
                                                      await NotificationsTable()
                                                          .insert({
                                                        'receiver_id':
                                                            defaultPageViewPostsRecord
                                                                .userPost,
                                                        'sender_id':
                                                            currentUserUid,
                                                        'type': NotificationType
                                                            .Like.name,
                                                        'message':
                                                            '${FFAppState().name}    Liked Your Post',
                                                        'is_read': false,
                                                        'created_at': supaSerialize<
                                                                DateTime>(
                                                            getCurrentTimestamp),
                                                        'post_id':
                                                            defaultPageViewPostsRecord
                                                                .reference.id,
                                                      });
                                                      logFirebaseEvent(
                                                          'Icon_custom_action');
                                                      _model.shotUser =
                                                          await actions
                                                              .getDocumentRefFromCollection(
                                                        'users',
                                                        defaultPageViewPostsRecord
                                                            .userPost,
                                                      );
                                                      _shouldSetState = true;
                                                      logFirebaseEvent(
                                                          'Icon_trigger_push_notification');
                                                      triggerPushNotification(
                                                        notificationTitle:
                                                            currentUserDisplayName,
                                                        notificationText:
                                                            'Liked Your Shot.',
                                                        notificationSound:
                                                            'default',
                                                        userRefs: [
                                                          _model.shotUser!
                                                        ],
                                                        initialPageName:
                                                            'indiviual_post',
                                                        parameterData: {
                                                          'postId':
                                                              defaultPageViewPostsRecord
                                                                  .reference.id,
                                                        },
                                                      );
                                                      if (_shouldSetState)
                                                        safeSetState(() {});
                                                    },
                                                    child: Icon(
                                                      Icons.favorite_border,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 32.0,
                                                    ),
                                                  ),
                                                ),
                                              if (defaultPageViewPostsRecord
                                                      .likes
                                                      .contains(
                                                          currentUserReference) ==
                                                  true)
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
                                                        'KICKIN_SHOT_PAGE_Icon_ousqy5q4_ON_TAP');
                                                    logFirebaseEvent(
                                                        'Icon_backend_call');

                                                    await defaultPageViewPostsRecord
                                                        .reference
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'likes': FieldValue
                                                              .arrayRemove([
                                                            currentUserReference
                                                          ]),
                                                        },
                                                      ),
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.favorite_sharp,
                                                    color: Color(0xFFFF1726),
                                                    size: 32.0,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 16.0),
                                            child: Text(
                                              formatNumber(
                                                defaultPageViewPostsRecord
                                                    .likes.length,
                                                formatType: FormatType.compact,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.poppins(
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
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 16.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'KICKIN_SHOT_PAGE_comment_ON_TAP');
                                                logFirebaseEvent(
                                                    'comment_custom_action');
                                                _model.shotUsers = await actions
                                                    .getDocumentRefFromCollection(
                                                  'users',
                                                  defaultPageViewPostsRecord
                                                      .userPost,
                                                );
                                                logFirebaseEvent(
                                                    'comment_bottom_sheet');
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return WebViewAware(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        },
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child: Container(
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.8,
                                                            child:
                                                                CommentScreenWidget(
                                                              postId:
                                                                  defaultPageViewPostsRecord,
                                                              creator: _model
                                                                  .shotUsers!,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));

                                                safeSetState(() {});
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: SvgPicture.asset(
                                                  'assets/images/Comment.svg',
                                                  width: 32.0,
                                                  height: 32.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: SvgPicture.asset(
                                              'assets/images/send_white.svg',
                                              width: 32.0,
                                              height: 32.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: wrapWithModel(
                    model: _model.navbarModel,
                    updateCallback: () => safeSetState(() {}),
                    updateOnChange: true,
                    child: NavbarWidget(
                      pageName: MenItems.shots,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
