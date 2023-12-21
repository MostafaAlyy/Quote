import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/end_points.dart';
import 'package:quotes/features/search/data/models/search_quote_response_model.dart';

abstract class SearchRemoteDataSource {
  Future<SearchQuotesResponseModel> searchQuote(String query);
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final ApiConsumer apiConsumer;

  SearchRemoteDataSourceImpl({required this.apiConsumer});
  @override
  Future<SearchQuotesResponseModel> searchQuote(String query) async {
    final response =
        await apiConsumer.get(EndPoints.searchQuotes, queryParameters: {
      'query': query,
    });
    return SearchQuotesResponseModel.fromJson(response);
  }
}
