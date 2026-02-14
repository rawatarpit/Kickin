import '../content/content_type.dart';

abstract class FeedMetaContract {
  ContentType get contentType;
  DateTime get createdAt;

  /// Used by Feed to apply rules (ads, pinned, etc.)
  bool get isSponsored;
}
