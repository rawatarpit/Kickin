import 'package:flutter/material.dart';

class ProfileExperienceTab extends StatelessWidget {
  const ProfileExperienceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      itemCount: 2,
      separatorBuilder: (_, __) => const Divider(height: 24),
      itemBuilder: (_, i) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Midfielder', style: TextStyle(fontSize: 15)),
            SizedBox(height: 4),
            Text(
              'Delhi FC · 2022–Present',
              style: TextStyle(fontSize: 12, color: Colors.white54),
            ),
          ],
        );
      },
    );
  }
}
