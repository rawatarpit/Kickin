import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/event_add_widget.dart';
import '/components/post_type_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'upload_model.dart';
export 'upload_model.dart';

class UploadWidget extends StatefulWidget {
  const UploadWidget({super.key});

  static String routeName = 'upload';
  static String routePath = 'upload';

  @override
  State<UploadWidget> createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {
  late UploadModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UploadModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'upload'});
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
        title: 'upload',
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
            body: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('UPLOAD_PAGE_Stack_u3mraugh_ON_TAP');
                await Future.wait([
                  Future(() async {
                    logFirebaseEvent('Stack_custom_action');
                    _model.imagesCopy = await actions.selectUploadFiles(
                      '${currentUserDisplayName}_${currentUserUid}',
                      true,
                      false,
                    );
                  }),
                  Future(() async {
                    logFirebaseEvent('Stack_update_page_state');
                    _model.upload = true;
                    safeSetState(() {});
                  }),
                ]);

                safeSetState(() {});
              },
              child: Stack(
                alignment: AlignmentDirectional(0.0, 1.0),
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          12.0, 60.0, 12.0, 40.0),
                      child: SingleChildScrollView(
                        primary: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'UPLOAD_PAGE_publicType_ON_TAP');
                                            logFirebaseEvent(
                                                'publicType_bottom_sheet');
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
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child: Padding(
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                              context),
                                                      child: PostTypeWidget(),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then((value) => safeSetState(
                                                () => _model.type = value));

                                            logFirebaseEvent(
                                                'publicType_update_page_state');
                                            _model.publicType = _model.type!;
                                            safeSetState(() {});

                                            safeSetState(() {});
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .accent4,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      8.0, 12.0, 8.0, 12.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _model.publicType,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleLarge
                                                        .override(
                                                          font: GoogleFonts
                                                              .oswald(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .accent4,
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLarge
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, 0.0),
                                                    child: Icon(
                                                      Icons.arrow_drop_down,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent4,
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 40.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 16.0)),
                                    ),
                                    Stack(
                                      alignment: AlignmentDirectional(1.0, 0.0),
                                      children: [
                                        if (_model.upload == true)
                                          Align(
                                            alignment:
                                                AlignmentDirectional(1.0, 1.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                logFirebaseEvent(
                                                    'UPLOAD_PAGE_Text_ujrb5odh_ON_TAP');
                                                final firestoreBatch =
                                                    FirebaseFirestore.instance
                                                        .batch();
                                                try {
                                                  if (_model.mediaUrl.length >=
                                                      2) {
                                                    logFirebaseEvent(
                                                        'Text_backend_call');

                                                    var postsRecordReference1 =
                                                        PostsRecord.collection
                                                            .doc();
                                                    firestoreBatch.set(
                                                        postsRecordReference1, {
                                                      ...createPostsRecordData(
                                                        postDescription: _model
                                                            .textController
                                                            .text,
                                                        userPost:
                                                            currentUserReference
                                                                ?.id,
                                                        forEveryone:
                                                            _model.type ==
                                                                    'Everyone'
                                                                ? true
                                                                : false,
                                                        postType: 'image',
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'time_posted': FieldValue
                                                              .serverTimestamp(),
                                                          'mediauUrl':
                                                              _model.mediaUrl,
                                                        },
                                                      ),
                                                    });
                                                    _model.notShot = PostsRecord
                                                        .getDocumentFromData({
                                                      ...createPostsRecordData(
                                                        postDescription: _model
                                                            .textController
                                                            .text,
                                                        userPost:
                                                            currentUserReference
                                                                ?.id,
                                                        forEveryone:
                                                            _model.type ==
                                                                    'Everyone'
                                                                ? true
                                                                : false,
                                                        postType: 'image',
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'time_posted':
                                                              DateTime.now(),
                                                          'mediauUrl':
                                                              _model.mediaUrl,
                                                        },
                                                      ),
                                                    }, postsRecordReference1);
                                                    logFirebaseEvent(
                                                        'Text_backend_call');

                                                    firestoreBatch.update(
                                                        _model
                                                            .notShot!.reference,
                                                        createPostsRecordData(
                                                          postsId: _model
                                                              .notShot
                                                              ?.reference
                                                              .id,
                                                        ));
                                                  } else if (_model
                                                          .mediaUrl.length ==
                                                      1) {
                                                    logFirebaseEvent(
                                                        'Text_backend_call');

                                                    var postsRecordReference2 =
                                                        PostsRecord.collection
                                                            .doc();
                                                    firestoreBatch.set(
                                                        postsRecordReference2, {
                                                      ...createPostsRecordData(
                                                        postDescription: _model
                                                            .textController
                                                            .text,
                                                        userPost:
                                                            currentUserReference
                                                                ?.id,
                                                        forEveryone:
                                                            _model.type ==
                                                                    'Everyone'
                                                                ? true
                                                                : false,
                                                        postType: 'shot',
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'time_posted': FieldValue
                                                              .serverTimestamp(),
                                                          'mediauUrl':
                                                              _model.mediaUrl,
                                                        },
                                                      ),
                                                    });
                                                    _model.shot = PostsRecord
                                                        .getDocumentFromData({
                                                      ...createPostsRecordData(
                                                        postDescription: _model
                                                            .textController
                                                            .text,
                                                        userPost:
                                                            currentUserReference
                                                                ?.id,
                                                        forEveryone:
                                                            _model.type ==
                                                                    'Everyone'
                                                                ? true
                                                                : false,
                                                        postType: 'shot',
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'time_posted':
                                                              DateTime.now(),
                                                          'mediauUrl':
                                                              _model.mediaUrl,
                                                        },
                                                      ),
                                                    }, postsRecordReference2);
                                                    logFirebaseEvent(
                                                        'Text_backend_call');

                                                    firestoreBatch.update(
                                                        _model.shot!.reference,
                                                        createPostsRecordData(
                                                          postsId: _model.shot
                                                              ?.reference.id,
                                                        ));
                                                  } else if (_model.isEvent!) {
                                                    logFirebaseEvent(
                                                        'Text_backend_call');

                                                    var postsRecordReference3 =
                                                        PostsRecord.collection
                                                            .doc();
                                                    firestoreBatch.set(
                                                        postsRecordReference3, {
                                                      ...createPostsRecordData(
                                                        postDescription: _model
                                                            .textController
                                                            .text,
                                                        userPost:
                                                            currentUserReference
                                                                ?.id,
                                                        forEveryone:
                                                            _model.type ==
                                                                    'Everyone'
                                                                ? true
                                                                : false,
                                                        eventDetails:
                                                            updateEventDetailsStruct(
                                                          _model.events,
                                                          clearUnsetFields:
                                                              false,
                                                          create: true,
                                                        ),
                                                        postType: 'event',
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'time_posted': FieldValue
                                                              .serverTimestamp(),
                                                        },
                                                      ),
                                                    });
                                                    _model.event = PostsRecord
                                                        .getDocumentFromData({
                                                      ...createPostsRecordData(
                                                        postDescription: _model
                                                            .textController
                                                            .text,
                                                        userPost:
                                                            currentUserReference
                                                                ?.id,
                                                        forEveryone:
                                                            _model.type ==
                                                                    'Everyone'
                                                                ? true
                                                                : false,
                                                        eventDetails:
                                                            updateEventDetailsStruct(
                                                          _model.events,
                                                          clearUnsetFields:
                                                              false,
                                                          create: true,
                                                        ),
                                                        postType: 'event',
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'time_posted':
                                                              DateTime.now(),
                                                        },
                                                      ),
                                                    }, postsRecordReference3);
                                                    logFirebaseEvent(
                                                        'Text_backend_call');

                                                    firestoreBatch.update(
                                                        _model.event!.reference,
                                                        createPostsRecordData(
                                                          postsId: _model.event
                                                              ?.reference.id,
                                                        ));
                                                  } else {
                                                    logFirebaseEvent(
                                                        'Text_backend_call');

                                                    var postsRecordReference4 =
                                                        PostsRecord.collection
                                                            .doc();
                                                    firestoreBatch.set(
                                                        postsRecordReference4, {
                                                      ...createPostsRecordData(
                                                        postDescription: _model
                                                            .textController
                                                            .text,
                                                        userPost:
                                                            currentUserReference
                                                                ?.id,
                                                        forEveryone:
                                                            _model.type ==
                                                                    'Everyone'
                                                                ? true
                                                                : false,
                                                        postType: 'post',
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'time_posted': FieldValue
                                                              .serverTimestamp(),
                                                        },
                                                      ),
                                                    });
                                                    _model.write = PostsRecord
                                                        .getDocumentFromData({
                                                      ...createPostsRecordData(
                                                        postDescription: _model
                                                            .textController
                                                            .text,
                                                        userPost:
                                                            currentUserReference
                                                                ?.id,
                                                        forEveryone:
                                                            _model.type ==
                                                                    'Everyone'
                                                                ? true
                                                                : false,
                                                        postType: 'post',
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'time_posted':
                                                              DateTime.now(),
                                                        },
                                                      ),
                                                    }, postsRecordReference4);
                                                    logFirebaseEvent(
                                                        'Text_backend_call');

                                                    firestoreBatch.update(
                                                        _model.write!.reference,
                                                        createPostsRecordData(
                                                          postsId: _model.write
                                                              ?.reference.id,
                                                        ));
                                                  }

                                                  logFirebaseEvent(
                                                      'Text_navigate_to');

                                                  context.pushNamed(
                                                      HomeWidget.routeName);
                                                } finally {
                                                  await firestoreBatch.commit();
                                                }

                                                safeSetState(() {});
                                              },
                                              child: Text(
                                                'Post',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .titleLarge
                                                    .override(
                                                      font: GoogleFonts.oswald(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        if (_model.upload == true)
                                          Text(
                                            'Uploading',
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .override(
                                                  font: GoogleFonts.oswald(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleLarge
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .accent4,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .fontStyle,
                                                ),
                                          ),
                                      ],
                                    ),
                                  ].divide(SizedBox(width: 16.0)),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: _model.textController,
                                      focusNode: _model.textFieldFocusNode,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.poppins(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                        hintText: 'Create A New Post ',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.poppins(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent4,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .accent4,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                12.0, 18.0, 12.0, 18.0),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      maxLines: 5,
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      validator: _model.textControllerValidator
                                          .asValidator(context),
                                    ),
                                  ].divide(SizedBox(height: 16.0)),
                                ),
                                if ((FFAppState().PreviewUrls.length >= 1) &&
                                    (_model.isEvent == false))
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 60.0),
                                    child: Builder(
                                      builder: (context) {
                                        final media = FFAppState()
                                            .PreviewUrls
                                            .toList()
                                            .take(5)
                                            .toList();

                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: List.generate(
                                                    media.length, (mediaIndex) {
                                              final mediaItem =
                                                  media[mediaIndex];
                                              return Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.9,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: 400.0,
                                                      child: custom_widgets
                                                          .SimpleMediaPreview(
                                                        width: double.infinity,
                                                        height: 400.0,
                                                        url: mediaItem,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    16.0,
                                                                    16.0,
                                                                    0.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            logFirebaseEvent(
                                                                'UPLOAD_PAGE_Icon_i3352cv7_ON_TAP');
                                                            logFirebaseEvent(
                                                                'Icon_update_app_state');
                                                            FFAppState()
                                                                .removeFromPreviewUrls(
                                                                    mediaItem);
                                                            safeSetState(() {});
                                                            logFirebaseEvent(
                                                                'Icon_update_page_state');
                                                            _model
                                                                .removeFromMediaUrl(
                                                                    mediaItem);
                                                            safeSetState(() {});
                                                            logFirebaseEvent(
                                                                'Icon_backend_call');
                                                            _model.apiResultkwv =
                                                                await DeleteFileCall
                                                                    .call(
                                                              publicUrl:
                                                                  mediaItem,
                                                            );

                                                            safeSetState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .highlight_off_rounded,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .accent4,
                                                            size: 26.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
                                                .divide(SizedBox(width: 4.0))
                                                .addToStart(
                                                    SizedBox(width: 2.0)),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                if (_model.isEvent == true)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 60.0),
                                    child: Container(
                                      width: 365.0,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(8.0),
                                                topRight: Radius.circular(8.0),
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(8.0),
                                                topRight: Radius.circular(8.0),
                                              ),
                                              child: Image.network(
                                                _model.events!.imageUrl,
                                                width: double.infinity,
                                                height: 200.0,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(8.0),
                                                bottomRight:
                                                    Radius.circular(8.0),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 24.0, 16.0, 24.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                          _model.events
                                                              ?.eventName,
                                                          'Event Name',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .oswald(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
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
                                                            _model.events
                                                                ?.description,
                                                            'Description jsa sjjhfjb jhsdncjn kjsahfnkdncn jashdkjbas jdfbdc',
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .accent4,
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
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    8.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                _model.events
                                                                    ?.time,
                                                                '08:30 AM',
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
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
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .accent4,
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
                                                            SizedBox(
                                                              height: 25.0,
                                                              child:
                                                                  VerticalDivider(
                                                                thickness: 1.0,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .accent4,
                                                              ),
                                                            ),
                                                            Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                _model.events
                                                                    ?.date,
                                                                '20/01/2026',
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
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
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .accent4,
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
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    12.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Builder(
                                                          builder: (context) {
                                                            final auidence = (_model
                                                                        .events
                                                                        ?.audience
                                                                        .toList() ??
                                                                    [])
                                                                .take(7)
                                                                .toList();

                                                            return Wrap(
                                                              spacing: 16.0,
                                                              runSpacing: 12.0,
                                                              alignment:
                                                                  WrapAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  WrapCrossAlignment
                                                                      .start,
                                                              direction: Axis
                                                                  .horizontal,
                                                              runAlignment:
                                                                  WrapAlignment
                                                                      .start,
                                                              verticalDirection:
                                                                  VerticalDirection
                                                                      .down,
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: List.generate(
                                                                  auidence
                                                                      .length,
                                                                  (auidenceIndex) {
                                                                final auidenceItem =
                                                                    auidence[
                                                                        auidenceIndex];
                                                                return Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            24.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .accent4,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            24.0,
                                                                            10.0,
                                                                            24.0,
                                                                            10.0),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        auidenceItem,
                                                                        'Player',
                                                                      ),
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
                                                                                FlutterFlowTheme.of(context).accent4,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Container(
                      width: double.infinity,
                      height: 100.0,
                      decoration: BoxDecoration(),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
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
                                      'UPLOAD_PAGE_image_upload_ON_TAP');
                                  await Future.wait([
                                    Future(() async {
                                      logFirebaseEvent(
                                          'image_upload_custom_action');
                                      _model.images =
                                          await actions.selectUploadFiles(
                                        '${currentUserDisplayName}_${currentUserUid}',
                                        true,
                                        false,
                                      );
                                    }),
                                    Future(() async {
                                      logFirebaseEvent(
                                          'image_upload_update_page_state');
                                      _model.upload = true;
                                      safeSetState(() {});
                                    }),
                                  ]);
                                  if (_model.images!.length >= 1) {
                                    logFirebaseEvent(
                                        'image_upload_update_page_state');
                                    _model.upload = false;
                                    _model.mediaUrl =
                                        _model.images!.toList().cast<String>();
                                    safeSetState(() {});
                                  } else {
                                    logFirebaseEvent(
                                        'image_upload_update_page_state');
                                    _model.upload = false;
                                    safeSetState(() {});
                                  }

                                  safeSetState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).accent4,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.image_outlined,
                                      color:
                                          FlutterFlowTheme.of(context).accent4,
                                      size: 28.0,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'UPLOAD_PAGE_video_upload_ON_TAP');
                                  await Future.wait([
                                    Future(() async {
                                      logFirebaseEvent(
                                          'video_upload_custom_action');
                                      _model.video =
                                          await actions.selectUploadFiles(
                                        '${currentUserDisplayName}_${currentUserUid}',
                                        false,
                                        true,
                                      );
                                    }),
                                    Future(() async {
                                      logFirebaseEvent(
                                          'video_upload_update_page_state');
                                      _model.upload = true;
                                      safeSetState(() {});
                                    }),
                                  ]);
                                  if (_model.video!.length >= 1) {
                                    logFirebaseEvent(
                                        'video_upload_update_page_state');
                                    _model.upload = false;
                                    _model.mediaUrl =
                                        _model.video!.toList().cast<String>();
                                    safeSetState(() {});
                                  } else {
                                    logFirebaseEvent(
                                        'video_upload_update_page_state');
                                    _model.upload = false;
                                    safeSetState(() {});
                                  }

                                  safeSetState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).accent4,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.ondemand_video_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).accent4,
                                      size: 28.0,
                                    ),
                                  ),
                                ),
                              ),
                              if (_model.mediaUrl.length >= 1)
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'UPLOAD_PAGE_event_upload_ON_TAP');
                                    logFirebaseEvent(
                                        'event_upload_bottom_sheet');
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return WebViewAware(
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Padding(
                                              padding: MediaQuery.viewInsetsOf(
                                                  context),
                                              child: EventAddWidget(),
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(
                                        () => _model.events = value));

                                    if (_model.events != null) {
                                      logFirebaseEvent(
                                          'event_upload_update_page_state');

                                      safeSetState(() {});
                                    }

                                    safeSetState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(4.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .accent4,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.event_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .accent4,
                                        size: 28.0,
                                      ),
                                    ),
                                  ),
                                ),
                            ].divide(SizedBox(width: 24.0)),
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
