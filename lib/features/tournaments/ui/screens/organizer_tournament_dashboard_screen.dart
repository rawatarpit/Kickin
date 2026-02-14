import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/kickin_spacing.dart';
import '../../../../core/theme/kickin_typography.dart';

import '../../state/tournament_notifier.dart';
import '../../state/tournament_lifecycle_provider.dart';
import '../../state/tournament_action_notifier.dart';
import '../../state/organizer_tournament_realtime_provider.dart';

class OrganizerTournamentDashboardScreen extends ConsumerWidget {
  final String slug;

  const OrganizerTournamentDashboardScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Activate organizer realtime
    ref.watch(organizerTournamentRealtimeProvider(slug));

    final tournamentAsync = ref.watch(tournamentDetailProvider(slug));
    final actionState = ref.watch(tournamentActionProvider);

    ref.listen(tournamentActionProvider, (previous, next) {
      next.whenOrNull(
        error: (err, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(err.toString())));
        },
      );
    });

    return tournamentAsync.when(
      loading: () => const _DashboardShimmer(),
      error: (_, __) => const Center(child: Text("Failed to load")),
      data: (tournament) {
        if (tournament == null) {
          return const Center(child: Text("Tournament not found"));
        }

        final lifecycle = ref.watch(tournamentLifecycleProvider(tournament));

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: const Text("Tournament Control Center"),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(KickinSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tournament.name, style: KickinTypography.h1),
                    const SizedBox(height: KickinSpacing.lg),

                    if (lifecycle.canOpenRegistration)
                      _actionButton(
                        "Open Registration",
                        () => ref
                            .read(tournamentActionProvider.notifier)
                            .openRegistration(slug),
                      ),

                    if (lifecycle.canCloseRegistration)
                      _actionButton(
                        "Close Registration",
                        () => ref
                            .read(tournamentActionProvider.notifier)
                            .closeRegistration(slug),
                      ),

                    if (lifecycle.canStartTournament)
                      _actionButton(
                        "Start Tournament",
                        () => ref
                            .read(tournamentActionProvider.notifier)
                            .startTournament(slug),
                      ),
                  ],
                ),
              ),

              if (actionState.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _actionButton(String label, VoidCallback action) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(onPressed: action, child: Text(label)),
    );
  }
}

class _DashboardShimmer extends StatelessWidget {
  const _DashboardShimmer();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
