import 'package:clean_architecture_demo/core/error/failures.dart';
import 'package:clean_architecture_demo/core/usecase/usecase.dart';
import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:clean_architecture_demo/features/book/domain/repositories/book_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBookById implements UseCase<Book, int> {
  new(this.repository);

  final BookRepository repository;

  @override
  Future<Either<Failure, Book>> call(int params) =>
      repository.getBookById(params);
}
