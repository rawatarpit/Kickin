import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/theme/kickin_spacing.dart';
import '../../../../core/theme/kickin_typography.dart';

import '../../state/tournament_notifier.dart';
import '../../state/tournament_lifecycle_provider.dart';
import '../../domain/models/tournament_model.dart';
import '../../domain/tournament_lifecycle.dart';

class TournamentsListScreen extends ConsumerWidget {
  const TournamentsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Realtime handled in state layer
    ref.watch(tournamentRealtimeProvider);

    final tournamentsAsync = ref.watch(tournamentProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Tournaments")),
      body: tournamentsAsync.when(
        loading: () => const _ShimmerList(),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (tournaments) {
          if (tournaments.isEmpty) {
            return const _EmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(tournamentProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(KickinSpacing.lg),
              itemCount: tournaments.length,
              itemBuilder: (context, index) {
                return _TournamentCard(tournament: tournaments[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

class _TournamentCard extends ConsumerWidget {
  final TournamentModel tournament;

  const _TournamentCard({required this.tournament});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lifecycle = ref.watch(tournamentLifecycleProvider(tournament));

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.pushNamed(
          context,
          '${AppRoutes.tournamentBase}/${tournament.id}',
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: KickinSpacing.lg),
        padding: const EdgeInsets.all(KickinSpacing.lg),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.grey.shade900, Colors.grey.shade800],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    tournament.name,
                    style: KickinTypography.h2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildStatusBadge(lifecycle),
              ],
            ),
            const SizedBox(height: 12),
            if (tournament.location != null && tournament.location!.isNotEmpty)
              Text(tournament.location!, style: KickinTypography.bodyMuted),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(TournamentLifecycle lifecycle) {
    if (lifecycle.showLiveBanner) {
      return _badge("LIVE", Colors.red);
    }
    if (lifecycle.showCompletedBanner) {
      return _badge("COMPLETED", Colors.green);
    }
    if (lifecycle.showRegistrationBanner) {
      return _badge("REGISTRATION", Colors.blue);
    }
    if (lifecycle.showCancelledBanner) {
      return _badge("CANCELLED", Colors.orange);
    }
    return _badge("DRAFT", Colors.grey);
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  const _ShimmerList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(KickinSpacing.lg),
      itemCount: 4,
      itemBuilder:
          (_, __) => Container(
            margin: const EdgeInsets.only(bottom: KickinSpacing.lg),
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade300.withValues(alpha: 0.4),
            ),
          ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("No tournaments yet"));
  }
}
