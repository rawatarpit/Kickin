// ignore_for_file: prefer_const_constructors
import 'package:persistent_storage/persistent_storage.dart';
import 'package:test/test.dart';

void main() {
  group('PersistentStorage', () {
    test('can be instantiated', () {
      expect(PersistentStorage(), isNotNull);
    });
  });
}
