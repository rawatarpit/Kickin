enum NotificationType {
  like,
  comment,
  follow,
  userInvite,
  tournamentOrgInvite,
  tournamentTeamInvite,
  tournamentUpdate,
  systemUpdate,
}

class AppNotification {
  final String id;
  final String receiverId;
  final String? senderId;
  final NotificationType type;
  final String message;
  final bool isRead;
  final DateTime createdAt;

  final String? postId;
  final String? commentId;
  final String? messageId;
  final String? tournamentId;

  AppNotification({
    required this.id,
    required this.receiverId,
    required this.senderId,
    required this.type,
    required this.message,
    required this.isRead,
    required this.createdAt,
    this.postId,
    this.commentId,
    this.messageId,
    this.tournamentId,
  });

  factory AppNotification.fromMap(Map<String, dynamic> data) {
    return AppNotification(
      id: data['id'],
      receiverId: data['receiver_id'],
      senderId: data['sender_id'],
      type: _parseType(data['type']),
      message: data['message'],
      isRead: data['is_read'] ?? false,
      createdAt: DateTime.parse(data['created_at']),
      postId: data['post_id'],
      commentId: data['comment_id'],
      messageId: data['message_id'],
      tournamentId: data['tournament_id'],
    );
  }

  static NotificationType _parseType(String raw) {
    switch (raw) {
      case 'like':
        return NotificationType.like;
      case 'comment':
        return NotificationType.comment;
      case 'follow':
        return NotificationType.follow;
      case 'user_invite':
        return NotificationType.userInvite;
      case 'tournament_org_invite':
        return NotificationType.tournamentOrgInvite;
      case 'tournament_team_invite':
        return NotificationType.tournamentTeamInvite;
      case 'tournament_update':
        return NotificationType.tournamentUpdate;
      default:
        return NotificationType.systemUpdate;
    }
  }

  bool get isRequest =>
      type == NotificationType.userInvite ||
      type == NotificationType.tournamentOrgInvite ||
      type == NotificationType.tournamentTeamInvite;

  bool get isTournament => type == NotificationType.tournamentUpdate;
}
