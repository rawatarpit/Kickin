import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/tournament_model.dart';
import '../../state/tournament_lifecycle_provider.dart';
import '../../state/team_notifier.dart';

class CreateTeamScreen extends ConsumerStatefulWidget {
  final TournamentModel tournament;

  const CreateTeamScreen({super.key, required this.tournament});

  @override
  ConsumerState<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends ConsumerState<CreateTeamScreen> {
  final _nameController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final lifecycle = ref.watch(tournamentLifecycleProvider(widget.tournament));

    return Scaffold(
      appBar: AppBar(title: const Text("Create Team")),
      body:
          lifecycle.canCreateTeam
              ? Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: "Team Name",
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _loading ? null : _createTeam,
                          child: const Text("Create Team"),
                        ),
                      ],
                    ),
                  ),
                  if (_loading)
                    const Center(child: CircularProgressIndicator()),
                ],
              )
              : const Center(
                child: Text("Registration closed. Team creation disabled."),
              ),
    );
  }

  Future<void> _createTeam() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() => _loading = true);

    try {
      await ref
          .read(teamProvider.notifier)
          .createTeam(slug: widget.tournament.slug, name: name);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Team created successfully")),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    if (mounted) setState(() => _loading = false);
  }
}
