import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/activity_model.dart';
import '../data/tournament_service.dart';
import '../../../../core/supabase/supabase_provider.dart';
import 'tournament_notifier.dart';

final tournamentActivityProvider =
    FutureProvider.family<List<TournamentActivity>, String>((ref, slug) async {
      final client = ref.read(supabaseClientProvider);
      final tournamentService = ref.read(tournamentServiceProvider);

      final tournament = await tournamentService.fetchTournamentBySlug(slug);

      if (tournament == null) return [];

      final response = await client
          .from('ktm_tournament_activity')
          .select()
          .eq('tournament_id', tournament.id)
          .order('created_at', ascending: false);

      final list = response as List<dynamic>? ?? [];

      return list.map((e) => TournamentActivity.fromMap(e)).toList();
    });
