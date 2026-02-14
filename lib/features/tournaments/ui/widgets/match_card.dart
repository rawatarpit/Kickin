import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/match_model.dart';
import '../../state/match_notifier.dart';

class MatchCard extends ConsumerStatefulWidget {
  final MatchModel match;
  final String team1Name;
  final String team2Name;
  final String slug; // ✅ SLUG
  final bool canEditMatch;

  const MatchCard({
    super.key,
    required this.match,
    required this.team1Name,
    required this.team2Name,
    required this.slug,
    required this.canEditMatch,
  });

  @override
  ConsumerState<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends ConsumerState<MatchCard> {
  bool _highlight = false;
  int? _previousScoreHash;

  @override
  void initState() {
    super.initState();
    _previousScoreHash = _scoreHash();
  }

  @override
  void didUpdateWidget(covariant MatchCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newHash = _scoreHash();
    if (_previousScoreHash != null && newHash != _previousScoreHash) {
      _triggerHighlight();
    }
    _previousScoreHash = newHash;
  }

  int _scoreHash() {
    return (widget.match.team1Score ?? 0) * 100 +
        (widget.match.team2Score ?? 0);
  }

  void _triggerHighlight() {
    setState(() => _highlight = true);
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() => _highlight = false);
    });
  }

  bool get _isEditable => widget.canEditMatch && !widget.match.isLocked;

  String _centerLabel() {
    if (widget.match.isCompleted) {
      return "${widget.match.team1Score ?? 0} - ${widget.match.team2Score ?? 0}";
    }
    if (widget.match.isOngoing) return "LIVE";

    if (widget.match.matchDate != null) {
      final dt = widget.match.matchDate!;
      return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    }

    return "VS";
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(matchActionProvider, (previous, next) {
      next.whenOrNull(
        error: (err, _) {
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(err.toString())));
        },
      );
    });

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: _highlight ? Colors.green.withOpacity(0.08) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: _isEditable ? () => _openScoreDialog(context) : null,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Expanded(child: Text(widget.team1Name)),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                _centerLabel(),
                key: ValueKey(_centerLabel()),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: widget.match.isOngoing ? Colors.red : Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(widget.team2Name),
              ),
            ),
            if (_isEditable)
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(Icons.edit, size: 18),
              ),
          ],
        ),
      ),
    );
  }

  void _openScoreDialog(BuildContext dialogContext) {
    final team1Controller = TextEditingController(
      text: widget.match.team1Score?.toString() ?? "",
    );
    final team2Controller = TextEditingController(
      text: widget.match.team2Score?.toString() ?? "",
    );

    showDialog(
      context: dialogContext,
      builder: (_) {
        return Consumer(
          builder: (context, ref, __) {
            final actionState = ref.watch(matchActionProvider);

            return AlertDialog(
              title: const Text("Submit Score"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: team1Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: widget.team1Name),
                  ),
                  TextField(
                    controller: team2Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: widget.team2Name),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed:
                      actionState.isLoading
                          ? null
                          : () async {
                            final team1Score =
                                int.tryParse(team1Controller.text) ?? 0;
                            final team2Score =
                                int.tryParse(team2Controller.text) ?? 0;

                            await ref
                                .read(matchActionProvider.notifier)
                                .submitResult(
                                  slug: widget.slug,
                                  matchId: widget.match.id,
                                  team1Score: team1Score,
                                  team2Score: team2Score,
                                );

                            if (!mounted) return;
                            Navigator.pop(dialogContext);
                          },
                  child:
                      actionState.isLoading
                          ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Text("Submit"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
