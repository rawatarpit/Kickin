class SuggestedUsersCache {
  static List<Map<String, dynamic>>? _data;
  static DateTime? _ts;

  static bool get valid =>
      _data != null &&
      DateTime.now().difference(_ts!) < const Duration(minutes: 20);

  static List<Map<String, dynamic>>? get() => valid ? _data : null;

  static void set(List<Map<String, dynamic>> data) {
    _data = data;
    _ts = DateTime.now();
  }

  static void clear() {
    _data = null;
    _ts = null;
  }
}
