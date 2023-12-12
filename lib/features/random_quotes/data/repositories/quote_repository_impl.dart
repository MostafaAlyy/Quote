import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/exceptions.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/features/random_quotes/data/datasources/random_quote_local_data.dart';
import 'package:quotes/features/random_quotes/data/datasources/random_quote_remote_data.dart';
import 'package:quotes/features/random_quotes/data/models/quote_model.dart';
import 'package:quotes/features/random_quotes/domain/entities/quote.dart';
import 'package:quotes/features/random_quotes/domain/repositories/quote_repository.dart';

class QuoteRepositoryImpl extends QuoteRepository {
  final NetworkInfo networkInfo;
  final RandomQuoteRemoteDataSource randomQuoteRemoteDataSource;
  final RandomQuoteLocalDataSource randomQuoteLocalDataSource;

  QuoteRepositoryImpl({
    required this.networkInfo,
    required this.randomQuoteLocalDataSource,
    required this.randomQuoteRemoteDataSource,
  });
  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
    if (await networkInfo.isConnected) {
      try {
        final QuoteModel randomRemoteQuote =
            await randomQuoteRemoteDataSource.getRandomQuote();
        randomQuoteLocalDataSource.cachQuote(randomRemoteQuote);
        return Right(randomRemoteQuote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final QuoteModel randomLocalQuote =
            await randomQuoteLocalDataSource.getLastRandomQuote();
        return Right(randomLocalQuote);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
