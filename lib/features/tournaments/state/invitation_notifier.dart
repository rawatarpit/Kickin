import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/invitation_service.dart';
import '../data/tournament_service.dart';
import '../domain/models/invitation_model.dart';
import '../domain/tournament_lifecycle.dart';
import '../../../../core/supabase/supabase_provider.dart';
import 'tournament_notifier.dart';

final invitationServiceProvider = Provider<InvitationService>((ref) {
  final client = ref.read(supabaseClientProvider);
  return InvitationService(client);
});

class InvitationNotifier extends AsyncNotifier<List<InvitationModel>> {
  late final InvitationService _service;
  late final TournamentService _tournamentService;

  late String _userId;

  final Set<String> _pendingInviteUserIds = {};

  @override
  Future<List<InvitationModel>> build() async {
    _service = ref.read(invitationServiceProvider);
    _tournamentService = ref.read(tournamentServiceProvider);
    return [];
  }

  Future<void> load(String userId) async {
    _userId = userId;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return _service.fetchMyInvites(userId);
    });
  }

  Future<void> sendInvite({
    required String teamId,
    required String receiverId,
    required String slug, // 🔥 SLUG instead of ID
  }) async {
    final tournament = await _tournamentService.fetchTournamentBySlug(slug);

    if (tournament == null) {
      throw Exception('Tournament not found');
    }

    final lifecycle = TournamentLifecycle(
      status: tournament.status,
      isOrganizer: false,
    );

    if (!lifecycle.canInvitePlayers) {
      throw Exception('Invites not allowed in current state');
    }

    _pendingInviteUserIds.add(receiverId);
    state = AsyncValue.data(state.value ?? []);

    try {
      await _service.sendInviteSecure(teamId: teamId, receiverId: receiverId);
    } catch (e) {
      _pendingInviteUserIds.remove(receiverId);
      state = AsyncValue.data(state.value ?? []);
      rethrow;
    }
  }

  bool isInvitePending(String userId) {
    return _pendingInviteUserIds.contains(userId);
  }

  Future<void> acceptInvite({
    required String invitationId,
    required String slug, // 🔥 SLUG instead of ID
  }) async {
    final tournament = await _tournamentService.fetchTournamentBySlug(slug);

    if (tournament == null) {
      throw Exception('Tournament not found');
    }

    final lifecycle = TournamentLifecycle(
      status: tournament.status,
      isOrganizer: false,
    );

    if (!lifecycle.canCreateTeam) {
      throw Exception('Cannot accept invite in current state');
    }

    await _service.acceptInviteSecure(invitationId);

    state = await AsyncValue.guard(() async {
      return _service.fetchMyInvites(_userId);
    });
  }
}

final invitationProvider =
    AsyncNotifierProvider<InvitationNotifier, List<InvitationModel>>(
      InvitationNotifier.new,
    );
