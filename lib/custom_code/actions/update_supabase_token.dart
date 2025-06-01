// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

// We'll store the subscription at a global or static level
// so it persists beyond this function call.
StreamSubscription<firebase_auth.User?>? _authWatcher;

Future<void> updateSupabaseToken() async {
  try {
    // 1) If we haven't already set up the listener, do it now.
    if (_authWatcher == null) {
      _authWatcher = firebase_auth.FirebaseAuth.instance
          .userChanges()
          .listen((firebase_auth.User? user) async {
        if (user == null) {
          // User signed out
          // Optionally sign out from Supabase
          await SupaFlow.client.auth.signOut();
          debugPrint('Signed out of Supabase because Firebase user is null.');
        } else {
          // Update the token whenever the user logs in or refreshes
          await _fetchAndSetSupabaseToken(user);
        }
      });
      debugPrint('Auth watcher set up successfully.');
    } else {
      debugPrint('Auth watcher already set up.');
    }

    // 2) If a user is currently signed in, do an immediate token update.
    final user = firebase_auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _fetchAndSetSupabaseToken(user);
    } else {
      // If user == null, optionally sign out from Supabase right now
      // in case you want a truly "no user" state.
      await SupaFlow.client.auth.signOut();
      debugPrint('No user currently signed in; signed out from Supabase.');
    }
  } catch (e, st) {
    debugPrint('Error in updateSupabaseTokenAction: $e $st');
  }
}

// Helper to fetch the Firebase token and update Supabase
Future<void> _fetchAndSetSupabaseToken(firebase_auth.User user) async {
  try {
    // Get the Firebase JWT token directly.
    final firebaseToken = await user.getIdToken();

    // Update the Supabase client to use the Firebase token.
    Supabase.instance.client.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $firebaseToken',
    };
    SupaFlow.client.rest.setAuth(firebaseToken);

    debugPrint('Supabase token updated successfully for user ${user.uid}.');
  } catch (e, st) {
    debugPrint('Error fetching/setting Supabase token: $e $st');
  }
}
