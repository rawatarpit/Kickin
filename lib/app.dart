import 'package:flutter/material.dart';
import 'core/theme/kickin_theme.dart';
import 'core/navigation/app_router.dart';
import 'core/auth/identity_gate.dart';

class KickinApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Map<String, dynamic>? initialPushData;

  const KickinApp({
    super.key,
    required this.navigatorKey,
    this.initialPushData,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Kickin',
      theme: KickinTheme.dark(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: const IdentityGate(),
    );
  }
}
