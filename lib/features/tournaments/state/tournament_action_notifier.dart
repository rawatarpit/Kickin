import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/tournament_service.dart';
import '../domain/tournament_lifecycle.dart';
import 'tournament_notifier.dart';

class TournamentActionNotifier extends AsyncNotifier<void> {
  late final TournamentService _service;

  @override
  Future<void> build() async {
    _service = ref.read(tournamentServiceProvider);
  }

  Future<TournamentLifecycle> _getLifecycle(String slug) async {
    final tournament = await _service.fetchTournamentBySlug(slug);

    if (tournament == null) {
      throw Exception('Tournament not found');
    }

    final currentUser = Supabase.instance.client.auth.currentUser;

    final isOrganizer =
        currentUser != null &&
        tournament.createdBy != null &&
        currentUser.id == tournament.createdBy;

    return TournamentLifecycle(
      status: tournament.status,
      isOrganizer: isOrganizer,
    );
  }

  void _require(bool condition, String message) {
    if (!condition) throw Exception(message);
  }

  void _refresh(String slug) {
    ref.invalidate(tournamentDetailProvider(slug));
    ref.invalidate(tournamentProvider);
    ref.invalidate(tournamentSummaryProvider(slug));
    ref.invalidate(tournamentRoundsProvider(slug));
  }

  Future<void> openRegistration(String slug) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final lifecycle = await _getLifecycle(slug);
      _require(lifecycle.canOpenRegistration, 'Invalid lifecycle transition');

      await _service.toggleRegistrationSecure(
        slug: slug,
        allowRegistration: true,
      );

      _refresh(slug);
    });
  }

  Future<void> closeRegistration(String slug) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final lifecycle = await _getLifecycle(slug);
      _require(lifecycle.canCloseRegistration, 'Invalid lifecycle transition');

      await _service.toggleRegistrationSecure(
        slug: slug,
        allowRegistration: false,
      );

      _refresh(slug);
    });
  }

  Future<void> startTournament(String slug) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final lifecycle = await _getLifecycle(slug);
      _require(lifecycle.canStartTournament, 'Invalid lifecycle transition');

      await _service.changeStatus(
        slug: slug,
        newStatus: tournamentStatusToDb(TournamentStatus.ongoing),
      );

      _refresh(slug);
    });
  }

  Future<void> forceComplete(String slug) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final lifecycle = await _getLifecycle(slug);
      _require(lifecycle.canForceComplete, 'Invalid lifecycle transition');

      await _service.forceComplete(slug);
      _refresh(slug);
    });
  }

  Future<void> cancelTournament(String slug) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final lifecycle = await _getLifecycle(slug);
      _require(lifecycle.canCancel, 'Invalid lifecycle transition');

      await _service.cancelTournament(slug);
      _refresh(slug);
    });
  }

  Future<void> deleteTournament(String slug) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _service.deleteTournamentSecure(slug);
      ref.invalidate(tournamentProvider);
    });
  }
}

final tournamentActionProvider =
    AsyncNotifierProvider<TournamentActionNotifier, void>(
      TournamentActionNotifier.new,
    );
