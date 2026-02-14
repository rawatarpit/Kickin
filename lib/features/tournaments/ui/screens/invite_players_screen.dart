import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/tournament_model.dart';
import '../../state/tournament_lifecycle_provider.dart';
import '../../state/invitation_notifier.dart';

class InvitePlayersScreen extends ConsumerStatefulWidget {
  final TournamentModel tournament;
  final String teamId;
  final List<Map<String, String>> availablePlayers;

  const InvitePlayersScreen({
    super.key,
    required this.tournament,
    required this.teamId,
    required this.availablePlayers,
  });

  @override
  ConsumerState<InvitePlayersScreen> createState() =>
      _InvitePlayersScreenState();
}

class _InvitePlayersScreenState extends ConsumerState<InvitePlayersScreen> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final lifecycle = ref.watch(tournamentLifecycleProvider(widget.tournament));

    final invitationState = ref.watch(invitationProvider);

    ref.listen(invitationProvider, (prev, next) {
      next.whenOrNull(
        error: (err, _) {
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(err.toString())));
        },
      );
    });

    if (!lifecycle.canInvitePlayers) {
      return const Scaffold(
        body: Center(child: Text("Registration is closed. Invites disabled.")),
      );
    }

    final filtered =
        widget.availablePlayers
            .where(
              (p) => p['name']!.toLowerCase().contains(_search.toLowerCase()),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Invite Players")),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Search players...",
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (v) => setState(() => _search = v),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (_, index) {
                    final player = filtered[index];

                    final isPending = ref
                        .read(invitationProvider.notifier)
                        .isInvitePending(player['id']!);

                    return ListTile(
                      title: Text(player['name']!),
                      trailing: ElevatedButton(
                        onPressed:
                            isPending
                                ? null
                                : () async {
                                  await ref
                                      .read(invitationProvider.notifier)
                                      .sendInvite(
                                        teamId: widget.teamId,
                                        receiverId: player['id']!,
                                        slug: widget.tournament.slug,
                                      );
                                },
                        child: Text(isPending ? "Invited" : "Invite"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          if (invitationState.isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
