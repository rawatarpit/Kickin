import 'package:flutter/material.dart';

class ReportedUsersScreen extends StatelessWidget {
  const ReportedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reported Users'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        itemCount: 2,
        separatorBuilder: (_, __) => const Divider(height: 24),
        itemBuilder: (_, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Reported User Name', style: TextStyle(fontSize: 15)),
              SizedBox(height: 4),
              Text(
                'Reason: Inappropriate content',
                style: TextStyle(fontSize: 12, color: Colors.white54),
              ),
              SizedBox(height: 4),
              Text(
                'Status: Under review',
                style: TextStyle(fontSize: 12, color: Colors.white54),
              ),
            ],
          );
        },
      ),
    );
  }
}
