import 'package:flutter/material.dart';
import '../../../core/theme/kickin_spacing.dart';
import '../../../core/theme/kickin_typography.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Event')),
      body: Padding(
        padding: const EdgeInsets.all(KickinSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Event Title', style: KickinTypography.body),
            const SizedBox(height: 8),
            const TextField(),

            const SizedBox(height: 16),
            Text('Date & Location', style: KickinTypography.body),
            const SizedBox(height: 8),
            const TextField(),

            const SizedBox(height: 16),
            Text('Description', style: KickinTypography.body),
            const SizedBox(height: 8),
            const TextField(maxLines: 4),

            const SizedBox(height: 24),
            ElevatedButton(onPressed: () {}, child: const Text('Create Event')),
          ],
        ),
      ),
    );
  }
}
