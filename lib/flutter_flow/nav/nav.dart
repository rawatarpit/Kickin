import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => RootPageContext.wrap(
        appStateNotifier.loggedIn ? HomeWidget() : WelcomeWidget(),
        errorRoute: state.uri.toString(),
      ),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => RootPageContext.wrap(
            appStateNotifier.loggedIn ? HomeWidget() : WelcomeWidget(),
          ),
          routes: [
            FFRoute(
              name: HomeWidget.routeName,
              path: HomeWidget.routePath,
              requireAuth: true,
              builder: (context, params) => HomeWidget(),
            ),
            FFRoute(
              name: WelcomeWidget.routeName,
              path: WelcomeWidget.routePath,
              builder: (context, params) => WelcomeWidget(
                to: params.getParam(
                  'to',
                  ParamType.bool,
                ),
              ),
            ),
            FFRoute(
              name: UserExperienceWidget.routeName,
              path: UserExperienceWidget.routePath,
              requireAuth: true,
              builder: (context, params) => UserExperienceWidget(
                usertype: params.getParam(
                  'usertype',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: CreateAccountWidget.routeName,
              path: CreateAccountWidget.routePath,
              builder: (context, params) => CreateAccountWidget(),
            ),
            FFRoute(
              name: PrivacyPolicyWidget.routeName,
              path: PrivacyPolicyWidget.routePath,
              builder: (context, params) => PrivacyPolicyWidget(),
            ),
            FFRoute(
              name: TermsOfServiceWidget.routeName,
              path: TermsOfServiceWidget.routePath,
              builder: (context, params) => TermsOfServiceWidget(),
            ),
            FFRoute(
              name: InboxWidget.routeName,
              path: InboxWidget.routePath,
              requireAuth: true,
              builder: (context, params) => InboxWidget(),
            ),
            FFRoute(
              name: ProfileWidget.routeName,
              path: ProfileWidget.routePath,
              builder: (context, params) => ProfileWidget(),
            ),
            FFRoute(
              name: MyNetworkWidget.routeName,
              path: MyNetworkWidget.routePath,
              builder: (context, params) => MyNetworkWidget(
                userId: params.getParam(
                  'userId',
                  ParamType.String,
                ),
                curentuser: params.getParam(
                  'curentuser',
                  ParamType.bool,
                ),
                name: params.getParam(
                  'name',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: KtmCreateTournamentWidget.routeName,
              path: KtmCreateTournamentWidget.routePath,
              builder: (context, params) => KtmCreateTournamentWidget(),
            ),
            FFRoute(
              name: NotificationsWidget.routeName,
              path: NotificationsWidget.routePath,
              requireAuth: true,
              builder: (context, params) => NotificationsWidget(
                tabIndex: params.getParam(
                  'tabIndex',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: SearchPageWidget.routeName,
              path: SearchPageWidget.routePath,
              builder: (context, params) => SearchPageWidget(),
            ),
            FFRoute(
              name: SignUpWidget.routeName,
              path: SignUpWidget.routePath,
              builder: (context, params) => SignUpWidget(),
            ),
            FFRoute(
              name: KickinShotWidget.routeName,
              path: KickinShotWidget.routePath,
              requireAuth: true,
              builder: (context, params) => KickinShotWidget(
                postID: params.getParam(
                  'postID',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['posts'],
                ),
              ),
            ),
            FFRoute(
              name: ResetPasswordWidget.routeName,
              path: ResetPasswordWidget.routePath,
              builder: (context, params) => ResetPasswordWidget(),
            ),
            FFRoute(
              name: UploadWidget.routeName,
              path: UploadWidget.routePath,
              builder: (context, params) => UploadWidget(),
            ),
            FFRoute(
              name: IndiviualPostWidget.routeName,
              path: IndiviualPostWidget.routePath,
              builder: (context, params) => IndiviualPostWidget(
                postId: params.getParam(
                  'postId',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: JobListingWidget.routeName,
              path: JobListingWidget.routePath,
              builder: (context, params) => JobListingWidget(),
            ),
            FFRoute(
              name: ChatMessageWidget.routeName,
              path: ChatMessageWidget.routePath,
              asyncParams: {
                'postId': getDoc(['posts'], PostsRecord.fromSnapshot),
              },
              builder: (context, params) => ChatMessageWidget(
                chatId: params.getParam(
                  'chatId',
                  ParamType.String,
                ),
                userId: params.getParam(
                  'userId',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['users'],
                ),
                postId: params.getParam(
                  'postId',
                  ParamType.Document,
                ),
              ),
            ),
            FFRoute(
              name: PreviewEventPageWidget.routeName,
              path: PreviewEventPageWidget.routePath,
              builder: (context, params) => PreviewEventPageWidget(
                tournamentId: params.getParam(
                  'tournamentId',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: EventPageWidget.routeName,
              path: EventPageWidget.routePath,
              builder: (context, params) => EventPageWidget(
                tournamentID: params.getParam(
                  'tournamentID',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: EventDetailsWidget.routeName,
              path: EventDetailsWidget.routePath,
              requireAuth: true,
              builder: (context, params) => EventDetailsWidget(
                tabNumber: params.getParam(
                  'tabNumber',
                  ParamType.int,
                ),
                tournamentid: params.getParam(
                  'tournamentid',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: EventsWidget.routeName,
              path: EventsWidget.routePath,
              builder: (context, params) => EventsWidget(
                tabIndex: params.getParam(
                  'tabIndex',
                  ParamType.int,
                ),
              ),
            ),
            FFRoute(
              name: EventDetailsorgWidget.routeName,
              path: EventDetailsorgWidget.routePath,
              builder: (context, params) => EventDetailsorgWidget(
                tabNumber: params.getParam(
                  'tabNumber',
                  ParamType.int,
                ),
                tournamentId: params.getParam(
                  'tournamentId',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: OtherprofileWidget.routeName,
              path: OtherprofileWidget.routePath,
              builder: (context, params) => OtherprofileWidget(
                id: params.getParam(
                  'id',
                  ParamType.String,
                ),
              ),
            ),
            FFRoute(
              name: EditProfileWidget.routeName,
              path: EditProfileWidget.routePath,
              builder: (context, params) => EditProfileWidget(),
            ),
            FFRoute(
              name: GroupChatWidget.routeName,
              path: GroupChatWidget.routePath,
              requireAuth: true,
              builder: (context, params) => GroupChatWidget(
                chatId: params.getParam(
                  'chatId',
                  ParamType.DocumentReference,
                  isList: false,
                  collectionNamePath: ['chats'],
                ),
                particpantId: params.getParam<String>(
                  'particpantId',
                  ParamType.String,
                  isList: true,
                ),
              ),
            ),
            FFRoute(
              name: RefundPolicyWidget.routeName,
              path: RefundPolicyWidget.routePath,
              builder: (context, params) => RefundPolicyWidget(),
            ),
            FFRoute(
              name: AboutUsWidget.routeName,
              path: AboutUsWidget.routePath,
              builder: (context, params) => AboutUsWidget(),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/welcome';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/images/Splash_Screen-4.svg',
                    fit: BoxFit.contain,
                  ),
                )
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
