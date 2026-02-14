import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/supabase/supabase_provider.dart';
import '../data/tournament_service.dart';
import '../domain/models/tournament_model.dart';

/// ===============================================
/// Service
/// ===============================================

final tournamentServiceProvider = Provider<TournamentService>((ref) {
  final client = ref.read(supabaseClientProvider);
  return TournamentService(client);
});

/// ===============================================
/// Discover List
/// ===============================================

final tournamentProvider = FutureProvider<List<TournamentModel>>((ref) async {
  final service = ref.read(tournamentServiceProvider);
  return service.fetchDiscoverTournaments();
});

/// ===============================================
/// Discover Realtime
/// ===============================================

final tournamentRealtimeProvider = Provider<void>((ref) {
  final client = ref.read(supabaseClientProvider);

  final channel =
      client
          .channel('rt_tournaments_discover')
          .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'tournaments',
            callback: (_) => ref.invalidate(tournamentProvider),
          )
          .subscribe();

  ref.onDispose(() => channel.unsubscribe());
});

/// ===============================================
/// Detail (Slug Based)
/// ===============================================

final tournamentDetailProvider =
    FutureProvider.family<TournamentModel?, String>((ref, slug) async {
      final service = ref.read(tournamentServiceProvider);
      return service.fetchTournamentBySlug(slug);
    });

/// ===============================================
/// Summary (Slug Based)
/// ===============================================

final tournamentSummaryProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, slug) async {
      final service = ref.read(tournamentServiceProvider);
      return service.fetchTournamentSummaryBySlug(slug);
    });

/// ===============================================
/// Rounds (Slug Based)
/// ===============================================

final tournamentRoundsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((
      ref,
      slug,
    ) async {
      final service = ref.read(tournamentServiceProvider);
      return service.fetchTournamentRoundsBySlug(slug);
    });
