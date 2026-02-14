import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../notification_model.dart';
import '../../../core/supabase/notification_action_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  final _client = Supabase.instance.client;
  late TabController _tabController;

  final Map<String, bool> _loadingMap = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Stream<List<Map<String, dynamic>>> _stream() {
    final userId = _client.auth.currentUser!.id;

    return _client
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('receiver_id', userId)
        .order('created_at', ascending: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Requests'),
            Tab(text: 'Tournaments'),
            Tab(text: 'Updates'),
          ],
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _stream(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final notifications =
              snapshot.data!.map((e) => AppNotification.fromMap(e)).toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _buildList(notifications),
              _buildList(notifications.where((n) => n.isRequest).toList()),
              _buildList(notifications.where((n) => n.isTournament).toList()),
              _buildList(
                notifications
                    .where((n) => !n.isRequest && !n.isTournament)
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildList(List<AppNotification> list) {
    if (list.isEmpty) {
      return const Center(child: Text('No notifications'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: list.length,
      itemBuilder: (_, i) => _buildCard(list[i]),
    );
  }

  Widget _buildCard(AppNotification n) {
    final isLoading = _loadingMap[n.id] ?? false;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: n.isRead ? Colors.white : Colors.grey.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            n.message,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            _timeAgo(n.createdAt),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          if (n.isRequest) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading ? null : () => _handleAccept(n),
                    child:
                        isLoading
                            ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                            : const Text('Accept'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: isLoading ? null : () => _handleReject(n),
                    child: const Text('Reject'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _handleAccept(AppNotification n) async {
    setState(() => _loadingMap[n.id] = true);

    await NotificationActionService.acceptInvite(notificationId: n.id);

    setState(() => _loadingMap[n.id] = false);
  }

  Future<void> _handleReject(AppNotification n) async {
    setState(() => _loadingMap[n.id] = true);

    await NotificationActionService.rejectInvite(notificationId: n.id);

    setState(() => _loadingMap[n.id] = false);
  }

  String _timeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
