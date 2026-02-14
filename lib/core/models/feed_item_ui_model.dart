import '../contracts/feed_identity_contract.dart';
import '../contracts/feed_media_contract.dart';
import '../contracts/feed_actions_contract.dart';
import '../contracts/feed_meta_contract.dart';
import '../content/content_type.dart';
import '../content/content_identity.dart';

class FeedItemUIModel
    implements
        FeedIdentityContract,
        FeedMediaContract,
        FeedActionsContract,
        FeedMetaContract {
  // Identity
  @override
  final ContentIdentity identity;

  // Media
  @override
  final List<String> mediaUrls;
  @override
  final bool isVideo;
  @override
  final double? aspectRatio;

  // Actions
  @override
  final int likeCount;
  @override
  final int commentCount;
  @override
  final int saveCount;
  @override
  final bool isLiked;
  @override
  final bool isSaved;

  // Meta
  @override
  final ContentType contentType;
  @override
  final DateTime createdAt;
  @override
  final bool isSponsored;

  const FeedItemUIModel({
    required this.identity,
    required this.mediaUrls,
    required this.isVideo,
    this.aspectRatio,
    required this.likeCount,
    required this.commentCount,
    required this.saveCount,
    required this.isLiked,
    required this.isSaved,
    required this.contentType,
    required this.createdAt,
    this.isSponsored = false,
  });
}
