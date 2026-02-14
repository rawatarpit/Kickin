import 'package:flutter/material.dart';
import '../../../core/theme/kickin_spacing.dart';
import '../../../core/theme/kickin_typography.dart';
import 'event_detail_screen.dart';

class EventsListScreen extends StatelessWidget {
  const EventsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(KickinSpacing.lg),
      children: [
        _EventCard(
          title: 'Open Football Trials',
          date: '20 Jan 2026',
          location: 'Delhi',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EventDetailScreen()),
            );
          },
        ),
        _EventCard(
          title: 'Kickin Community Match',
          date: '25 Jan 2026',
          location: 'DU North Campus',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EventDetailScreen()),
            );
          },
        ),
      ],
    );
  }
}

class _EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final VoidCallback onTap;

  const _EventCard({
    required this.title,
    required this.date,
    required this.location,
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
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade900,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: KickinTypography.h2),
            const SizedBox(height: 8),
            Text('$date • $location', style: KickinTypography.bodyMuted),
          ],
        ),
      ),
    );
  }
}
