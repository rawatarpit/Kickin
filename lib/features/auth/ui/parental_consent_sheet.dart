import 'package:flutter/material.dart';

class ParentalConsentSheet extends StatelessWidget {
  final String userId;

  const ParentalConsentSheet({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              const SizedBox(height: 16),
              _content(),
              const SizedBox(height: 32),
              _action(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Parental Consent',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close, size: 22, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _content() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You’re almost ready to join Kickin — a community where players, coaches, and clubs connect.',
          style: TextStyle(fontSize: 14, color: Colors.white70, height: 1.5),
        ),
        SizedBox(height: 12),
        Text(
          'Because you are under 18, India’s Digital Personal Data Protection Act (DPDPA 2023) requires us to obtain consent from your parent or legal guardian.',
          style: TextStyle(fontSize: 14, color: Colors.white70, height: 1.5),
        ),
        SizedBox(height: 12),
        Text(
          'Once approved, you’ll be able to:',
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),
        SizedBox(height: 8),
        Text(
          '• Set up your Kickin profile\n'
          '• Join tournaments and teams\n'
          '• Share highlights and connect with others',
          style: TextStyle(fontSize: 14, color: Colors.white70, height: 1.6),
        ),
        SizedBox(height: 12),
        Text(
          'Until then, your account will remain inactive.',
          style: TextStyle(fontSize: 13, color: Colors.white54),
        ),
      ],
    );
  }

  Widget _action(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // UI only — backend hook later
          Navigator.pop(context);
        },
        icon: const Icon(Icons.link),
        label: const Text(
          'Share Consent Link',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
