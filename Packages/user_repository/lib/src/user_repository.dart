// ignore_for_file: comment_references, unnecessary_lambdas

import 'package:authentication_client/authentication_client.dart';
import 'package:database_client/database_client.dart';
import 'package:user_repository/user_repository.dart';

/// {@template user_repository}
/// A package that manages user flow.
/// {@endtemplate}
class UserRepository implements UserBaseRepository {
  /// {@macro user_repository}
  const UserRepository({
    required DatabaseClient databaseClient,
    required AuthenticationClient authenticationClient,
  })  : _databaseClient = databaseClient,
        _authenticationClient = authenticationClient;

  final DatabaseClient _databaseClient;
  final AuthenticationClient _authenticationClient;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  Stream<User> get user => _authenticationClient.user
      .map((user) => User.fromAuthenticationUser(authenticationUser: user))
      .asBroadcastStream();

  /// Starts the OTP-based login/signup Flow.
  ///
  /// Throws a [LogInWithOtpFailure] if the OTP-based login/signup fails.
  Future<void> logInOrSignUpWithOtp({
    required String phoneNumber,
    required String email,
    required String otp,
  }) async {}

  /// Logs out the current user, which will emit [User.anonymous] from the
  /// [user] Stream.
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await _authenticationClient.logOut();
    } on LogOutFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }

  @override
  String? get currentUserId => _databaseClient.currentUserId;

  /// Returns a stream of user profile data identified by [id].
  @override
  Stream<User> profile({required String id}) {
    return _databaseClient.profile(id: id).map((dynamic data) {
      // Ensure that the data is properly cast to the User type
      return User.fromDatabaseData(data);
    }).asBroadcastStream();
  }

  @override
  Stream<int> followersCountOf({required String userId}) =>
      _databaseClient.followersCountOf(userId: userId);

  @override
  Stream<int> followingsCountOf({required String userId}) =>
      _databaseClient.followingsCountOf(userId: userId);

  @override
  Future<List<User>> getFollowers({String? userId}) =>
      _databaseClient.getFollowers(userId: userId);

  @override
  Future<List<User>> getFollowings({String? userId}) =>
      _databaseClient.getFollowings(userId: userId);

  @override
  Future<void> follow({
    required String followToId,
    String? followerId,
  }) =>
      _databaseClient.follow(
        followToId: followToId,
        followerId: followerId,
      );

  @override
  Future<void> removeFollower({required String id}) =>
      _databaseClient.removeFollower(id: id);

  @override
  Future<void> unfollow({required String unfollowId, String? unfollowerId}) =>
      _databaseClient.unfollow(
        unfollowId: unfollowId,
        unfollowerId: unfollowerId,
      );

  @override
  Future<bool> isFollowed({
    required String userId,
    String? followerId,
  }) =>
      _databaseClient.isFollowed(followerId: followerId, userId: userId);

  @override
  Stream<bool> followingStatus({
    required String userId,
    String? followerId,
  }) =>
      _databaseClient.followingStatus(followerId: followerId, userId: userId);

  @override
  Future<void> updateUser({
    String? fullName,
    String? email,
    String? avatarUrl,
    String? pushToken,
  }) =>
      _databaseClient.updateUser(
        fullName: fullName,
        email: email,
        avatarUrl: avatarUrl,
        pushToken: pushToken,
      );

  @override
  Future<List<User>> searchUsers({
    required int limit,
    required int offset,
    required String? query,
    String? userId,
    String? excludeUserIds,
  }) =>
      _databaseClient.searchUsers(
        userId: userId,
        limit: limit,
        offset: offset,
        query: query,
        excludeUserIds: excludeUserIds,
      );

  @override
  Stream<List<User>> followers({required String userId}) =>
      _databaseClient.followers(userId: userId);
}
