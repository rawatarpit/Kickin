// ignore_for_file: public_member_api_docs, implementation_imports, lines_longer_than_80_chars, unnecessary_null_comparison, inference_failure_on_untyped_parameter, avoid_dynamic_calls, unnecessary_await_in_return

import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:env/env.dart';
import 'package:flutter/foundation.dart';
import 'package:powersync_repository/powersync_repository.dart';
import 'package:shared/shared.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_repository/src/models/user.dart';
import 'package:user_repository/user_repository.dart';

class DatabaseClient {
  DatabaseClient({required this.supabase});
  final SupabaseClient supabase;

  /// UserBaseRepository implementation
  String? get currentUserId {
    final user = supabase.auth.currentUser;
    return user?.id;
  }

  Stream<User> profile({required String id}) {
    return supabase
        .from('users')
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map((rows) => User.fromMap(rows.first));
  }

  Future<void> updateUser({
    String? fullName,
    String? email,
    String? avatarUrl,
    String? pushToken,
  }) async {
    final userId = currentUserId;
    if (userId == null) return;

    final updates = <String, dynamic>{};
    if (fullName != null) updates['full_name'] = fullName;
    if (email != null) updates['email'] = email;
    if (avatarUrl != null) updates['avatar_url'] = avatarUrl;
    if (pushToken != null) updates['push_token'] = pushToken;

    await supabase.from('users').update(updates).eq('id', userId);
  }

  Future<void> follow({
    required String followToId,
    String? followerId,
  }) async {
    final currentUserId = followerId ?? this.currentUserId;
    if (currentUserId == null) return;

    await supabase.from('connections').upsert({
      'follower_id': currentUserId,
      'followee_id': followToId,
    });
  }

  Future<void> unfollow(
      {required String unfollowId, String? unfollowerId}) async {
    final currentUserId = unfollowerId ?? this.currentUserId;
    if (currentUserId == null) return;

    await supabase
        .from('connections')
        .delete()
        .eq('follower_id', currentUserId)
        .eq('follower_id', unfollowId);
  }

  Future<void> removeFollower({required String id}) async {
    final currentUserId = this.currentUserId;
    if (currentUserId == null) return;

    await supabase
        .from('connections')
        .delete()
        .eq('follower_id', id)
        .eq('followee_id', currentUserId);
  }

  Future<bool> isFollowed({
    required String userId,
    String? followerId,
  }) async {
    final currentUserId = followerId ?? this.currentUserId;
    if (currentUserId == null) return false;

    final response = await supabase
        .from('connections')
        .select()
        .eq('follower_id', currentUserId)
        .eq('followee_id', userId)
        .single();

    return response != null;
  }

  Stream<bool> followingStatus({
    required String userId,
    String? followerId,
  }) {
    final currentUserId = followerId ?? this.currentUserId;
    if (currentUserId == null) {
      return Stream.value(false);
    }

    return supabase
        .from('connections')
        .stream(primaryKey: ['follower_id', 'followee_id'])
        .eq('follower_id', currentUserId)
        .eq('followee_id', userId)
        .map((rows) => rows.isNotEmpty);
  }

  Stream<int> followersCountOf({required String userId}) {
    return supabase
        .from('connections')
        .stream()
        .eq('followee_id', userId)
        .count();
  }

  Stream<int> followingsCountOf({required String userId}) {
    return supabase
        .from('connections')
        .stream()
        .eq('follower_id', userId)
        .count();
  }

  Future<List<User>> getFollowers({String? userId}) async {
    final id = userId ?? currentUserId;
    if (id == null) return [];

    final response = await supabase
        .from('connections')
        .select('follower_id')
        .eq('followee_id', id);

    final userIds = response.map((e) => e['follower_id'] as String).toList();
    return await getUsersByIds(userIds);
  }

  Future<List<User>> getFollowings({String? userId}) async {
    final id = userId ?? currentUserId;
    if (id == null) return [];

    final response = await supabase
        .from('connections')
        .select('followee_id')
        .eq('follower_id', id);

    final userIds = response.map((e) => e['followee_id'] as String).toList();
    return await getUsersByIds(userIds);
  }

  Future<List<User>> getUsersByIds(List<String> userIds) async {
    final response = await supabase.from('users').select().in_('id', userIds);

    return response.map(User.fromMap).toList();
  }

  Stream<List<User>> followers({required String userId}) {
    return supabase
        .from('connections')
        .stream()
        .eq('followee_id', userId)
        .map((rows) => rows.map(User.fromMap).toList());
  }

  Future<List<User>> searchUsers({
    required int limit,
    required int offset,
    required String? query,
    String? userId,
    String? excludeUserIds,
  }) async {
    final response = await supabase
        .from('users')
        .select()
        .ilike('full_name', '%$query%')
        .range(offset, offset + limit - 1)
        .not('id', 'in', '($excludeUserIds)');

    return response.map(User.fromMap).toList();
  }

  /// PostsBaseRepository implementation
  Future<Post?> getPostBy({required String id}) async {
    final response =
        await supabase.from('posts').select().eq('id', id).single();

    return response != null ? Post.fromMap(response) : null;
  }

  Future<List<User>> getPostLikers({
    required String postId,
    int limit = 30,
    int offset = 0,
  }) async {
    final response = await supabase
        .from('likes')
        .select('user_id')
        .eq('post_id', postId)
        .range(offset, offset + limit - 1);

    final userIds = response.map((e) => e['user_id'] as String).toList();
    return await getUsersByIds(userIds);
  }

  Future<List<User>> getPostLikersInFollowings({
    required String postId,
    int limit = 3,
    int offset = 0,
  }) async {
    final currentUserId = this.currentUserId;
    if (currentUserId == null) return [];

    final response = await supabase
        .from('likes')
        .select('user_id')
        .eq('post_id', postId)
        .range(offset, offset + limit - 1);

    final userIds = response.map((e) => e['user_id'] as String).toList();
    final followings = await getFollowings(userId: currentUserId);

    return followings.where((user) => userIds.contains(user.id)).toList();
  }

  Future<void> like({
    required String id,
    bool post = true,
  }) async {
    final table = post ? 'posts' : 'comments';
    await supabase.from('likes').upsert({
      'post_id': id,
      'user_id': currentUserId,
    });
  }

  Stream<int> likesOf({
    required String id,
    bool post = true,
  }) {
    final table = post ? 'posts' : 'comments';
    return supabase
        .from('likes')
        .stream()
        .eq('post_id', id)
        .map((rows) => rows.length);
  }

  Stream<bool> isLiked({
    required String id,
    String? userId,
    bool post = true,
  }) {
    final currentUserId = userId ?? this.currentUserId;
    if (currentUserId == null) {
      return Stream.value(false);
    }

    return supabase
        .from('likes')
        .stream()
        .eq('post_id', id)
        .eq('user_id', currentUserId)
        .map((rows) => rows.isNotEmpty);
  }

  Future<List<Post>> getPage({
    required int offset,
    required int limit,
    bool onlyReels = false,
  }) async {
    final response = await supabase
        .from('posts')
        .select()
        .range(offset, offset + limit - 1)
        .eq('is_reel', onlyReels);

    return response.map(Post.fromMap).toList();
  }

  Future<Post?> createPost({
    required String id,
    required String caption,
    required String media,
  }) async {
    final response = await supabase.from('posts').insert({
      'id': id,
      'caption': caption,
      'media': media,
    }).single();

    return Post.fromMap(response);
  }
}
