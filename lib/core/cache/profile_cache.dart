class ProfileCache {
  static final Map<String, Map<String, dynamic>> _cache = {};

  static Map<String, dynamic>? get(String firebaseUid) {
    return _cache[firebaseUid];
  }

  static void set(String firebaseUid, Map<String, dynamic> profile) {
    _cache[firebaseUid] = profile;
  }

  static void clear() {
    _cache.clear();
  }
}
