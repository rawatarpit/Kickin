import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/match_notifier.dart';
import '../../state/tournament_lifecycle_provider.dart';
import '../../domain/models/tournament_model.dart';
import '../widgets/match_card.dart';

class ScoresScreen extends ConsumerWidget {
  final TournamentModel tournament;
  final Map<String, String> teamNameMap;

  const ScoresScreen({
    super.key,
    required this.tournament,
    required this.teamNameMap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesAsync = ref.watch(matchProvider(tournament.slug));

    final lifecycle = ref.watch(tournamentLifecycleProvider(tournament));

    return matchesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text("Error: $err")),
      data: (matches) {
        if (matches.isEmpty) {
          return const Center(child: Text("No matches available."));
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(matchProvider(tournament.slug));
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: matches.length,
            itemBuilder: (_, index) {
              final match = matches[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MatchCard(
                  match: match,
                  team1Name: teamNameMap[match.team1Id] ?? "Team A",
                  team2Name: teamNameMap[match.team2Id] ?? "Team B",
                  slug: tournament.slug, // ✅ FIXED
                  canEditMatch: lifecycle.canSubmitMatch && !match.isLocked,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
