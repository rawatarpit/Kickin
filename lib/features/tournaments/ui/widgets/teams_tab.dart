import 'package:flutter/material.dart';
import '../../domain/models/team_model.dart';
import 'team_card.dart';

class TeamsTab extends StatelessWidget {
  final List<TeamModel> teams;
  final Map<String, int> teamMemberCountMap;
  final String? userTeamId;

  const TeamsTab({
    super.key,
    required this.teams,
    required this.teamMemberCountMap,
    this.userTeamId,
  });

  @override
  Widget build(BuildContext context) {
    if (teams.isEmpty) {
      return const Center(child: Text("No teams registered yet"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: teams.length,
      itemBuilder: (_, index) {
        final team = teams[index];

        return TeamCard(
          team: team,
          memberCount: teamMemberCountMap[team.id] ?? 0,
          isUserTeam: team.id == userTeamId,
        );
      },
    );
  }
}
