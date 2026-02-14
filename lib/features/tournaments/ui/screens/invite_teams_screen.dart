import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/tournament_model.dart';
import '../../domain/models/invitation_model.dart';
import '../../state/tournament_lifecycle_provider.dart';
import '../../state/tournament_invites_provider.dart';

class InviteTeamsScreen extends ConsumerWidget {
  final TournamentModel tournament;

  const InviteTeamsScreen({super.key, required this.tournament});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lifecycle = ref.watch(tournamentLifecycleProvider(tournament));

    final invitesAsync = ref.watch(tournamentInvitesProvider(tournament.id));

    if (!lifecycle.canInvitePlayers) {
      return const Scaffold(
        body: Center(child: Text("Registration closed. Invites disabled.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Invite Teams")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _InviteCodeCard(tournament: tournament),
          const SizedBox(height: 24),
          invitesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text(e.toString())),
            data: (List<InvitationModel> invites) {
              if (invites.isEmpty) {
                return const Text("No pending invites.");
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pending Invitations",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  ...invites.map(
                    (inv) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(inv.receiverId),
                      subtitle: Text(inv.status ?? "pending"),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _InviteCodeCard extends StatelessWidget {
  final TournamentModel tournament;

  const _InviteCodeCard({required this.tournament});

  @override
  Widget build(BuildContext context) {
    final inviteCode = tournament.id.substring(0, 6).toUpperCase();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            inviteCode,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: inviteCode));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Invite code copied")),
              );
            },
          ),
        ],
      ),
    );
  }
}
