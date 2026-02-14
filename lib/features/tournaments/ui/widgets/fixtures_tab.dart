import 'package:flutter/material.dart';
import '../../domain/models/match_model.dart';
import 'match_card.dart';

class FixturesTab extends StatelessWidget {
  final Map<String, List<MatchModel>> groupedMatches;
  final Map<String, String> teamNameMap;
  final String slug; // ✅ SLUG
  final bool canEditMatch;

  const FixturesTab({
    super.key,
    required this.groupedMatches,
    required this.teamNameMap,
    required this.slug,
    required this.canEditMatch,
  });

  @override
  Widget build(BuildContext context) {
    if (groupedMatches.isEmpty) {
      return const Center(child: Text("No fixtures generated yet."));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children:
          groupedMatches.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  entry.key.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Divider(),
                ...entry.value.map((match) {
                  final team1Name = teamNameMap[match.team1Id] ?? "TBD";
                  final team2Name = teamNameMap[match.team2Id] ?? "TBD";

                  return MatchCard(
                    match: match,
                    team1Name: team1Name,
                    team2Name: team2Name,
                    slug: slug, // ✅ FIXED
                    canEditMatch: canEditMatch,
                  );
                }),
              ],
            );
          }).toList(),
    );
  }
}
