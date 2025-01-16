import 'dart:async';
import 'package:authentication_client/src/models/models.dart';

/// {@template authentication_exception}
/// Exceptions from the authentication client for Kickin.
/// {@endtemplate}
abstract class AuthenticationException implements Exception {
  /// {@macro authentication_exception}
  const AuthenticationException(this.error);

  /// The error which was caught.
  final Object error;

  @override
  String toString() => 'Authentication exception error: $error';
}

/// {@template send_otp_failure}
/// Thrown during the sending OTP process if a failure occurs.
/// {@endtemplate}
class SendOtpFailure extends AuthenticationException {
  /// {@macro send_otp_failure}
  const SendOtpFailure(super.error);
}

/// {@template verify_otp_failure}
/// Thrown during the OTP verification process if a failure occurs.
/// {@endtemplate}
class VerifyOtpFailure extends AuthenticationException {
  /// {@macro verify_otp_failure}
  const VerifyOtpFailure(super.error);
}

/// {@template log_out_failure}
/// Thrown during the logout process if a failure occurs.
/// {@endtemplate}
class LogOutFailure extends AuthenticationException {
  /// {@macro log_out_failure}
  const LogOutFailure(super.error);
}

/// Kickin Authentication Client Interface
abstract class AuthenticationClient {
  /// Stream of [AuthenticationUser] which emits the current user when
  /// the authentication state changes.
  ///
  /// Emits [AuthenticationUser.anonymous] if the user is not authenticated.
  Stream<AuthenticationUser> get user;

  /// Sends an OTP to the provided [phoneNumber].
  ///
  /// Throws a [SendOtpFailure] if an exception occurs.
  Future<void> sendOtp({
    required String phoneNumber,
  });

  /// Verifies the provided [otp] for the [phoneNumber].
  ///
  /// Throws a [VerifyOtpFailure] if an exception occurs.
  Future<void> verifyOtp({
    required String phoneNumber,
    required String otp,
  });

  /// Signs out the current user and emits [AuthenticationUser.anonymous]
  /// from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut();
}
