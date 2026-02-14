class InvitationModel {
  final String id;
  final String? teamId;
  final String receiverId;
  final String senderId;
  final String? status;
  final String? tournamentId;
  final bool isRead;

  InvitationModel({
    required this.id,
    this.teamId,
    required this.receiverId,
    required this.senderId,
    this.status,
    this.tournamentId,
    required this.isRead,
  });

  factory InvitationModel.fromMap(Map<String, dynamic> map) {
    return InvitationModel(
      id: map['invitation_id'] ?? '',
      teamId: map['team_id'],
      receiverId: map['receiver_id'] ?? '',
      senderId: map['sender_id'] ?? '',
      status: map['status'],
      tournamentId: map['tournament_id'],
      isRead: map['is_read'] ?? false,
    );
  }
}
