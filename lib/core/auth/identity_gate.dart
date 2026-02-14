import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../navigation/app_router.dart';
import '../../features/auth/ui/phone_input_screen.dart';
import '../../features/auth/ui/otp_verify_screen.dart';
import '../../features/auth/ui/sign_up_screen.dart';
import 'phone_auth_service.dart';
import 'user_bootstrap_service.dart';

enum _AuthStage { phoneInput, otpVerify, bootstrapping }

class IdentityGate extends StatefulWidget {
  const IdentityGate({super.key});

  @override
  State<IdentityGate> createState() => _IdentityGateState();
}

class _IdentityGateState extends State<IdentityGate> {
  StreamSubscription<User?>? _authSub;
  _AuthStage _stage = _AuthStage.phoneInput;
  String? _error;

  @override
  void initState() {
    super.initState();
    _listenAuth();
  }

  void _listenAuth() {
    _authSub = FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user == null) {
        if (!mounted) return;
        setState(() {
          _stage = _AuthStage.phoneInput;
          _error = null;
        });
        return;
      }

      if (!mounted) return;
      setState(() => _stage = _AuthStage.bootstrapping);

      try {
        final result = await UserBootstrapService.bootstrap();

        if (!mounted) return;

        if (result.profileComplete) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder:
                  (_) => Navigator(onGenerateRoute: AppRouter.onGenerateRoute),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const SignUpScreen()),
          );
        }
      } catch (e) {
        if (!mounted) return;
        setState(() {
          _error = 'Something went wrong. Please try again.';
          _stage = _AuthStage.phoneInput;
        });
      }
    });
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }

  void _sendOtp(String phoneNumber) {
    PhoneAuthService.sendOtp(
      phoneNumber: phoneNumber,
      onCodeSent: () {
        setState(() => _stage = _AuthStage.otpVerify);
      },
      onError: (message) {
        setState(() => _error = message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        body: Center(child: Text(_error!, textAlign: TextAlign.center)),
      );
    }

    if (_stage == _AuthStage.bootstrapping) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_stage == _AuthStage.otpVerify) {
      return OtpVerifyScreen(
        onResend: () {
          PhoneAuthService.resendOtp(
            onCodeSent: () {},
            onError: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
          );
        },
      );
    }

    return PhoneInputScreen(onSubmit: _sendOtp);
  }
}
