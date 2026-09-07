import 'package:clean_architecture_demo/core/error/failures.dart';
import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:clean_architecture_demo/features/book/domain/usecases/get_book_by_id.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/book_fixtures.dart';

void main() {
  test('delegates to the repository and returns its result', () async {
    final expected = Right<Failure, Book>(sampleBook);
    final repository = FakeBookRepository(
      Right([]),
      bookByIdResult: expected,
    );
    final useCase = GetBookById(repository);

    final result = await useCase(sampleBook.id);

    expect(repository.getBookByIdCallCount, 1);
    expect(repository.lastRequestedId, sampleBook.id);
    expect(result, same(expected));
  });
}
