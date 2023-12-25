import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/exceptions.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/features/favorite_quote/data/datasources/favoritr_local_data_source.dart';
import 'package:quotes/features/favorite_quote/domain/repositories/favorite_repository.dart';
import 'package:quotes/features/random_quotes/domain/entities/quote.dart';

class FavoriteQuoteRepositoryImpl implements FavoriteQuoteRepository {
  final FavoriteQuoteLocalDataSource localDataSource;

  FavoriteQuoteRepositoryImpl({required this.localDataSource});

  @override
  Future<void> initFavoriteDatabase() async {
    await localDataSource.initDatabase();
  }

  @override
  Future<void> addQuoteToFavorites(Quote quote) async {
    await localDataSource.addQuote(quote);
  }

  @override
  Future<void> removeQuoteFromFavorites(Quote quote) async {
    await localDataSource.deleteQuote(quote);
  }

  @override
  Future<Either<Failure, List<Quote>>> getFavoriteQuotes() async {
    try {
      final quotes = await localDataSource.getFavoriteQuotes();
      return Right(quotes);
    } on LocalDatabaseException {
      return Left(LocalDatabaseFailure());
    }
  }
}
