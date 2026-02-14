import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/activity_provider.dart';
import '../../domain/models/activity_model.dart';

enum TimelineFilter { all, goals, cards, status }

class TournamentTimelineScreen extends ConsumerStatefulWidget {
  final String tournamentId;

  const TournamentTimelineScreen({super.key, required this.tournamentId});

  @override
  ConsumerState<TournamentTimelineScreen> createState() =>
      _TournamentTimelineScreenState();
}

class _TournamentTimelineScreenState
    extends ConsumerState<TournamentTimelineScreen> {
  TimelineFilter _filter = TimelineFilter.all;

  @override
  Widget build(BuildContext context) {
    final activityAsync = ref.watch(
      tournamentActivityProvider(widget.tournamentId),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Tournament Timeline")),
      body: activityAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (activities) {
          final filtered = _applyFilter(activities);

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filtered.length,
            itemBuilder: (_, index) {
              final activity = filtered[index];
              return _AnimatedTimelineTile(activity: activity);
            },
          );
        },
      ),
    );
  }

  List<TournamentActivity> _applyFilter(List<TournamentActivity> activities) {
    switch (_filter) {
      case TimelineFilter.goals:
        return activities.where((a) => a.isGoal).toList();
      case TimelineFilter.cards:
        return activities.where((a) => a.isYellow || a.isRed).toList();
      case TimelineFilter.status:
        return activities.where((a) => a.isStatus).toList();
      case TimelineFilter.all:
      default:
        return activities;
    }
  }
}

class _AnimatedTimelineTile extends StatefulWidget {
  final TournamentActivity activity;

  const _AnimatedTimelineTile({required this.activity});

  @override
  State<_AnimatedTimelineTile> createState() => _AnimatedTimelineTileState();
}

class _AnimatedTimelineTileState extends State<_AnimatedTimelineTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _offset = Tween<Offset>(
      begin: const Offset(0.1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final activity = widget.activity;

    return SlideTransition(
      position: _offset,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xFF1A1A1A),
        ),
        child: Text(
          activity.meta ?? activity.type,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
