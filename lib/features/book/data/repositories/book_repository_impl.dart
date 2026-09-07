import 'package:clean_architecture_demo/core/error/failures.dart';
import 'package:clean_architecture_demo/features/book/domain/entities/book.dart';
import 'package:clean_architecture_demo/features/book/domain/repositories/book_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../datasources/book_local_datasource.dart';

class BookRepositoryImpl implements BookRepository {
  new(this.localDataSource);

  final BookLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<Book>>> getBooks() async {
    try {
      final models = await localDataSource.getBooks();
      return Right(models); // BookModel is-a Book
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Book>> getBookById(int id) async {
    try {
      final models = await localDataSource.getBooks();
      final match = models.firstWhere((book) => book.id == id);
      return Right(match);
    } on StateError {
      return Left(NotFoundFailure());
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
