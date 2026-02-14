import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/match_service.dart';
import '../data/tournament_service.dart';
import '../domain/models/match_model.dart';
import '../domain/tournament_format.dart';
import '../domain/tournament_lifecycle.dart';
import '../../../../core/supabase/supabase_provider.dart';
import 'tournament_notifier.dart';

final matchServiceProvider = Provider<MatchService>((ref) {
  final client = ref.read(supabaseClientProvider);
  return MatchService(client);
});

final matchProvider = FutureProvider.family<List<MatchModel>, String>((
  ref,
  slug,
) async {
  final tournamentService = ref.read(tournamentServiceProvider);
  final matchService = ref.read(matchServiceProvider);

  final tournament = await tournamentService.fetchTournamentBySlug(slug);

  if (tournament == null) return [];

  return matchService.fetchMatches(tournament.id);
});

class MatchActionNotifier extends AsyncNotifier<void> {
  late final MatchService _matchService;
  late final TournamentService _tournamentService;

  @override
  Future<void> build() async {
    _matchService = ref.read(matchServiceProvider);
    _tournamentService = ref.read(tournamentServiceProvider);
  }

  Future<_TournamentContext> _getContext(String slug) async {
    final tournament = await _tournamentService.fetchTournamentBySlug(slug);

    if (tournament == null) {
      throw Exception('Tournament not found');
    }

    final lifecycle = TournamentLifecycle(
      status: tournament.status,
      isOrganizer: true,
    );

    final format = parseTournamentFormat(tournament.tournamentFormat);

    return _TournamentContext(
      lifecycle: lifecycle,
      format: format,
      tournamentId: tournament.id,
    );
  }

  Future<void> submitResult({
    required String slug,
    required String matchId,
    required int team1Score,
    required int team2Score,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final context = await _getContext(slug);

      if (!context.lifecycle.canSubmitMatch) {
        throw Exception('Match submission not allowed');
      }

      await _matchService.submitMatchResult(
        matchId: matchId,
        team1Score: team1Score,
        team2Score: team2Score,
      );

      ref.invalidate(matchProvider(slug));
    });
  }

  Future<void> generateInitialFixtures(String slug) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final context = await _getContext(slug);

      if (!context.lifecycle.canStartTournament) {
        throw Exception('Cannot generate fixtures in current state');
      }

      switch (context.format) {
        case TournamentFormat.knockout:
          await _matchService.generateKnockoutInitial(context.tournamentId);
          break;

        case TournamentFormat.league:
        case TournamentFormat.leaguePlusKnockout:
          await _matchService.assignTeamsToGroups(context.tournamentId);
          await _matchService.generateGroupFixtures(context.tournamentId);
          break;
      }

      ref.invalidate(matchProvider(slug));
    });
  }

  Future<void> advanceKnockoutRound({
    required String slug,
    required String currentRound,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final context = await _getContext(slug);

      await _matchService.advanceKnockoutRound(
        tournamentId: context.tournamentId,
        round: currentRound,
      );

      ref.invalidate(matchProvider(slug));
    });
  }
}

class _TournamentContext {
  final TournamentLifecycle lifecycle;
  final TournamentFormat format;
  final String tournamentId;

  _TournamentContext({
    required this.lifecycle,
    required this.format,
    required this.tournamentId,
  });
}

final matchActionProvider = AsyncNotifierProvider<MatchActionNotifier, void>(
  MatchActionNotifier.new,
);
