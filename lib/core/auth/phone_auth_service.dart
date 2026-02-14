import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class PhoneAuthService {
  PhoneAuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String? _verificationId;
  static String? _lastPhoneNumber;

  static Future<void> sendOtp({
    required String phoneNumber,
    required VoidCallback onCodeSent,
    required void Function(String message) onError,
  }) async {
    try {
      _verificationId = null;
      _lastPhoneNumber = phoneNumber;

      if (kIsWeb) {
        final confirmation = await _auth.signInWithPhoneNumber(phoneNumber);
        _verificationId = confirmation.verificationId;
        onCodeSent();
      } else {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (_) {
            // Do NOT auto sign-in silently.
            // Let OTP flow handle verification.
          },
          verificationFailed: (FirebaseAuthException e) {
            onError(e.message ?? 'Verification failed');
          },
          codeSent: (verificationId, _) {
            _verificationId = verificationId;
            onCodeSent();
          },
          codeAutoRetrievalTimeout: (verificationId) {
            _verificationId = verificationId;
          },
        );
      }
    } catch (_) {
      onError('Failed to send OTP. Please try again.');
    }
  }

  static Future<void> resendOtp({
    required VoidCallback onCodeSent,
    required void Function(String message) onError,
  }) async {
    if (_lastPhoneNumber == null) {
      onError('Session expired. Please re-enter phone number.');
      return;
    }

    await sendOtp(
      phoneNumber: _lastPhoneNumber!,
      onCodeSent: onCodeSent,
      onError: onError,
    );
  }

  static Future<void> verifyOtp({
    required String otp,
    required VoidCallback onSuccess,
    required void Function(String message) onError,
  }) async {
    try {
      if (_verificationId == null) {
        onError('OTP session expired. Please try again.');
        return;
      }

      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);

      _verificationId = null;
      onSuccess();
    } catch (_) {
      onError('Invalid code. Please try again.');
    }
  }

  static Future<void> signOut() async {
    _verificationId = null;
    _lastPhoneNumber = null;
    await _auth.signOut();
  }
}
