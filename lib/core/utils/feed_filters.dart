import '../models/feed_item_ui_model.dart';
import '../content/content_type.dart';

class FeedFilters {
  static List<FeedItemUIModel> reelsOnly(List<FeedItemUIModel> items) {
    return items.where((item) {
      return item.contentType == ContentType.reel ||
          (item.contentType == ContentType.ad && item.isVideo);
    }).toList();
  }

  static List<FeedItemUIModel> organicOnly(List<FeedItemUIModel> items) {
    return items.where((item) => item.contentType != ContentType.ad).toList();
  }

  static List<FeedItemUIModel> adsOnly(List<FeedItemUIModel> items) {
    return items.where((item) => item.contentType == ContentType.ad).toList();
  }
}
