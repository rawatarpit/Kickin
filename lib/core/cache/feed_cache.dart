import '../models/feed_item_ui_model.dart';

class FeedCache {
  FeedCache._();
  static final FeedCache instance = FeedCache._();

  final List<FeedItemUIModel> _items = [];

  List<FeedItemUIModel> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  void set(List<FeedItemUIModel> newItems) {
    _items
      ..clear()
      ..addAll(newItems);
  }

  void append(List<FeedItemUIModel> newItems) {
    final existingIds = _items.map((e) => e.identity.id).toSet();

    for (final item in newItems) {
      if (!existingIds.contains(item.identity.id)) {
        _items.add(item);
      }
    }
  }

  void update(FeedItemUIModel updatedItem) {
    final index = _items.indexWhere(
      (e) => e.identity.id == updatedItem.identity.id,
    );

    if (index != -1) {
      _items[index] = updatedItem;
    }
  }

  void remove(String id) {
    _items.removeWhere((e) => e.identity.id == id);
  }

  void clear() {
    _items.clear();
  }
}
