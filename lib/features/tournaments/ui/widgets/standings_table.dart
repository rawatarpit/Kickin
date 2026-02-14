import 'package:flutter/material.dart';
import '../../domain/models/standing_model.dart';

class StandingsTable extends StatelessWidget {
  final List<StandingModel> standings;

  const StandingsTable({super.key, required this.standings});

  @override
  Widget build(BuildContext context) {
    if (standings.isEmpty) {
      return const Center(child: Text("No standings available."));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 24,
        headingRowColor: MaterialStateProperty.all(Colors.grey.shade900),
        columns: const [
          DataColumn(label: Text("Pos")),
          DataColumn(label: Text("Team")),
          DataColumn(label: Text("P")),
          DataColumn(label: Text("W")),
          DataColumn(label: Text("D")),
          DataColumn(label: Text("L")),
          DataColumn(label: Text("GD")),
          DataColumn(label: Text("Pts")),
        ],
        rows:
            standings.map((s) {
              final isTopThree = (s.rank ?? 0) <= 3;

              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      (s.rank ?? 0).toString(),
                      style: TextStyle(
                        fontWeight:
                            isTopThree ? FontWeight.w700 : FontWeight.w400,
                      ),
                    ),
                  ),
                  DataCell(Text(s.teamName)),
                  DataCell(Text(s.matchesPlayed.toString())),
                  DataCell(Text(s.wins.toString())),
                  DataCell(Text(s.draws.toString())),
                  DataCell(Text(s.losses.toString())),
                  DataCell(Text(s.goalDifference.toString())),
                  DataCell(
                    Text(
                      s.points.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }
}
