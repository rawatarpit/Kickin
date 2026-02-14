class ContentIdentity {
  final String id;
  final String displayName;
  final String? username;
  final String? avatarUrl;
  final bool isVerified;

  const ContentIdentity({
    required this.id,
    required this.displayName,
    this.username,
    this.avatarUrl,
    this.isVerified = false,
  });
}
