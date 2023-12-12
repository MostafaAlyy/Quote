import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/features/random_quotes/domain/entities/quote.dart';

abstract class QuoteRepository {
  Future<Either<Failure, Quote>> getRandomQuote();
}
