import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/features/search/domain/entities/search_quote_response.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchQuotesResponse>> searchQuote(String query);
}
