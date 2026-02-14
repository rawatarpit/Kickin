import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/tournament_model.dart';
import '../../state/match_notifier.dart';
import '../../state/tournament_notifier.dart';
import '../widgets/match_card.dart';

class FixturesScreen extends ConsumerWidget {
  final TournamentModel tournament;

  const FixturesScreen({super.key, required this.tournament});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesAsync = ref.watch(matchProvider(tournament.slug));

    final summaryAsync = ref.watch(tournamentSummaryProvider(tournament.slug));

    final actionState = ref.watch(matchActionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Fixtures")),
      body: Stack(
        children: [
          Column(
            children: [
              summaryAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (summary) {
                  final canStart = summary['can_start'] == true;
                  final canAdvance = summary['can_advance'] == true;
                  final currentRound = summary['current_round']?.toString();

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        if (canStart)
                          _PrimaryActionButton(
                            label: "Generate Fixtures",
                            onPressed: () async {
                              await ref
                                  .read(matchActionProvider.notifier)
                                  .generateInitialFixtures(tournament.slug);

                              ref.invalidate(matchProvider(tournament.slug));
                            },
                          ),
                        if (canAdvance && currentRound != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: _PrimaryActionButton(
                              label: "Advance from $currentRound",
                              onPressed: () async {
                                await ref
                                    .read(matchActionProvider.notifier)
                                    .advanceKnockoutRound(
                                      slug: tournament.slug,
                                      currentRound: currentRound,
                                    );

                                ref.invalidate(matchProvider(tournament.slug));
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              Expanded(
                child: matchesAsync.when(
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (err, _) => Center(child: Text(err.toString())),
                  data: (matches) {
                    if (matches.isEmpty) {
                      return const Center(
                        child: Text("No fixtures generated yet."),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: matches.length,
                      itemBuilder: (_, index) {
                        final match = matches[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: MatchCard(
                            match: match,
                            team1Name: match.team1Name ?? "Team A",
                            team2Name: match.team2Name ?? "Team B",
                            slug: tournament.slug,
                            canEditMatch: false,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          if (actionState.isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.4),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

class _PrimaryActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _PrimaryActionButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: onPressed, child: Text(label)),
    );
  }
}
