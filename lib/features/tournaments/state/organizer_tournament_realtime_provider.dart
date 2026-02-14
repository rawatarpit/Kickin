import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/supabase/supabase_provider.dart';
import 'tournament_notifier.dart';
import 'match_notifier.dart';
import 'group_standing_provider.dart';
import 'activity_provider.dart';

/// ===============================================================
/// ORGANIZER REALTIME PROVIDER
/// More aggressive invalidation than public provider
/// ===============================================================

final organizerTournamentRealtimeProvider = Provider.family<void, String>((
  ref,
  slug,
) {
  final client = ref.read(supabaseClientProvider);

  RealtimeChannel? channel;

  final tournamentAsync = ref.watch(tournamentDetailProvider(slug));

  tournamentAsync.whenData((tournament) async {
    if (tournament == null) return;

    final tournamentId = tournament.id;

    channel?.unsubscribe();

    channel =
        client
            .channel('rt_organizer_$tournamentId')
            .onPostgresChanges(
              event: PostgresChangeEvent.all,
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
              },
            )
            .subscribe();
  });

  ref.onDispose(() async {
    await channel?.unsubscribe();
  });
});
