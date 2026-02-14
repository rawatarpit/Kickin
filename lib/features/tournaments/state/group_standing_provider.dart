import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/standing_model.dart';
import '../data/tournament_service.dart';
import '../../../../core/supabase/supabase_provider.dart';
import 'tournament_notifier.dart';

final tournamentGroupStandingsProvider =
    FutureProvider.family<Map<String, List<StandingModel>>, String>((
      ref,
      slug,
    ) async {
      final client = ref.read(supabaseClientProvider);
      final tournamentService = ref.read(tournamentServiceProvider);

      final tournament = await tournamentService.fetchTournamentBySlug(slug);

      if (tournament == null) return {};

      final response = await client.rpc(
        'get_tournament_group_standings',
        params: {'input_tournament_id': tournament.id},
      );

      final data = response as List<dynamic>? ?? [];

      final Map<String, List<StandingModel>> grouped = {};

      for (final row in data) {
        final groupName = row['group_name'] ?? 'Group';

        final standing = StandingModel.fromMap(row);

        grouped.putIfAbsent(groupName, () => []);
        grouped[groupName]!.add(standing);
      }

      return grouped;
    });
