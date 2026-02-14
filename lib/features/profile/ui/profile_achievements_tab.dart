import 'package:flutter/material.dart';

class ProfileAchievementsTab extends StatelessWidget {
  const ProfileAchievementsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      itemCount: 3,
      separatorBuilder: (_, __) => const Divider(height: 24),
      itemBuilder: (_, i) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('State Level Player', style: TextStyle(fontSize: 15)),
            SizedBox(height: 4),
            Text(
              'Represented Delhi State',
              style: TextStyle(fontSize: 12, color: Colors.white54),
            ),
          ],
        );
      },
    );
  }
}
