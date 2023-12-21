import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/exceptions.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/features/search/data/datasources/search_remote_data_source.dart';
import 'package:quotes/features/search/domain/entities/search_quote_response.dart';
import 'package:quotes/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource searchRemoteDataSource;

  SearchRepositoryImpl({
    required this.searchRemoteDataSource,
  });

  @override
  Future<Either<Failure, SearchQuotesResponse>> searchQuote(
      String query) async {
    try {
      final SearchQuotesResponse searchRemoteQuote =
          await searchRemoteDataSource.searchQuote(query);
      return Right(searchRemoteQuote);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
