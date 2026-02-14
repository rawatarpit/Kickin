import 'package:flutter/material.dart';

import '../../../core/services/feed_pagination_service.dart';
import '../../../core/models/feed_item_ui_model.dart';
import '../../../core/widgets/feed/feed_card.dart';

class ProfilePostsTab extends StatefulWidget {
  final String userId;

  const ProfilePostsTab({required this.userId, super.key});

  @override
  State<ProfilePostsTab> createState() => _ProfilePostsTabState();
}

class _ProfilePostsTabState extends State<ProfilePostsTab> {
  final _pagination = FeedPaginationService();
  List<FeedItemUIModel> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final items = await _pagination.loadNext();
    if (!mounted) return;

    setState(() {
      _items = items.where((e) => e.identity.id == widget.userId).toList();
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_items.isEmpty) {
      return const Text('No posts yet');
    }

    return Column(children: _items.map((e) => FeedCard(item: e)).toList());
  }
}
