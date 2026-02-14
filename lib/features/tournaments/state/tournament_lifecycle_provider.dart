import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/models/tournament_model.dart';
import '../domain/tournament_lifecycle.dart';

final tournamentLifecycleProvider =
    Provider.family<TournamentLifecycle, TournamentModel>((ref, tournament) {
      final currentUser = Supabase.instance.client.auth.currentUser;

      final isOrganizer =
          currentUser != null &&
          tournament.createdBy != null &&
          currentUser.id == tournament.createdBy;

      return TournamentLifecycle(
        status: tournament.status,
        isOrganizer: isOrganizer,
      );
    });
