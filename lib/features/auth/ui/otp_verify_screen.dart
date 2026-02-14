import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/kickin_spacing.dart';
import '../../../core/auth/phone_auth_service.dart';
import 'auth_components.dart';

class OtpVerifyScreen extends StatefulWidget {
  final VoidCallback onResend;

  const OtpVerifyScreen({super.key, required this.onResend});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final TextEditingController _otpController = TextEditingController();

  bool _loading = false;
  String? _error;

  static const int _resendCooldown = 60;
  late int _secondsLeft;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    _timer?.cancel();
    _secondsLeft = _resendCooldown;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
        setState(() {});
      } else {
        setState(() {
          _secondsLeft--;
        });
      }
    });
  }

  void _verify() {
    final otp = _otpController.text.trim();
    if (otp.length != 6) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    PhoneAuthService.verifyOtp(
      otp: otp,
      onSuccess: () {
        // IdentityGate will auto-unlock
      },
      onError: (message) {
        setState(() {
          _loading = false;
          _error = message;
        });
      },
    );
  }

  void _resend() {
    if (_secondsLeft > 0 || _loading) return;

    widget.onResend();
    _startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            KickinSpacing.lg,
            KickinSpacing.xl,
            KickinSpacing.lg,
            KickinSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter verification code', style: textTheme.headlineLarge),
              const SizedBox(height: KickinSpacing.sm),
              Text(
                'We sent a 6-digit code to your phone number.',
                style: textTheme.bodyMedium,
              ),

              const SizedBox(height: KickinSpacing.xl),

              AuthTextField(
                controller: _otpController,
                hint: '••••••',
                keyboardType: TextInputType.number,
              ),

              if (_error != null) ...[
                const SizedBox(height: KickinSpacing.sm),
                Text(
                  _error!,
                  style: textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],

              const SizedBox(height: KickinSpacing.md),

              GestureDetector(
                onTap: _secondsLeft == 0 ? _resend : null,
                child: Text(
                  _secondsLeft == 0
                      ? 'Resend code'
                      : 'Resend code in ${_secondsLeft}s',
                  style: textTheme.bodySmall?.copyWith(
                    decoration:
                        _secondsLeft == 0
                            ? TextDecoration.underline
                            : TextDecoration.none,
                    color:
                        _secondsLeft == 0
                            ? textTheme.bodySmall?.color
                            : textTheme.bodySmall?.color?.withValues(
                              alpha: 0.6,
                            ),
                  ),
                ),
              ),

              const Spacer(),

              AuthButton(
                label: _loading ? 'Verifying…' : 'Verify & Continue',
                onTap: _loading ? null : _verify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
