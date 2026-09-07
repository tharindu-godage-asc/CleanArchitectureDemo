import 'package:clean_architecture_demo/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Failure', () {
    test('stores no status code by default', () {
      final failure = CacheFailure();

      expect(failure.statusCode, isNull);
    });
  });

  group('CacheFailure', () {
    test('is a Failure', () {
      expect(CacheFailure(), isA<Failure>());
    });
  });

  group('NotFoundFailure', () {
    test('is a Failure', () {
      expect(NotFoundFailure(), isA<Failure>());
    });
  });
}
