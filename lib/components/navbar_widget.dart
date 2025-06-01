import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'navbar_model.dart';
export 'navbar_model.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({
    super.key,
    required this.pageName,
  });

  final MenItems? pageName;

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  late NavbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavbarModel());

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
      height: 80.0,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: 85.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 12.0, 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 3.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'NAVBAR_COMP_Icon_0w3x7mij_ON_TAP');
                              logFirebaseEvent('Icon_navigate_to');

                              context.pushNamed(HomeWidget.routeName);
                            },
                            child: Icon(
                              Icons.home_filled,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 28.0,
                            ),
                          ),
                        ),
                        if (widget.pageName == MenItems.home)
                          Divider(
                            thickness: 1.0,
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 3.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'NAVBAR_COMP_Icon_a1psquoc_ON_TAP');
                              logFirebaseEvent('Icon_navigate_to');

                              context.pushNamed(SearchPageWidget.routeName);
                            },
                            child: Icon(
                              Icons.search_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 28.0,
                            ),
                          ),
                        ),
                        if (widget.pageName == MenItems.search)
                          Divider(
                            thickness: 1.0,
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent('NAVBAR_COMP_uploadmedia_ON_TAP');
                        logFirebaseEvent('uploadmedia_navigate_to');

                        context.pushNamed(
                          UploadWidget.routeName,
                          extra: <String, dynamic>{
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.bottomToTop,
                            ),
                          },
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 3.0, 0.0, 0.0),
                            child: Icon(
                              Icons.add,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 28.0,
                            ),
                          ),
                          if (widget.pageName == MenItems.upload)
                            Divider(
                              thickness: 1.0,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                        ].divide(SizedBox(height: 8.0)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 3.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'NAVBAR_COMP_Icon_mjf1s6nj_ON_TAP');
                              logFirebaseEvent('Icon_navigate_to');

                              context.pushNamed(KickinShotWidget.routeName);
                            },
                            child: Icon(
                              Icons.ondemand_video,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 28.0,
                            ),
                          ),
                        ),
                        if (widget.pageName == MenItems.shots)
                          Divider(
                            thickness: 1.0,
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                  ),
                  if (valueOrDefault(currentUserDocument?.role, '') !=
                      UserType.Player.name)
                    Expanded(
                      child: AuthUserStreamWidget(
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 3.0, 0.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  logFirebaseEvent(
                                      'NAVBAR_COMP_Icon_80ovygcy_ON_TAP');
                                  logFirebaseEvent('Icon_navigate_to');

                                  context.pushNamed(JobListingWidget.routeName);
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.briefcase,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 25.0,
                                ),
                              ),
                            ),
                            if (widget.pageName == MenItems.jobs)
                              Divider(
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      ),
                    ),
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent('NAVBAR_COMP_user_ON_TAP');
                        logFirebaseEvent('user_navigate_to');

                        context.pushNamed(ProfileWidget.routeName);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AuthUserStreamWidget(
                            builder: (context) => Container(
                              width: 34.0,
                              height: 34.0,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                valueOrDefault<String>(
                                  currentUserPhoto,
                                  'https://grbbdskhtdettoddpxfl.supabase.co/storage/v1/object/public/storage/Photos/Profile.svg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ].divide(SizedBox(height: 2.0)),
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 24.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
