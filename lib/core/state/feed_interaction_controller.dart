import 'package:flutter/foundation.dart';

class FeedInteractionController extends ChangeNotifier {
  final Map<String, bool> _liked = {};
  final Map<String, bool> _saved = {};

  bool isLiked(String id, bool fallback) =>
      _liked.containsKey(id) ? _liked[id]! : fallback;

  bool isSaved(String id, bool fallback) =>
      _saved.containsKey(id) ? _saved[id]! : fallback;

  void toggleLike(String id, bool current) {
    _liked[id] = !current;
    notifyListeners();

    _syncLike(id, !current);
  }

  void toggleSave(String id, bool current) {
    _saved[id] = !current;
    notifyListeners();

    _syncSave(id, !current);
  }

  Future<void> _syncLike(String id, bool value) async {
    // TODO: Supabase update
  }

  Future<void> _syncSave(String id, bool value) async {
    // TODO: Supabase update
  }
}
