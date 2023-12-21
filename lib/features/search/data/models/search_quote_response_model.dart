import 'package:quotes/features/random_quotes/data/models/quote_model.dart';
import 'package:quotes/features/search/domain/entities/search_quote_response.dart';

class SearchQuotesResponseModel extends SearchQuotesResponse {
  const SearchQuotesResponseModel({
    required super.count,
    required super.totalCount,
    required super.page,
    required super.totalPages,
    required super.results,
  });
  factory SearchQuotesResponseModel.fromJson(Map<String, dynamic> json) =>
      SearchQuotesResponseModel(
        count: json["count"],
        totalCount: json["totalCount"],
        page: json["page"],
        totalPages: json["totalPages"],
        results: List<QuoteModel>.from(
            json["results"].map((x) => QuoteModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "totalCount": totalCount,
        "page": page,
        "totalPages": totalPages,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
