import 'package:clean_architecture_demo/core/error/failures.dart';
import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:clean_architecture_demo/features/book/presentation/providers/book_details_provider.dart';
import 'package:clean_architecture_demo/features/book/presentation/providers/book_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../helpers/book_fixtures.dart';

void main() {
  group('bookDetailsProvider', () {
    test('exposes the book returned by the use case', () async {
      final repository = FakeBookRepository(
        Right([]),
        bookByIdResult: Right<Failure, Book>(sampleBook),
      );
      final container = ProviderContainer(
        overrides: [bookRepositoryProvider.overrideWithValue(repository)],
      );
      final subscription = container.listen(
        bookDetailsProvider(sampleBook.id),
        (_, _) {},
      );
      addTearDown(subscription.close);
      addTearDown(container.dispose);

      final book = await container.read(
        bookDetailsProvider(sampleBook.id).future,
      );

      expect(book, sampleBook);
      expect(repository.lastRequestedId, sampleBook.id);
    });

    test('surfaces a failure from the use case as an error', () async {
      final repository = FakeBookRepository(
        Right([]),
        bookByIdResult: Left(NotFoundFailure()),
      );
      final container = ProviderContainer(
        overrides: [bookRepositoryProvider.overrideWithValue(repository)],
      );
      final subscription = container.listen(
        bookDetailsProvider(missingBookId),
        (_, _) {},
      );
      addTearDown(subscription.close);
      addTearDown(container.dispose);

      await Future<void>.delayed(Duration.zero);

      final state = container.read(bookDetailsProvider(missingBookId));
      expect(state.hasError, isTrue);
      expect(state.error, isA<Exception>());
    });
  });
}
