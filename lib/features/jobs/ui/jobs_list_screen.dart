import 'package:flutter/material.dart';
import '../../../core/theme/kickin_spacing.dart';
import '../../../core/theme/kickin_typography.dart';
import 'job_detail_screen.dart';

class JobsListScreen extends StatelessWidget {
  const JobsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(KickinSpacing.lg),
      children: [
        _JobCard(
          title: 'Football Coach',
          company: 'Delhi FC',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const JobDetailScreen()),
            );
          },
        ),
        _JobCard(
          title: 'Fitness Trainer',
          company: 'Kickin Academy',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const JobDetailScreen()),
            );
          },
        ),
      ],
    );
  }
}

class _JobCard extends StatelessWidget {
  final String title;
  final String company;
  final VoidCallback onTap;

  const _JobCard({
    required this.title,
    required this.company,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: KickinSpacing.lg),
        padding: const EdgeInsets.all(KickinSpacing.md),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: KickinTypography.h2),
            const SizedBox(height: 6),
            Text(company, style: KickinTypography.bodyMuted),
          ],
        ),
      ),
    );
  }
}
