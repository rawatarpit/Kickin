import '../models/feed_item_ui_model.dart';
import '../content/content_identity.dart';
import '../content/content_type.dart';

class FeedItemAdapter {
  static FeedItemUIModel fromSupabase(Map<String, dynamic> row) {
    return FeedItemUIModel(
      identity: ContentIdentity(
        id: row['id'], // ✅ content id (NOT user_id)
        displayName: row['username'] ?? '',
        username: row['username'],
        avatarUrl: row['profile_image'],
        isVerified: row['is_verified'] ?? false,
      ),
      mediaUrls:
          row['media_urls'] != null
              ? List<String>.from(row['media_urls'])
              : const [],
      isVideo: row['media_type'] == 'video',
      aspectRatio:
          row['aspect_ratio'] != null
              ? (row['aspect_ratio'] as num).toDouble()
              : null,
      likeCount: row['like_count'] ?? 0,
      commentCount: row['comment_count'] ?? 0,
      saveCount: row['save_count'] ?? 0,
      isLiked: row['is_liked'] ?? false,
      isSaved: row['is_saved'] ?? false,
      contentType: _mapType(row['content_type']),
      createdAt: DateTime.parse(row['created_at']),
      isSponsored: row['is_sponsored'] ?? false,
    );
  }

  static ContentType _mapType(String? type) {
    switch (type) {
      case 'reel':
        return ContentType.reel;
      case 'job':
        return ContentType.job;
      case 'trial':
        return ContentType.trial;
      case 'tournament':
        return ContentType.tournament;
      case 'profile':
        return ContentType.profile;
      case 'ad':
        return ContentType.ad;
      default:
        return ContentType.post;
    }
  }
}
