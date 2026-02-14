import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/supabase/supabase_provider.dart';
import 'tournament_notifier.dart';
import 'match_notifier.dart';
import 'group_standing_provider.dart';
import 'activity_provider.dart';

/// ===============================================================
/// PUBLIC TOURNAMENT REALTIME PROVIDER
/// Handles:
/// - Match updates
/// - Tournament status updates
/// - Match event inserts
/// ===============================================================

final tournamentDetailRealtimeProvider = Provider.family<void, String>((
  ref,
  slug,
) {
  final client = ref.read(supabaseClientProvider);

  RealtimeChannel? matchChannel;
  RealtimeChannel? tournamentChannel;
  RealtimeChannel? activityChannel;

  final tournamentAsync = ref.watch(tournamentDetailProvider(slug));

  tournamentAsync.whenData((tournament) async {
    if (tournament == null) return;

    final tournamentId = tournament.id;

    matchChannel?.unsubscribe();
    tournamentChannel?.unsubscribe();
    activityChannel?.unsubscribe();

    // MATCH UPDATES
    matchChannel =
        client
            .channel('rt_matches_$tournamentId')
            .onPostgresChanges(
              event: PostgresChangeEvent.update,
              schema: 'public',
              table: 'ktm_matches',
              filter: PostgresChangeFilter(
                type: PostgresChangeFilterType.eq,
                column: 'tournament_id',
                value: tournamentId,
              ),
              callback: (_) {
                ref.invalidate(matchProvider(slug));
                ref.invalidate(tournamentGroupStandingsProvider(slug));
                ref.invalidate(tournamentActivityProvider(slug));
              },
            )
            .subscribe();

    // TOURNAMENT STATUS
    tournamentChannel =
        client
            .channel('rt_tournament_$tournamentId')
            .onPostgresChanges(
              event: PostgresChangeEvent.update,
              schema: 'public',
              table: 'tournaments',
              filter: PostgresChangeFilter(
                type: PostgresChangeFilterType.eq,
                column: 'tournament_id',
                value: tournamentId,
              ),
              callback: (_) {
                ref.invalidate(tournamentDetailProvider(slug));
                ref.invalidate(tournamentActivityProvider(slug));
              },
            )
            .subscribe();

    // MATCH EVENTS
    activityChannel =
        client
            .channel('rt_events_$tournamentId')
            .onPostgresChanges(
              event: PostgresChangeEvent.insert,
              schema: 'public',
              table: 'ktm_match_events',
              filter: PostgresChangeFilter(
                type: PostgresChangeFilterType.eq,
                column: 'tournament_id',
                value: tournamentId,
              ),
              callback: (_) {
                ref.invalidate(tournamentActivityProvider(slug));
              },
            )
            .subscribe();
  });

  ref.onDispose(() async {
    await matchChannel?.unsubscribe();
    await tournamentChannel?.unsubscribe();
    await activityChannel?.unsubscribe();
  });
});
