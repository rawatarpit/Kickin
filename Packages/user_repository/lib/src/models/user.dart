// ignore_for_file: unused_import

import 'package:authentication_client/authentication_client.dart';
import 'package:shared/shared.dart';

/// {@template user}
/// User model represents the current user in Kickin.
/// {@endtemplate}
class User extends AuthenticationUser {
  /// {@macro user}
  const User({
    required super.id,
    required super.phoneNumber,
    super.email,
    super.fullName,
    super.avatarUrl,
    super.pushToken,
    super.isNewUser,
  });

  /// Converts an [AuthenticationUser] instance to [User].
  factory User.fromAuthenticationUser({
    required AuthenticationUser authenticationUser,
  }) =>
      User(
        id: authenticationUser.id,
        phoneNumber: authenticationUser.phoneNumber,
        email: authenticationUser.email,
        fullName: authenticationUser.fullName,
        avatarUrl: authenticationUser.avatarUrl,
        pushToken: authenticationUser.pushToken,
        isNewUser: authenticationUser.isNewUser,
      );

  /// Converts a `Map<String, dynamic>` json to a [User] instance.
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['user_id'] as String? ?? json['id'] as String,
        phoneNumber: json['phone_number'] as String,
        email: json['email'] as String?,
        fullName: json['full_name'] as String?,
        avatarUrl: json['avatar_url'] as String?,
        pushToken: json['push_token'] as String?,
        isNewUser: json['is_new_user'] as bool? ?? true,
      );

  /// Whether the current user is anonymous.
  @override
  bool get isAnonymous => this == anonymous;

  /// Anonymous user which represents an unauthenticated user.
  static const User anonymous = User(id: '', phoneNumber: '');

  /// The effective full name display without null-aware operators.
  /// By default, no existing name value is `Unknown`.
  String get displayFullName => fullName ?? 'Unknown';

  /// The effective user name display without null-aware operators.
  /// By default, no existing name value is `Unknown`.
  String get displayUsername => fullName ?? phoneNumber;

  /// Converts the current [User] instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': id,
      'phone_number': phoneNumber,
      if (email != null) 'email': email,
      if (fullName != null) 'full_name': fullName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (pushToken != null) 'push_token': pushToken,
      'is_new_user': isNewUser,
    };
  }
}
