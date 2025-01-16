// ignore_for_file: lines_longer_than_80_chars

import 'package:authentication_client/authentication_client.dart';
import 'package:flutter_test/flutter_test.dart';

// Mock AuthenticationClient for testing
class FakeAuthenticationClient extends Fake implements AuthenticationClient {}

void main() {
  // Testing OTP-specific authentication

  // Test OTP Verification failure
  test('exports OTPVerificationFailure', () {
    expect(
      () => const OTPVerificationFailure('OTP verification failed'),
      returnsNormally,
    );
  });

  // Test Phone Number not registered exception
  test('exports PhoneNumberNotRegistered', () {
    expect(
      () => const PhoneNumberNotRegistered('Phone number is not registered'),
      returnsNormally,
    );
  });

  // Test Push Token generation error
  test('exports PushTokenError', () {
    expect(
      () => const PushTokenError('Error generating push token'),
      returnsNormally,
    );
  });

  // Test OTP Login
  test('OTP Login process success', () async {
    // Simulate OTP sent and verified
    final otpLoginResult = await FakeAuthenticationClient()
        .otpLogin('1234567890', '123456'); // Phone number and OTP
    expect(otpLoginResult, isA<AuthenticationUser>());
    expect(otpLoginResult.phoneNumber, '1234567890');
  });

  // Test OTP Signup process
  test('OTP Signup process success', () async {
    // Simulate user signup with phone number
    final otpSignupResult = await FakeAuthenticationClient()
        .otpSignup('1234567890', '123456', fullName: 'John Doe');
    expect(otpSignupResult, isA<AuthenticationUser>());
    expect(otpSignupResult.phoneNumber, '1234567890');
    expect(otpSignupResult.fullName, 'John Doe');
  });
}
