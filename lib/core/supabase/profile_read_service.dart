import 'package:firebase_auth/firebase_auth.dart';

import '../cache/profile_cache.dart';
import 'supabase_client.dart';

class ProfileReadService {
  static Future<Map<String, dynamic>?> fetch(String firebaseUid) async {
    final cached = ProfileCache.get(firebaseUid);
    if (cached != null) {
      return cached;
    }

    final res =
        await SupabaseClientProvider.client
            .from('profiles')
            .select()
            .eq('user_id', firebaseUid)
            .maybeSingle();

    if (res != null) {
      ProfileCache.set(firebaseUid, res);
    }

    return res;
  }

  static Future<Map<String, dynamic>?> fetchMe() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return Future.value(null);
    return fetch(uid);
  }
}
