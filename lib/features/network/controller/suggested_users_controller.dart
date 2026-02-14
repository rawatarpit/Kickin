import 'package:firebase_auth/firebase_auth.dart';

import '../data/nearby_users_remote.dart';
import '../domain/discovery_ranker.dart';

class SuggestedUsersController {
  static Future<List<Map<String, dynamic>>> load() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return [];

    final raw = await NearbyUsersRemote.fetch(
      currentUserId: uid,
      role: 'Player',
    );

    final ranked =
        raw.map((u) {
          final distanceKm = (u['distance_km'] as num).toDouble();
          final mutualCount = (u['mutual_user_ids'] as List).length;

          final score = computeDiscoveryScore(
            distanceKm: distanceKm,
            mutualCount: mutualCount,
          );

          return {...u, 'score': score};
        }).toList();

    ranked.sort((a, b) => b['score'].compareTo(a['score']));
    return ranked;
  }
}
