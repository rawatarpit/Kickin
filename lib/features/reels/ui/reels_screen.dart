import 'package:flutter/material.dart';

import '../../../core/models/feed_item_ui_model.dart';
import '../../../core/widgets/feed/feed_actions.dart';
import '../../../core/navigation/bottom_nav_shell.dart';
import '../../../core/shell/app_scaffold.dart';
import '../../../core/auth/user_role.dart';
import '../logic/reel_controller_pool.dart';
import 'reel_player.dart';

class ReelsScreen extends StatefulWidget {
  final List<FeedItemUIModel> reels;
  final int initialIndex;
  final UserRole userRole;

  const ReelsScreen({
    super.key,
    required this.reels,
    required this.initialIndex,
    required this.userRole,
  });

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  late final PageController _pageController;
  final ReelControllerPool _controllerPool = ReelControllerPool();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);

    _preloadAround(_currentIndex);
  }

  Future<void> _preloadAround(int index) async {
    final currentItem = widget.reels[index];

    // Preload current
    await _controllerPool.preload(
      index: index,
      url: currentItem.mediaUrls.first,
    );

    // Preload next
    if (index + 1 < widget.reels.length) {
      _controllerPool.preload(
        index: index + 1,
        url: widget.reels[index + 1].mediaUrls.first,
      );
    }

    // Dispose far controllers
    _controllerPool.disposeOutsideWindow(index);

    setState(() {});
  }

  @override
  void dispose() {
    _controllerPool.disposeAll();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentTab: BottomNavItem.reels,
      userRole: widget.userRole,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.reels.length,
        onPageChanged: (index) async {
          _currentIndex = index;
          await _preloadAround(index);
        },
        itemBuilder: (_, index) {
          final item = widget.reels[index];
          final controller = _controllerPool[index];

          if (controller == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              /// VIDEO PLAYER
              ReelPlayer(
                controller: controller,
                isActive: index == _currentIndex,
              ),

              /// ACTIONS
              Positioned(
                right: 16,
                bottom: 120,
                child: FeedActions(
                  actions: item,
                  contentType: item.contentType,
                  onLike: () {},
                  onComment: () {},
                  onShare: () {},
                ),
              ),

              /// SPONSORED LABEL
              if (item.isSponsored)
                const Positioned(
                  top: 48,
                  right: 16,
                  child: Chip(label: Text('Sponsored')),
                ),
            ],
          );
        },
      ),
    );
  }
}
