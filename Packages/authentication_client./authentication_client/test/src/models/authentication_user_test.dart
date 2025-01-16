import 'package:authentication_client/authentication_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthenticationUser', () {
    test('supports value equality', () {
      const userA = AuthenticationUser(
        id: 'A',
        phoneNumber: '9876543210', // Providing the required phoneNumber
      );
      const secondUserA = AuthenticationUser(
        id: 'A',
        phoneNumber: '9876543210', // Providing the required phoneNumber
      );
      const userB = AuthenticationUser(
        id: 'B',
        phoneNumber: '9876543211', // Providing a different phoneNumber
      );

      expect(userA, equals(secondUserA));
      expect(userA, isNot(equals(userB)));
    });

    test('isAnonymous returns true for anonymous user', () {
      expect(AuthenticationUser.anonymous.isAnonymous, isTrue);
    });

    test('returns false for authenticated user', () {
      const authenticatedUser = AuthenticationUser(
        id: 'user123',
        phoneNumber: '9876543210', // Providing the required phoneNumber
      );
      expect(authenticatedUser.isAnonymous, isFalse);
    });
  });
}
