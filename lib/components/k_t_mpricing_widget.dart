import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/payment_status_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'k_t_mpricing_model.dart';
export 'k_t_mpricing_model.dart';

class KTMpricingWidget extends StatefulWidget {
  const KTMpricingWidget({
    super.key,
    required this.tournament,
  });

  final TournamentsRow? tournament;

  @override
  State<KTMpricingWidget> createState() => _KTMpricingWidgetState();
}

class _KTMpricingWidgetState extends State<KTMpricingWidget> {
  late KTMpricingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => KTMpricingModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('K_T_MPRICING_KTMpricing_ON_INIT_STATE');
      logFirebaseEvent('KTMpricing_backend_call');
      _model.event = await TournamentsTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'tournament_id',
          widget.tournament?.tournamentId,
        ),
      );
      if (_model.event
              ?.where((e) => widget.tournament?.tournamentId == e.tournamentId)
              .toList()
              .firstOrNull
              ?.isPaid ==
          true) {
        logFirebaseEvent('KTMpricing_navigate_to');

        context.pushNamed(
          EventPageWidget.routeName,
          queryParameters: {
            'tournamentID': serializeParam(
              widget.tournament?.tournamentId,
              ParamType.String,
            ),
          }.withoutNulls,
        );
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
      height: 560.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12.0, 24.0, 12.0, 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Text(
                valueOrDefault<String>(
                  widget.tournament?.name,
                  'Name of Tournament could season 2.0 2024 New Delhi',
                ),
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      font: GoogleFonts.oswald(
                        fontWeight: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight: FlutterFlowTheme.of(context)
                          .headlineMedium
                          .fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
              child: Text(
                'Activate your tournament from draft to upcoming and start sending invites from the app.',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.poppins(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
              child: FutureBuilder<List<SubscriptionsRow>>(
                future: SubscriptionsTable().queryRows(
                  queryFn: (q) => q
                      .eqOrNull(
                        'is_tournament',
                        true,
                      )
                      .order('price', ascending: true),
                  limit: 3,
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
                  List<SubscriptionsRow> inofSubscriptionsRowList =
                      snapshot.data!;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(inofSubscriptionsRowList.length,
                        (inofIndex) {
                      final inofSubscriptionsRow =
                          inofSubscriptionsRowList[inofIndex];
                      return Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        decoration: BoxDecoration(
                          color: widget.tournament?.subscriptionId ==
                                  inofSubscriptionsRow.id
                              ? FlutterFlowTheme.of(context).primaryBackground
                              : FlutterFlowTheme.of(context).primary,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: valueOrDefault<Color>(
                              widget.tournament?.subscriptionId ==
                                      inofSubscriptionsRow.id
                                  ? FlutterFlowTheme.of(context).primaryText
                                  : Color(0xB4F2F0F0),
                              FlutterFlowTheme.of(context).accent4,
                            ),
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    inofSubscriptionsRow.title,
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
                                ].divide(SizedBox(width: 6.0)),
                              ),
                              Text(
                                '₹${inofSubscriptionsRow.price.toString()}',
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.oswald(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).divide(SizedBox(height: 16.0)),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('K_T_MPRICING_CONFIRM__PAY_BTN_ON_TAP');
                  var _shouldSetState = false;
                  logFirebaseEvent('Button_backend_call');
                  _model.token = await PaymentGroup.tokenCall.call();

                  _shouldSetState = true;
                  if ((_model.token?.succeeded ?? true)) {
                    logFirebaseEvent('Button_backend_call');
                    _model.url = await PaymentGroup.createPaymentOrderCall.call(
                      userId: currentUserReference?.id,
                      subscriptionId: widget.tournament?.subscriptionId,
                      tournamentId: widget.tournament?.tournamentId,
                      isTournament: true,
                      redirectUrl: widget.tournament?.tournamentLink,
                    );

                    _shouldSetState = true;
                    if ((_model.url?.succeeded ?? true)) {
                      logFirebaseEvent('Button_custom_action');
                      await actions.callPhonePeCheckout(
                        PaymentGroup.createPaymentOrderCall.url(
                          (_model.url?.jsonBody ?? ''),
                        )!,
                      );
                      logFirebaseEvent('Button_custom_action');
                      _model.code = await actions.generateTournamentCode();
                      _shouldSetState = true;
                      logFirebaseEvent('Button_backend_call');
                      await TournamentsTable().update(
                        data: {
                          'tournament_code': _model.code,
                        },
                        matchingRows: (rows) => rows.eqOrNull(
                          'tournament_id',
                          widget.tournament?.tournamentId,
                        ),
                      );
                      _shouldSetState = true;
                      logFirebaseEvent('Button_bottom_sheet');
                      Navigator.pop(context);
                    } else {
                      logFirebaseEvent('Button_bottom_sheet');
                      Navigator.pop(context);
                    }

                    logFirebaseEvent('Button_bottom_sheet');
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      isDismissible: false,
                      enableDrag: false,
                      context: context,
                      builder: (context) {
                        return WebViewAware(
                          child: Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: PaymentStatusWidget(
                              tournamentid: widget.tournament!,
                            ),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  } else {
                    if (_shouldSetState) safeSetState(() {});
                    return;
                  }

                  if (_shouldSetState) safeSetState(() {});
                },
                text: 'Confirm & Pay',
                icon: Icon(
                  Icons.qr_code_scanner,
                  size: 24.0,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 48.0,
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconColor: FlutterFlowTheme.of(context).primary,
                  color: FlutterFlowTheme.of(context).tertiary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.oswald(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primary,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
