import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'refund_policy_model.dart';
export 'refund_policy_model.dart';

class RefundPolicyWidget extends StatefulWidget {
  const RefundPolicyWidget({super.key});

  static String routeName = 'refund_policy';
  static String routePath = 'refund_policy';

  @override
  State<RefundPolicyWidget> createState() => _RefundPolicyWidgetState();
}

class _RefundPolicyWidgetState extends State<RefundPolicyWidget> {
  late RefundPolicyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RefundPolicyModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'refund_policy'});
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
        title: 'Refund Policy',
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
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 24.0, 0.0, 0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: SvgPicture.network(
                          'https://grbbdskhtdettoddpxfl.supabase.co/storage/v1/object/public/storage/assest/Kickin%20Logo.svg',
                          width: 45.0,
                          height: 45.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Refund Policy',
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
                              Text(
                                'This Refund and Cancellation Policy applies to all payments made for the Kickin Tournament Management (KTM) services via the Kickin App or platform. By using the KTM service, you agree to the terms outlined in this policy.\n\nService Overview\n\nKTM (Kickin Tournament Management) enables organizers to manage football tournaments using the Kickin platform. Services may include player registration, fixture creation, real-time updates, analytics, and team communications.\n\nThe fee for using KTM ranges from ₹500 to ₹2000 depending on the scale and features selected.\n\nCancellation Policy\n\nCancellations will be considered only if a written request is made within 2 days of payment and at least 72 hours before the scheduled tournament start date.\n\nCancellation requests made after tournament planning has begun (e.g., fixtures created, teams notified, or any backend setup) will not be eligible for a full refund.\n\nNo cancellation will be entertained on the day of or after the tournament start date.\n\nRefund Policy\n\nRefunds may be granted under the following conditions:\n\nFull Refund: If the request is made within 2 days of payment and prior to any backend setup activity.\n\nPartial Refund: If some tournament setup work has begun but the tournament has not started, a partial refund may be issued after deducting applicable setup charges.\n\nNo Refund: No refund will be processed once the tournament has started or if the cancellation request is received after the fixture creation and team confirmation have been completed.\n\nExceptions to Refunds\n\nRefunds will not be provided for user errors (e.g., wrong tournament setup request, duplicate payment unless proven).\n\nNo refund for any tournament where Kickin has provided substantial customization, setup effort, or promotional support.\n\nRefunds will not be processed for dissatisfaction due to subjective preferences once the service has been rendered as per agreement.\n\nRefund Processing Timeline\n\nIf approved, refunds will be processed within 7–10 business days to the original payment method. Confirmation of the refund process will be sent via SMS or email.\n\nDispute Resolution\n\nIf you believe a refund was unfairly denied or you wish to appeal a cancellation decision, please contact our support team with your payment ID and details of the issue at:\n\nSupport Contact:\n\nArpit Singh Rawat\nPhone: +91 9821990780\nEmail: arpit@kickin.in\nWebsite: https://kickin.in\n\nChange in Policy\n\nKickin reserves the right to amend this Refund and Cancellation Policy at any time. Any changes will be updated on our website or notified within the App.',
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
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ].divide(SizedBox(height: 24.0)),
                          ),
                        ].divide(SizedBox(height: 24.0)),
                      ),
                    ),
                  ].divide(SizedBox(height: 32.0)),
                ),
              ),
            ),
          ),
        ));
  }
}
