import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/team_service.dart';
import '../data/tournament_service.dart';
import '../domain/models/team_model.dart';
import '../domain/tournament_lifecycle.dart';
import '../../../../core/supabase/supabase_provider.dart';
import 'tournament_notifier.dart'; // ✅ REQUIRED

final teamServiceProvider = Provider<TeamService>((ref) {
  final client = ref.read(supabaseClientProvider);
  return TeamService(client);
});

class TeamNotifier extends AsyncNotifier<List<TeamModel>> {
  late final TeamService _service;
  late final TournamentService _tournamentService;

  @override
  Future<List<TeamModel>> build() async {
    _service = ref.read(teamServiceProvider);
    _tournamentService = ref.read(tournamentServiceProvider);
    return [];
  }

  Future<void> load(String slug) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final tournament = await _tournamentService.fetchTournamentBySlug(slug);

      if (tournament == null) {
        throw Exception('Tournament not found');
      }

      return _service.fetchTeams(tournament.id);
    });
  }

  Future<void> createTeam({required String slug, required String name}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final tournament = await _tournamentService.fetchTournamentBySlug(slug);

      if (tournament == null) {
        throw Exception('Tournament not found');
      }

      final lifecycle = TournamentLifecycle(
        status: tournament.status,
        isOrganizer: false,
      );

      if (!lifecycle.canCreateTeam) {
        throw Exception('Team creation not allowed');
      }

      await _service.createTeamSecure(tournamentId: tournament.id, name: name);

      return _service.fetchTeams(tournament.id);
    });
  }
}

final teamProvider = AsyncNotifierProvider<TeamNotifier, List<TeamModel>>(
  TeamNotifier.new,
);
