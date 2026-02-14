import 'package:flutter/material.dart';

class ScoresTab extends StatelessWidget {
  final List<Map<String, dynamic>> topScorers;

  const ScoresTab({super.key, required this.topScorers});

  @override
  Widget build(BuildContext context) {
    if (topScorers.isEmpty) {
      return const Center(child: Text("No scoring data available."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: topScorers.length,
      itemBuilder: (context, index) {
        final player = topScorers[index];

        return ListTile(
          leading: Text(
            "${index + 1}",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          title: Text(player['name'] ?? "Unknown"),
          trailing: Text("${player['goals'] ?? 0} Goals"),
        );
      },
    );
  }
}
