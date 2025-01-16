// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

/// {@template authentication_user}
/// User model for Kickin.
///
/// [AuthenticationUser.anonymous] represents an unauthenticated user.
/// {@endtemplate}
class AuthenticationUser extends Equatable {
  /// {@macro authentication_user}
  const AuthenticationUser({
    required this.id,
    required this.phoneNumber,
    this.email,
    this.fullName,
    this.avatarUrl,
    this.pushToken,
    this.isNewUser = true,
  });

  /// The current user's unique ID.
  final String id;

  /// The current user's phone number (required for OTP-based login/signup).
  final String phoneNumber;

  /// The current user's email address (optional).
  final String? email;

  /// The current user's full name (optional).
  final String? fullName;

  /// URL for the current user's avatar image (optional).
  final String? avatarUrl;

  /// The FCM notification push token (optional).
  final String? pushToken;

  /// Whether the current user is a first-time user (default: `true`).
  final bool isNewUser;

  /// Whether the current user is anonymous.
  bool get isAnonymous => this == anonymous;

  /// Anonymous user which represents an unauthenticated user.
  static const anonymous = AuthenticationUser(id: '', phoneNumber: '');

  @override
  List<Object?> get props => [
        id,
        phoneNumber,
        email,
        fullName,
        avatarUrl,
        pushToken,
        isNewUser,
      ];
}
