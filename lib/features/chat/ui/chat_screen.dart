import 'package:flutter/material.dart';
import 'message_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              MessageBubble(text: 'Hey!', isMe: false),
              MessageBubble(text: 'Match at 6?', isMe: true),
              MessageBubble(text: 'Confirmed 👍', isMe: false),
            ],
          ),
        ),
        _InputBar(),
      ],
    );
  }
}

class _InputBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Message...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.send), onPressed: () {}),
        ],
      ),
    );
  }
}
