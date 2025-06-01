import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'input_model.dart';
export 'input_model.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({
    super.key,
    required this.creatorID,
    this.storyId,
    bool? imageUpload,
  }) : this.imageUpload = imageUpload ?? false;

  final String? creatorID;
  final String? storyId;
  final bool imageUpload;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late InputModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InputModel());

    _model.inputMessageTextController ??= TextEditingController();
    _model.inputMessageFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(1.0, 1.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        child: Stack(
          alignment: AlignmentDirectional(1.0, 1.0),
          children: [
            Container(
              decoration: BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(-1.0, 1.0),
                      child: TextFormField(
                        controller: _model.inputMessageTextController,
                        focusNode: _model.inputMessageFocusNode,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                          hintText: 'Send message',
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
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
                              color: FlutterFlowTheme.of(context).accent4,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).secondary,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          fillColor: FlutterFlowTheme.of(context).secondary,
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 22.0, 12.0, 22.0),
                          hoverColor: FlutterFlowTheme.of(context).accent4,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                        maxLines: 5,
                        minLines: 1,
                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                        validator: _model.inputMessageTextControllerValidator
                            .asValidator(context),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(1.0, 1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                      child: FlutterFlowIconButton(
                        borderRadius: 8.0,
                        buttonSize: 48.0,
                        fillColor: FlutterFlowTheme.of(context).tertiary,
                        icon: Icon(
                          Icons.send_rounded,
                          color: FlutterFlowTheme.of(context).secondary,
                          size: 22.0,
                        ),
                        onPressed: () async {
                          logFirebaseEvent(
                              'INPUT_COMP_send_rounded_ICN_ON_TAP');
                          logFirebaseEvent('IconButton_custom_action');
                          unawaited(
                            () async {
                              await actions.hideKeyboard(
                                context,
                              );
                            }(),
                          );
                          logFirebaseEvent('IconButton_backend_call');
                          _model.chat = await ConversationCall.call(
                            senderId: currentUserReference?.id,
                            receiverId: widget.creatorID,
                            text: _model.inputMessageTextController.text,
                            type: 'text',
                            storyId: widget.storyId,
                          );

                          logFirebaseEvent('IconButton_reset_form_fields');
                          safeSetState(() {
                            _model.inputMessageTextController?.clear();
                          });
                          logFirebaseEvent('IconButton_show_snack_bar');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Message Sent.',
                                style: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          );
                          logFirebaseEvent('IconButton_custom_action');
                          _model.creatorUser =
                              await actions.getDocumentRefFromCollection(
                            'users',
                            widget.creatorID!,
                          );
                          logFirebaseEvent(
                              'IconButton_trigger_push_notification');
                          triggerPushNotification(
                            notificationTitle: currentUserDisplayName,
                            notificationText: 'repiled on your story',
                            notificationSound: 'default',
                            userRefs: [_model.creatorUser!],
                            initialPageName: 'inbox',
                            parameterData: {},
                          );

                          safeSetState(() {});
                        },
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 8.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
