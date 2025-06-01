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

import 'package:firebase_auth/firebase_auth.dart';

Future forceRefreshToken() async {
  // Get the current user
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return;
  }

  try {
    // Check if role is already set
    IdTokenResult tokenResult = await user.getIdTokenResult(false);
    Map<String, dynamic>? claims = tokenResult.claims;

    // If role is not set, force a token refresh
    if (claims == null || claims['role'] != 'authenticated') {
      // First attempt
      await user.getIdToken(true);

      // Wait briefly
      await Future.delayed(Duration(milliseconds: 1000));

      // Retry once more if needed
      final retryResult = await user.getIdTokenResult(false);
      if (retryResult.claims == null ||
          retryResult.claims!['role'] != 'authenticated') {
        // One final refresh attempt
        await user.getIdToken(true);
      }
    }

    // Function returns void, FlutterFlow will handle the refreshed token
    return;
  } catch (e) {
    print('Error in forceRefreshToken: $e');
    return;
  }
}
