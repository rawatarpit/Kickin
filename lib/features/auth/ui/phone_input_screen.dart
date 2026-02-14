import 'package:flutter/material.dart';
import '../../../core/theme/kickin_spacing.dart';
import 'auth_components.dart';

class PhoneInputScreen extends StatefulWidget {
  final void Function(String phoneNumber) onSubmit;

  const PhoneInputScreen({super.key, required this.onSubmit});

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _loading = false;

  void _continue() {
    final phone = _controller.text.trim();
    if (phone.length < 10) return;

    setState(() => _loading = true);
    widget.onSubmit(phone);
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
              Text('Sign in with phone', style: textTheme.headlineLarge),
              const SizedBox(height: KickinSpacing.sm),
              Text(
                'We’ll send you a one-time code to verify your number.',
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: KickinSpacing.xl),

              AuthTextField(
                controller: _controller,
                hint: '+91 98765 43210',
                keyboardType: TextInputType.phone,
              ),

              const Spacer(),

              AuthButton(
                label: _loading ? 'Sending…' : 'Continue',
                onTap: _loading ? null : _continue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
