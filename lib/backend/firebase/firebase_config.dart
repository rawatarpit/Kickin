import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDwfqUDeEoVTi_0OE2CL_qogbfjjhG-DwQ",
            authDomain: "kickin-9s7gfx.firebaseapp.com",
            projectId: "kickin-9s7gfx",
            storageBucket: "kickin-9s7gfx.firebasestorage.app",
            messagingSenderId: "771445747812",
            appId: "1:771445747812:web:465ce53c38cfce8622ef71",
            measurementId: "G-RWLQS35RTV"));
  } else {
    await Firebase.initializeApp();
  }
}
