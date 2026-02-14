import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'core/supabase/supabase_client.dart';
import 'app.dart';

// Screens
import 'features/profile/ui/user_profile_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase Init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  // Supabase Init
  await SupabaseClientProvider.initialize();

  // FCM Permission
  await FirebaseMessaging.instance.requestPermission();

  // Background → App Opened
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    _handlePushNavigation(message.data);
  });

  // Terminated → Opened via Push
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  runApp(
    ProviderScope(
      child: KickinApp(
        navigatorKey: navigatorKey,
        initialPushData: initialMessage?.data,
      ),
    ),
  );
}

void _handlePushNavigation(Map<String, dynamic>? data) {
  if (data == null) return;

  final context = navigatorKey.currentContext;
  if (context == null) return;

  final String? type = data['type'];
  final String? fromUserId = data['fromUserId'];

  if (type == 'follow' && fromUserId != null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => UserProfileScreen(userId: fromUserId)),
    );
  }
}
