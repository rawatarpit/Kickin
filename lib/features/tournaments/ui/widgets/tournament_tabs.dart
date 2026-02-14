import 'package:flutter/material.dart';
import '../../../../core/theme/kickin_spacing.dart';
import '../../../../core/theme/kickin_typography.dart';

class TournamentTabs extends StatelessWidget {
  final TabController controller;
  final List<String> tabs;

  const TournamentTabs({
    super.key,
    required this.controller,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: KickinSpacing.lg),
      alignment: Alignment.centerLeft,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Theme.of(context).primaryColor,
        indicatorWeight: 3,
        labelStyle: KickinTypography.body.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelColor: Colors.grey.shade500,
        labelColor: Theme.of(context).primaryColor,
        splashFactory: NoSplash.splashFactory,
        tabs:
            tabs
                .map(
                  (title) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Tab(text: title),
                  ),
                )
                .toList(),
      ),
    );
  }
}
