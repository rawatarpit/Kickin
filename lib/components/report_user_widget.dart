import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'report_user_model.dart';
export 'report_user_model.dart';

class ReportUserWidget extends StatefulWidget {
  const ReportUserWidget({
    super.key,
    required this.userdocRef,
    String? name,
  }) : this.name = name ?? 'name';

  final DocumentReference? userdocRef;
  final String name;

  @override
  State<ReportUserWidget> createState() => _ReportUserWidgetState();
}

class _ReportUserWidgetState extends State<ReportUserWidget> {
  late ReportUserModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReportUserModel());

    _model.reportInutTextController ??= TextEditingController();
    _model.reportInutFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primary,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 40.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Report User',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  font: GoogleFonts.oswald(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'REPORT_USER_COMP_Icon_c9dfqcxy_ON_TAP');
                              logFirebaseEvent('Icon_bottom_sheet');
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close_sharp,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 26.0,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(),
                        child: TextFormField(
                          controller: _model.reportInutTextController,
                          focusNode: _model.reportInutFocusNode,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Short Description',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                            hintText:
                                'Please state the reasons for reporting the user',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).accent4,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 18.0, 12.0, 18.0),
                            hoverColor: FlutterFlowTheme.of(context).accent4,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.poppins(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                          maxLines: 3,
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.reportInutTextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ].divide(SizedBox(height: 24.0)),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'REPORT_USER_COMP_Button_3uwtbrlz_ON_TAP');
                        final firestoreBatch =
                            FirebaseFirestore.instance.batch();
                        try {
                          logFirebaseEvent('Button_backend_call');

                          firestoreBatch.set(
                              ReporteRecord.createDoc(currentUserReference!), {
                            ...createReporteRecordData(
                              userId: widget.userdocRef,
                              comment: _model.reportInutTextController.text,
                            ),
                            ...mapToFirestore(
                              {
                                'timestamp': FieldValue.serverTimestamp(),
                              },
                            ),
                          });
                          logFirebaseEvent('Button_navigate_to');

                          context.pushNamed(HomeWidget.routeName);

                          logFirebaseEvent('Button_send_email');
                          await launchUrl(Uri(
                              scheme: 'mailto',
                              path: 'arpit@kickin.in',
                              query: {
                                'subject':
                                    'User reported ${widget.name} by ${currentUserDisplayName}',
                                'body': _model.reportInutTextController.text,
                              }
                                  .entries
                                  .map((MapEntry<String, String> e) =>
                                      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                  .join('&')));
                          logFirebaseEvent('Button_backend_call');

                          firestoreBatch.update(currentUserReference!, {
                            ...mapToFirestore(
                              {
                                'blockedList': FieldValue.arrayUnion(
                                    [widget.userdocRef?.id]),
                              },
                            ),
                          });
                          logFirebaseEvent('Button_backend_call');

                          firestoreBatch.update(widget.userdocRef!, {
                            ...mapToFirestore(
                              {
                                'blockedList': FieldValue.arrayUnion(
                                    [currentUserReference?.id]),
                              },
                            ),
                          });
                          logFirebaseEvent('Button_backend_call');

                          firestoreBatch.set(
                              BlockedRecord.createDoc(currentUserReference!), {
                            ...createBlockedRecordData(
                              userId: widget.userdocRef,
                              byCurrentUser: true,
                            ),
                            ...mapToFirestore(
                              {
                                'timestamp': FieldValue.serverTimestamp(),
                              },
                            ),
                          });
                          logFirebaseEvent('Button_backend_call');

                          firestoreBatch.set(
                              BlockedRecord.createDoc(widget.userdocRef!), {
                            ...createBlockedRecordData(
                              userId: currentUserReference,
                              byCurrentUser: false,
                            ),
                            ...mapToFirestore(
                              {
                                'timestamp': FieldValue.serverTimestamp(),
                              },
                            ),
                          });
                          logFirebaseEvent('Button_backend_call');

                          firestoreBatch.update(widget.userdocRef!, {
                            ...mapToFirestore(
                              {
                                'connectedList': FieldValue.arrayRemove(
                                    [currentUserReference?.id]),
                              },
                            ),
                          });
                          logFirebaseEvent('Button_backend_call');

                          firestoreBatch.update(currentUserReference!, {
                            ...mapToFirestore(
                              {
                                'connectedList': FieldValue.arrayRemove(
                                    [widget.userdocRef?.id]),
                              },
                            ),
                          });
                        } finally {
                          await firestoreBatch.commit();
                        }
                      },
                      text: 'Report ${widget.name}',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 16.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).tertiary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  font: GoogleFonts.oswald(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).primary,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 24.0)),
              ),
            ),
          ].divide(SizedBox(height: 24.0)),
        ),
      ),
    );
  }
}
