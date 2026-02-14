import 'package:flutter/material.dart';
import '../../../core/theme/kickin_spacing.dart';
import '../../../core/theme/kickin_typography.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Details')),
      body: Padding(
        padding: const EdgeInsets.all(KickinSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Open Football Trials', style: KickinTypography.h1),
            const SizedBox(height: 12),
            Text('20 Jan 2026 • Delhi', style: KickinTypography.bodyMuted),
            const SizedBox(height: 24),
            Text(
              'This is an open football trial for players looking to '
              'showcase their skills and get scouted.',
              style: KickinTypography.body,
            ),
          ],
        ),
      ),
    );
  }
}
