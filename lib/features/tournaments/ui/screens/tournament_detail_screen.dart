import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/shell/app_scaffold.dart';
import '../../../../core/navigation/bottom_nav_shell.dart';
import '../../../../core/auth/current_user_role_provider.dart';
import '../../../../core/auth/user_role.dart';

import '../../domain/models/tournament_model.dart';
import '../../domain/tournament_lifecycle.dart';
import '../../domain/tournament_tab.dart';

import '../../state/tournament_notifier.dart';
import '../../state/tournament_lifecycle_provider.dart';
import '../../state/activity_provider.dart';
import '../../state/tournament_detail_realtime_provider.dart';

import '../widgets/tournament_tabs.dart';
import 'teams_screen.dart';
import 'scores_screen.dart';

class TournamentDetailScreen extends ConsumerStatefulWidget {
  final String slug;
  final String? initialTab;

  const TournamentDetailScreen({
    super.key,
    required this.slug,
    this.initialTab,
  });

  @override
  ConsumerState<TournamentDetailScreen> createState() =>
      _TournamentDetailScreenState();
}

class _TournamentDetailScreenState extends ConsumerState<TournamentDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<TournamentTab> tabs = [
    TournamentTab.teams,
    TournamentTab.scores,
    TournamentTab.standings,
  ];

  @override
  void initState() {
    super.initState();

    final initial = parseTournamentTab(widget.initialTab);

    final initialIndex = tabs.contains(initial) ? tabs.indexOf(initial) : 0;

    _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: initialIndex,
    );

    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) return;

    final selectedTab = tabs[_tabController.index];

    final tabPath = tournamentTabToPath(selectedTab);

    final newPath =
        tabPath.isEmpty
            ? '/tournament/${widget.slug}'
            : '/tournament/${widget.slug}/$tabPath';

    Navigator.of(context).pushReplacementNamed(newPath);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ref = this.ref;

    // Activate realtime
    ref.watch(tournamentDetailRealtimeProvider(widget.slug));

    final tournamentAsync = ref.watch(tournamentDetailProvider(widget.slug));

    final roleAsync = ref.watch(currentUserRoleProvider);

    return tournamentAsync.when(
      loading: () => const _ShimmerDetail(),
      error:
          (_, __) =>
              const Scaffold(body: Center(child: Text("Failed to load"))),
      data: (tournament) {
        if (tournament == null) {
          return const Scaffold(
            body: Center(child: Text("Tournament not found")),
          );
        }

        final lifecycle = ref.watch(tournamentLifecycleProvider(tournament));

        return roleAsync.when(
          loading: () => const _ShimmerDetail(),
          error:
              (_, __) =>
                  const Scaffold(body: Center(child: Text("Role error"))),
          data: (UserRole role) {
            return AppScaffold(
              currentTab: BottomNavItem.home,
              userRole: role,
              body: Column(
                children: [
                  _HeaderSection(tournament: tournament, lifecycle: lifecycle),
                  _ActivityStrip(slug: widget.slug),
                  TournamentTabs(
                    controller: _tabController,
                    tabs: const ['Teams', 'Scores', 'Standings'],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        TeamsScreen(tournament: tournament),
                        ScoresScreen(
                          tournament: tournament,
                          teamNameMap: const {},
                        ),
                        const Center(child: Text("Standings tab")),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final TournamentModel tournament;
  final TournamentLifecycle lifecycle;

  const _HeaderSection({required this.tournament, required this.lifecycle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tournament.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              if (lifecycle.showLiveBanner) _badge("LIVE", Colors.red),
              if (lifecycle.showCompletedBanner)
                _badge("COMPLETED", Colors.green),
              if (lifecycle.showRegistrationBanner)
                _badge("REGISTRATION", Colors.blue),
              if (lifecycle.showCancelledBanner)
                _badge("CANCELLED", Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _badge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ActivityStrip extends ConsumerWidget {
  final String slug;

  const _ActivityStrip({required this.slug});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityAsync = ref.watch(tournamentActivityProvider(slug));

    return activityAsync.when(
      loading: () => const SizedBox(height: 80),
      error: (_, __) => const SizedBox(),
      data: (activities) {
        if (activities.isEmpty) return const SizedBox();

        return SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: activities.length,
            itemBuilder: (_, index) {
              final a = activities[index];

              return Container(
                width: 220,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFF1A1A1A),
                ),
                child: Text(
                  a.meta ?? a.type,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _ShimmerDetail extends StatelessWidget {
  const _ShimmerDetail();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
