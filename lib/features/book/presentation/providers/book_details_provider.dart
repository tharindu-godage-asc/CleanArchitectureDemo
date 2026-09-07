import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:clean_architecture_demo/features/book/domain/usecases/get_book_by_id.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'book_list_provider.dart';

part 'book_details_provider.g.dart';

@riverpod
GetBookById getBookByIdUseCase(Ref ref) =>
    GetBookById(ref.read(bookRepositoryProvider));

@riverpod
class BookDetails extends _$BookDetails {
  @override
  Future<Book> build(int id) async {
    final useCase = ref.read(getBookByIdUseCaseProvider);
    final result = await useCase(id);

    return result.match(
      (failure) => throw Exception(failure),
      (book) => book,
    );
  }
}
