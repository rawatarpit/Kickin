// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class CustomScoreboardTable extends StatefulWidget {
  final double height;
  final double width;
  final double leftColumnWidth;
  final List<dynamic>? standings;
  final int qualifiedCount;

  const CustomScoreboardTable({
    Key? key,
    required this.height,
    required this.width,
    this.leftColumnWidth = 100,
    this.standings,
    this.qualifiedCount = 0,
  }) : super(key: key);

  @override
  _CustomScoreboardTableState createState() => _CustomScoreboardTableState();
}

class _CustomScoreboardTableState extends State<CustomScoreboardTable> {
  static const Color background = Color(0xFF1F1F27);
  static const Color evenRow = Color(0xFF2A2A35);
  static const Color oddRow = Color(0xFF24242E);
  static const Color headerBg = Color(0xFF2F2F3F);
  static const Color textColor = Colors.white;
  static const Color qualifiedDotColor = Colors.green;

  final List<String> headers = ['MP', 'W', 'D', 'L', 'GF', 'GA', 'GD', 'Pts'];

  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _leftColumnScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _verticalScrollController.addListener(() {
      if (_leftColumnScrollController.hasClients &&
          _leftColumnScrollController.offset !=
              _verticalScrollController.offset) {
        _leftColumnScrollController.jumpTo(_verticalScrollController.offset);
      }
    });

    _leftColumnScrollController.addListener(() {
      if (_verticalScrollController.hasClients &&
          _verticalScrollController.offset !=
              _leftColumnScrollController.offset) {
        _verticalScrollController.jumpTo(_leftColumnScrollController.offset);
      }
    });
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    _leftColumnScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.standings ?? [];
    final qualifiedCount = widget.qualifiedCount;

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Left Fixed Column (Team names)
          SizedBox(
            width: widget.leftColumnWidth,
            child: Column(
              children: [
                // Left Header
                Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  color: headerBg,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Team',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                ),
                // Left Team Names (scrolls vertically)
                Expanded(
                  child: ListView.builder(
                    controller: _leftColumnScrollController,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final team = data[index];
                      final rowColor = index % 2 == 0 ? evenRow : oddRow;
                      final rank = team['rank'] ?? (index + 1);

                      return Container(
                        height: 70,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 12),
                        color: rowColor,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '$rank',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: textColor,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                if (rank is int &&
                                    rank > 0 &&
                                    rank <= qualifiedCount)
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      color: qualifiedDotColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              team['team_name'] ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Right side: Header + Body in one horizontally scrollable widget
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  // Header Row (right side)
                  Row(
                    children: headers.map((h) {
                      return Container(
                        width: 60,
                        height: 56,
                        alignment: Alignment.center,
                        color: headerBg,
                        child: Text(
                          h,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: textColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  // Body Rows (scrolls vertically)
                  Expanded(
                    child: SizedBox(
                      height: widget.height - 56, // minus header height
                      width: headers.length * 60,
                      child: ListView.builder(
                        controller: _verticalScrollController,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final team = data[index];
                          final rowColor = index % 2 == 0 ? evenRow : oddRow;
                          final values = [
                            team['matches_played'],
                            team['wins'],
                            team['draws'],
                            team['losses'],
                            team['goals_for'],
                            team['goals_against'],
                            team['goal_difference'],
                            team['points'],
                          ];

                          return Container(
                            height: 70,
                            color: rowColor,
                            child: Row(
                              children: values.map((v) {
                                return Container(
                                  width: 60,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${v ?? '-'}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: textColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
