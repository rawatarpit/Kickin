import 'package:supabase_flutter/supabase_flutter.dart';
import '../adapters/feed_item_adapter.dart';
import '../models/feed_item_ui_model.dart';

class FeedPaginationService {
  final SupabaseClient _client = Supabase.instance.client;

  DateTime? _lastCreatedAt;
  bool _hasMore = true;

  bool get hasMore => _hasMore;

  void reset() {
    _lastCreatedAt = null;
    _hasMore = true;
  }

  Future<List<FeedItemUIModel>> loadNext({int limit = 10}) async {
    if (!_hasMore) return [];

    // 1. Start with .select() to get a PostgrestFilterBuilder
    // This allows us to use filters like .lt(), .eq(), etc.
    var query = _client.from('posts').select();

    // 2. Apply filters to the PostgrestFilterBuilder
    if (_lastCreatedAt != null) {
      query = query.lt('created_at', _lastCreatedAt!.toIso8601String());
    }

    // 3. Chain ordering and limits, then execute
    final response = await query
        .order('created_at', ascending: false)
        .limit(limit);

    // Supabase usually returns a List<Map<String, dynamic>> for selects
    final List<dynamic> rows = response;

    if (rows.isEmpty) {
      _hasMore = false;
      return [];
    }

    final items =
        rows
            .map(
              (row) =>
                  FeedItemAdapter.fromSupabase(row as Map<String, dynamic>),
            )
            .toList();

    // Update the cursor for the next page
    if (items.isNotEmpty) {
      _lastCreatedAt = items.last.createdAt;
    }

    // If we fetched fewer items than the limit, we've reached the end
    if (items.length < limit) {
      _hasMore = false;
    }

    return items;
  }
}
