import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/kickin_spacing.dart';
import '../../../../core/theme/kickin_typography.dart';

import '../../domain/models/tournament_model.dart';
import '../../state/team_notifier.dart';
import '../../state/tournament_lifecycle_provider.dart';
import '../widgets/team_card.dart';

class TeamsScreen extends ConsumerStatefulWidget {
  final TournamentModel tournament;

  const TeamsScreen({super.key, required this.tournament});

  @override
  ConsumerState<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends ConsumerState<TeamsScreen> {
  @override
  void initState() {
    super.initState();

    // Load once after frame
    Future.microtask(() {
      ref.read(teamProvider.notifier).load(widget.tournament.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final teamsAsync = ref.watch(teamProvider);
    final lifecycle = ref.watch(tournamentLifecycleProvider(widget.tournament));

    return teamsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (teams) {
        return Stack(
          children: [
            if (teams.isEmpty)
              const _EmptyTeamsState()
            else
              RefreshIndicator(
                onRefresh: () async {
                  await ref
                      .read(teamProvider.notifier)
                      .load(widget.tournament.id);
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(KickinSpacing.lg),
                  itemCount: teams.length,
                  itemBuilder: (_, index) {
                    final team = teams[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: KickinSpacing.md),
                      child: TeamCard(
                        team: team,
                        memberCount: 0, // TODO: connect members count later
                        isUserTeam: false,
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),

            // Floating create team button
            if (lifecycle.canCreateTeam)
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    // TODO: Navigate to CreateTeamScreen
                  },
                  child: const Icon(Icons.add),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _EmptyTeamsState extends StatelessWidget {
  const _EmptyTeamsState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(KickinSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.groups_outlined, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "No teams yet",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 6),
            Text(
              "Teams will appear here once registered.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
