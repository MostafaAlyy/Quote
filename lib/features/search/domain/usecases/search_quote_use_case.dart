import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/usecases/usecase.dart';
import 'package:quotes/features/search/domain/entities/search_quote_response.dart';
import 'package:quotes/features/search/domain/repositories/search_repository.dart';

class SearchQuoteUseCase extends UseCase<SearchQuotesResponse, String> {
  final SearchRepository searchRepository;

  SearchQuoteUseCase({required this.searchRepository});
  @override
  Future<Either<Failure, SearchQuotesResponse>> call(String query) =>
      searchRepository.searchQuote(query);
}
