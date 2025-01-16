// ignore_for_file: prefer_const_constructors
import 'package:firebase_notifications_client/firebase_notifications_client.dart';
import 'package:test/test.dart';

void main() {
  group('FirebaseNotificationsClient', () {
    test('can be instantiated', () {
      expect(FirebaseNotificationsClient(), isNotNull);
    });
  });
}
