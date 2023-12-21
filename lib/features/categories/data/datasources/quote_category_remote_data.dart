import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/end_points.dart';
import 'package:quotes/features/categories/data/models/quote_category_model.dart';
import 'package:quotes/features/categories/domain/entities/quote_category.dart';
import 'package:quotes/features/random_quotes/data/models/quote_model.dart';

abstract class QuoteCategoryRemoteDataSource {
  Future<List<QuoteCategory>> getCategories();
  Future<QuoteModel> getCategoryQuote(String category);
}

class QuoteCategoryRemoteDataSourceImpl
    implements QuoteCategoryRemoteDataSource {
  QuoteCategoryRemoteDataSourceImpl({required this.apiConsumer});
  ApiConsumer apiConsumer;
  @override
  Future<List<QuoteCategory>> getCategories() async {
    final response = await apiConsumer.get(EndPoints.quoteCategories);
    final List<QuoteCategory> categories = [];
    for (final category in response) {
      categories.add(QuoteCategoryModel.fromJson(category));
    }
    return categories;
  }

  @override
  Future<QuoteModel> getCategoryQuote(String category) async {
    final response = await apiConsumer.get(
      EndPoints.randomQuote,
      queryParameters: {'tags': category},
    );
    return QuoteModel.fromJson(response);
  }
}
