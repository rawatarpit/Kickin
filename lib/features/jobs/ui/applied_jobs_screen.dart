import 'package:flutter/material.dart';
import '../../../core/theme/kickin_spacing.dart';
import '../../../core/theme/kickin_typography.dart';

class AppliedJobsScreen extends StatelessWidget {
  const AppliedJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(KickinSpacing.lg),
      children: const [
        _AppliedJobRow(title: 'Football Coach', status: 'Pending'),
        _AppliedJobRow(title: 'Fitness Trainer', status: 'Reviewed'),
      ],
    );
  }
}

class _AppliedJobRow extends StatelessWidget {
  final String title;
  final String status;

  const _AppliedJobRow({required this.title, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: KickinTypography.body),
          Text(status, style: KickinTypography.bodyMuted),
        ],
      ),
    );
  }
}
