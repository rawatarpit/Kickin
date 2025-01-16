// ignore_for_file: avoid_unused_constructor_parameters, lines_longer_than_80_chars, unused_import

import 'package:flutter/material.dart';
import 'package:kickin/counter/counter.dart';
import 'package:kickin/l10n/arb/app_localizations.dart';
import 'package:kickin/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({
    required userRepository,
    required postsRepository,
    required chatsRepository,
    required storiesRepository,
    required searchRepository,
    required notificationsRepository,
    required firebaseRemoteConfigRepository,
    required connectionsRepository,
    required jobRepository,
    required eventRepository,
    required user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CounterPage(),
    );
  }
}
