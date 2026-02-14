import 'package:flutter/material.dart';
import '../../../core/theme/kickin_spacing.dart';
import '../../../core/theme/kickin_typography.dart';

class ApplyJobScreen extends StatelessWidget {
  const ApplyJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apply Job')),
      body: Padding(
        padding: const EdgeInsets.all(KickinSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Why should we hire you?', style: KickinTypography.body),
            const SizedBox(height: 8),
            const TextField(maxLines: 5),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Submit Application'),
            ),
          ],
        ),
      ),
    );
  }
}
