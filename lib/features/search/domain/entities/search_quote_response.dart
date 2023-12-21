import 'package:equatable/equatable.dart';
import 'package:quotes/features/random_quotes/data/models/quote_model.dart';

class SearchQuotesResponse extends Equatable {
  final int count;
  final int totalCount;
  final int page;
  final int totalPages;
  final List<QuoteModel> results;

  const SearchQuotesResponse({
    required this.count,
    required this.totalCount,
    required this.page,
    required this.totalPages,
    required this.results,
  });

  @override
  List<Object?> get props => [results];
}
