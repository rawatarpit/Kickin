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

import 'dart:async';
import 'dart:js' as js;

Future<void> callPhonePeCheckout(String tokenUrl) async {
  // Callback function triggered when PhonePe checkout finishes or cancels
  void callback(dynamic response) {
    if (response == 'USER_CANCEL') {
      print('User cancelled the transaction');
      // TODO: Add your UI logic here (e.g., show message, update state)
    } else if (response == 'CONCLUDED') {
      print('Transaction concluded');
      // TODO: Add your UI logic here (e.g., show success, navigate)
    } else {
      print('Unknown response from checkout: $response');
    }
  }

  // Helper function to wait until 'checkout' is available or timeout
  Future<bool> waitForCheckout(
      {int timeoutMs = 5000, int intervalMs = 100}) async {
    int waited = 0;
    while (!js.context.hasProperty('checkout') && waited < timeoutMs) {
      await Future.delayed(Duration(milliseconds: intervalMs));
      waited += intervalMs;
    }
    return js.context.hasProperty('checkout');
  }

  bool isCheckoutReady = await waitForCheckout();

  if (isCheckoutReady) {
    try {
      // Call checkout with tokenUrl, iframe type, and callback wrapped in allowInterop
      js.context.callMethod(
        'checkout',
        [tokenUrl, "IFRAME", js.allowInterop(callback)],
      );
      print('PhonePe checkout invoked successfully');
    } catch (e) {
      print('Error invoking PhonePe checkout: $e');
    }
  } else {
    print('PhonePeCheckout script not loaded after waiting');
    // You may want to notify user or retry loading page/script here
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
