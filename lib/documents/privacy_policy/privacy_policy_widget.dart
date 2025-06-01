import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'privacy_policy_model.dart';
export 'privacy_policy_model.dart';

class PrivacyPolicyWidget extends StatefulWidget {
  const PrivacyPolicyWidget({super.key});

  static String routeName = 'privacyPolicy';
  static String routePath = 'PrivacyPolicy';

  @override
  State<PrivacyPolicyWidget> createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget> {
  late PrivacyPolicyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrivacyPolicyModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'privacyPolicy'});
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
        title: 'Privacy Policy',
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
                                'Privacy Policy',
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
                                'This Privacy Policy describes how Kickin (referred to as “Kickin,” “we,” “our,” or “us”) collects, uses, shares, and protects personal information when you use our mobile application, website, and related services (collectively, the “App” or “Platform”). Kickin is operated by Arpit Singh Rawat, sole proprietor, registered under Udyam in Delhi, India.\n\nBy accessing or using the App, you agree to the collection and use of your personal information in accordance with this Privacy Policy. If you do not agree with any part of this policy, please refrain from using the App.\n\nInformation We Collect\na) Personal Information\n\nWhen you register or use certain features of the App, we may collect personally identifiable information, including:\n\nFull name\nEmail address\nPhone number\nProfile photo\nSocial media handle (optional)\n\nb) Usage Data\n\nWe automatically collect technical data when you use the App, including:\n\nIP address\nDevice type and identifiers\nOperating system and browser type\nApp usage activity (e.g., screens viewed, time spent, errors encountered)\n\nc) Location Data\n\nIf you enable location permissions, we may collect GPS-based location data to provide location-specific features, such as nearby tournaments or events.\n\nd) Media Access\n\nWe may request access to your device’s:\n\nCamera and gallery (to upload photos/videos)\n\nMicrophone (for voice features or live interactions)\n\ne) Notifications\n\nWe may send push notifications regarding new features, tournament updates, or service alerts. You can manage these preferences in your device settings.\n\nHow We Use Your Information\nWe may use your personal and technical information for the following purposes:\n\nTo provide the App’s core functionality, including content uploads, user interactions, and event participation\n\nTo improve and personalize your experience within the App\n\nTo communicate with you about updates, tournaments, marketing offers, and support requests\n\nTo comply with legal obligations or protect the integrity of our services\nPermissions and How They Are Used\n\nLocation: Used for event discovery and geo-relevant features\n\nCamera and Gallery: Used for posting content and updating profile photos\n\nMicrophone: Used for live sessions, voice messaging, or voice-based features\n\nNotifications: Used to send updates, reminders, and promotional offers\nWe only request these permissions when required, and you may revoke them at any time via your device settings.\n\nSharing of Information\n\nWe do not sell your personal information. \n\nWe may share your data under the following conditions:\n\nWith third-party service providers who support our platform operations (e.g., cloud hosting, analytics, communications)\n\nWith authorities or law enforcement agencies when required by applicable laws or court orders\n\nIn connection with a legal dispute or enforcement of our rights\n\nAll third-party providers are required to comply with data protection standards consistent with this policy.\n\nData Security\n\nWe implement appropriate technical and organizational safeguards to protect your information from unauthorized access, disclosure, or destruction. However, no digital platform can guarantee complete data security. Users are encouraged to maintain strong passwords and secure their devices.\n\n\nYour Rights\n\nDepending on your jurisdiction, you may have rights such as:\n\nThe right to access the personal data we hold about you\n\nThe right to correct or update your information\n\nThe right to request deletion of your data, subject to legal and operational obligations\n\nTo exercise these rights, please contact us using the information below.\n\nChildren’s Privacy\n\nThe App is not intended for individuals under the age of 13. We do not knowingly collect personal information from children without parental consent. If you believe we have unintentionally collected data from a minor, please contact us immediately.\n\nChanges to This Privacy Policy\n\nWe may update this Privacy Policy periodically to reflect changes in our practices or legal obligations. Users will be notified of significant updates through the App or via email. Continued use of the App after such changes constitutes your acceptance of the updated policy.\n\n\nContact Information\n\nIf you have questions or concerns about this Privacy Policy, your personal data, or our practices, please contact:\n\nArpit Singh Rawat\nProprietor – Kickin\nPhone: +91 9821990780\nWebsite: https://kickin.in\nEmail: arpit@kickin.in\n\n',
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
