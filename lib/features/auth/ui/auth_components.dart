import 'package:flutter/material.dart';
import '../../../core/theme/kickin_colors.dart';

/// =======================
/// AUTH TEXT FIELD
/// =======================
class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(hintText: hint),
    );
  }
}

/// =======================
/// AUTH BUTTON
/// =======================
class AuthButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const AuthButton({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool disabled = onTap == null;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              disabled ? KickinColors.border : KickinColors.primary,
          foregroundColor:
              disabled ? KickinColors.textMuted : KickinColors.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onTap,
        child: Text(label, style: Theme.of(context).textTheme.labelLarge),
      ),
    );
  }
}
