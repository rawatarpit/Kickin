import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/loading_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'payment_status_model.dart';
export 'payment_status_model.dart';

class PaymentStatusWidget extends StatefulWidget {
  const PaymentStatusWidget({
    super.key,
    required this.tournamentid,
  });

  final TournamentsRow? tournamentid;

  @override
  State<PaymentStatusWidget> createState() => _PaymentStatusWidgetState();
}

class _PaymentStatusWidgetState extends State<PaymentStatusWidget> {
  late PaymentStatusModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentStatusModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PAYMENT_STATUS_paymentStatus_ON_INIT_STA');
      logFirebaseEvent('paymentStatus_backend_call');
      _model.apiResultamp = await PaymentGroup.orderStatusCall.call(
        phonepeMerchantOrderId: widget.tournamentid?.merchantOrderId,
      );

      if (PaymentGroup.orderStatusCall.state(
            (_model.apiResultamp?.jsonBody ?? ''),
          ) ==
          'COMPLETED') {
        logFirebaseEvent('paymentStatus_backend_call');
        await PaymentsTable().update(
          data: {
            'status': 'COMPLETED',
          },
          matchingRows: (rows) => rows.eqOrNull(
            'phonepe_merchant_order_id',
            widget.tournamentid?.merchantOrderId,
          ),
        );
        logFirebaseEvent('paymentStatus_wait__delay');
        await Future.delayed(const Duration(milliseconds: 1000));
        logFirebaseEvent('paymentStatus_navigate_to');

        context.pushNamed(
          EventDetailsorgWidget.routeName,
          queryParameters: {
            'tabNumber': serializeParam(
              0,
              ParamType.int,
            ),
            'tournamentId': serializeParam(
              widget.tournamentid?.tournamentId,
              ParamType.String,
            ),
          }.withoutNulls,
        );
      } else if (PaymentGroup.orderStatusCall.state(
            (_model.apiResultamp?.jsonBody ?? ''),
          ) ==
          'PENDING') {
        return;
      } else {
        return;
      }
    });

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
      width: double.infinity,
      height: 480.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12.0, 32.0, 12.0, 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Status',
              style: FlutterFlowTheme.of(context).headlineLarge.override(
                    font: GoogleFonts.oswald(
                      fontWeight:
                          FlutterFlowTheme.of(context).headlineLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineLarge.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                  ),
            ),
            Builder(
              builder: (context) {
                if (PaymentGroup.orderStatusCall.state(
                      (_model.apiResultamp?.jsonBody ?? ''),
                    ) ==
                    'FAILED') {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Icon(
                          Icons.error_outline,
                          color: Color(0xFFF13838),
                          size: 120.0,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: Text(
                          'Payment Failed',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                font: GoogleFonts.oswald(
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontStyle,
                              ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: Text(
                          'Transcation failed.Please try again after 5 mins.',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.oswald(
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    width: double.infinity,
                    height: 230.0,
                    decoration: BoxDecoration(),
                    child: wrapWithModel(
                      model: _model.loadingModel,
                      updateCallback: () => safeSetState(() {}),
                      child: LoadingWidget(),
                    ),
                  );
                }
              },
            ),
            if (PaymentGroup.orderStatusCall.state(
                  (_model.apiResultamp?.jsonBody ?? ''),
                ) ==
                'FAILED')
              FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('PAYMENT_STATUS_RASIE_QUERY_BTN_ON_TAP');
                  logFirebaseEvent('Button_send_email');
                  await launchUrl(Uri(
                      scheme: 'mailto',
                      path: 'arpit@kickin.in',
                      query: {
                        'subject': 'Payment Issue',
                        'body':
                            '${currentUserReference?.id}         ${currentUserDisplayName}        ${(_model.apiResultamp?.jsonBody ?? '').toString()}',
                      }
                          .entries
                          .map((MapEntry<String, String> e) =>
                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                          .join('&')));
                  logFirebaseEvent('Button_show_snack_bar');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Email Sent.',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                    ),
                  );
                  logFirebaseEvent('Button_bottom_sheet');
                  Navigator.pop(context);
                  logFirebaseEvent('Button_navigate_to');

                  context.pushNamed(
                    PreviewEventPageWidget.routeName,
                    queryParameters: {
                      'tournamentId': serializeParam(
                        widget.tournamentid?.tournamentId,
                        ParamType.String,
                      ),
                    }.withoutNulls,
                  );
                },
                text: 'Rasie Query',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 50.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.oswald(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: Colors.white,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primaryText,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
          ].divide(SizedBox(height: 40.0)),
        ),
      ),
    );
  }
}
