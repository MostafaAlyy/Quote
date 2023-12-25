import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/features/random_quotes/domain/entities/quote.dart';

abstract class FavoriteQuoteRepository {
  Future<void> initFavoriteDatabase();
  Future<void> addQuoteToFavorites(Quote quote);
  Future<void> removeQuoteFromFavorites(Quote quote);
  Future<Either<Failure, List<Quote>>> getFavoriteQuotes();
}
