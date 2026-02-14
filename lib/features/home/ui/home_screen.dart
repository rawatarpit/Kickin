import 'package:flutter/material.dart';

import '../../../core/shell/app_scaffold.dart';
import '../../../core/navigation/bottom_nav_shell.dart';
import '../../../core/navigation/reels_launcher.dart';
import '../../../core/auth/user_role.dart';
import '../../../core/theme/kickin_spacing.dart';
import '../../../core/theme/kickin_colors.dart';
import '../../../core/widgets/common/section_header.dart';
import '../../../core/widgets/common/empty_state_view.dart';
import '../../../core/widgets/feed/feed_card.dart';
import '../../../core/models/feed_item_ui_model.dart';
import '../../../core/content/content_type.dart';
import '../../../core/services/feed_pagination_service.dart';
import '../../../core/cache/feed_cache.dart';
import '../../../core/engine/ad_injection_engine.dart';
import '../../../core/utils/feed_filters.dart';

import 'widgets/story_strip.dart';
import 'widgets/suggested_users_row.dart';
import 'create_post_sheet.dart';

class HomeScreen extends StatefulWidget {
  final UserRole userRole;

  const HomeScreen({super.key, required this.userRole});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FeedPaginationService _pagination = FeedPaginationService();
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;
  List<FeedItemUIModel> _items = [];

  @override
  void initState() {
    super.initState();
    _loadInitial();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadInitial() async {
    _pagination.reset();
    FeedCache.instance.clear();

    final items = await _pagination.loadNext();
    FeedCache.instance.set(items);

    setState(() {
      _items = _injectAds(FeedCache.instance.items);
    });
  }

  Future<void> _loadMore() async {
    if (_isLoading || !_pagination.hasMore) return;

    _isLoading = true;

    final items = await _pagination.loadNext();
    FeedCache.instance.append(items);

    setState(() {
      _items = _injectAds(FeedCache.instance.items);
    });

    _isLoading = false;
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 400) {
      _loadMore();
    }
  }

  List<FeedItemUIModel> _injectAds(List<FeedItemUIModel> items) {
    final ads = items.where((e) => e.contentType == ContentType.ad).toList();

    final organic =
        items.where((e) => e.contentType != ContentType.ad).toList();

    return AdInjectionEngine.injectAds(items: organic, ads: ads, frequency: 4);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentTab: BottomNavItem.home,
      userRole: widget.userRole,
      body:
          _items.isEmpty
              ? _emptyState()
              : CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(child: StoryStrip()),
                  const SliverToBoxAdapter(
                    child: Divider(height: 1, color: KickinColors.border),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(KickinSpacing.lg),
                      child: SectionHeader(
                        title: 'Feed',
                        subtitle: 'From players, clubs & academies',
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SuggestedUsersRow()),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = _items[index];

                      return FeedCard(
                        item: item,
                        onOpenReel:
                            item.isVideo
                                ? () {
                                  final reels = FeedFilters.reelsOnly(_items);

                                  final reelIndex = reels.indexWhere(
                                    (r) => r.identity.id == item.identity.id,
                                  );

                                  if (reelIndex >= 0) {
                                    ReelsLauncher.open(
                                      context: context,
                                      reels: reels,
                                      initialIndex: reelIndex,
                                      userRole: widget.userRole,
                                    );
                                  }
                                }
                                : null,
                      );
                    }, childCount: _items.length),
                  ),
                ],
              ),
      floatingActionButton:
          widget.userRole != UserRole.player
              ? FloatingActionButton(
                backgroundColor: KickinColors.primary,
                child: const Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => const CreatePostSheet(),
                  );
                },
              )
              : null,
    );
  }

  Widget _emptyState() {
    return const EmptyStateView(
      title: 'Your feed is getting ready',
      subtitle:
          'Follow players, clubs and academies to start seeing posts here.',
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
