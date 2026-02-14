import 'package:flutter/material.dart';
import '../../../core/theme/kickin_typography.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        _ChatTile(username: 'Arpit Rawat', lastMessage: 'Let’s play tomorrow'),
        _ChatTile(username: 'Kickin Team', lastMessage: 'Fixtures updated'),
        _ChatTile(username: 'Delhi FC', lastMessage: 'Trial details?'),
      ],
    );
  }
}

class _ChatTile extends StatelessWidget {
  final String username;
  final String lastMessage;

  const _ChatTile({required this.username, required this.lastMessage});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(username, style: KickinTypography.body),
      subtitle: Text(lastMessage, style: KickinTypography.bodyMuted),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
