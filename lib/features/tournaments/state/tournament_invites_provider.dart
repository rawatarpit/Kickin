import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/invitation_service.dart';
import '../domain/models/invitation_model.dart';

final invitationServiceProvider = Provider<InvitationService>((ref) {
  final client = Supabase.instance.client;
  return InvitationService(client);
});

final tournamentInvitesProvider =
    FutureProvider.family<List<InvitationModel>, String>((
      ref,
      tournamentId,
    ) async {
      final service = ref.read(invitationServiceProvider);
      return service.fetchInvitesByTournament(tournamentId);
    });
