import 'package:flutter/material.dart';
import '../../../../core/theme/kickin_spacing.dart';
import '../../../../core/theme/kickin_typography.dart';
import '../../domain/models/team_model.dart';

class TeamCard extends StatelessWidget {
  final TeamModel team;
  final int memberCount;
  final bool isUserTeam;
  final VoidCallback? onTap;

  const TeamCard({
    super.key,
    required this.team,
    required this.memberCount,
    this.isUserTeam = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasLogo = team.logoUrl != null && team.logoUrl!.isNotEmpty;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: KickinSpacing.md),
        padding: const EdgeInsets.all(KickinSpacing.lg),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isUserTeam ? Colors.green : Colors.grey.shade800,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey.shade800,
              backgroundImage: hasLogo ? NetworkImage(team.logoUrl!) : null,
              child:
                  !hasLogo
                      ? Text(
                        team.name.isNotEmpty ? team.name[0].toUpperCase() : "?",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      )
                      : null,
            ),

            const SizedBox(width: KickinSpacing.lg),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(team.name, style: KickinTypography.h2),
                  const SizedBox(height: KickinSpacing.sm),
                  Text(
                    "$memberCount Members",
                    style: KickinTypography.bodyMuted,
                  ),
                ],
              ),
            ),

            if (isUserTeam) const Icon(Icons.star, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
