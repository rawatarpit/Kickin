import '../models/feed_item_ui_model.dart';

class AdInjectionEngine {
  static List<FeedItemUIModel> injectAds({
    required List<FeedItemUIModel> items,
    required List<FeedItemUIModel> ads,
    int frequency = 4,
  }) {
    if (ads.isEmpty || items.isEmpty) return items;

    final List<FeedItemUIModel> result = [];
    int adIndex = 0;

    for (int i = 0; i < items.length; i++) {
      result.add(items[i]);

      if ((i + 1) % frequency == 0 && adIndex < ads.length) {
        result.add(ads[adIndex]);
        adIndex++;
      }
    }

    return result;
  }
}
