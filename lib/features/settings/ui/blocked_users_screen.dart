import 'package:flutter/material.dart';

class BlockedUsersScreen extends StatelessWidget {
  const BlockedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocked Users'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        itemCount: 3,
        separatorBuilder: (_, __) => const Divider(height: 24),
        itemBuilder: (_, i) {
          return Row(
            children: [
              const CircleAvatar(radius: 18, backgroundColor: Colors.white24),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Blocked User Name',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Unblock',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
