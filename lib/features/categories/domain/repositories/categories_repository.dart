import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/features/categories/domain/entities/quote_category.dart';
import 'package:quotes/features/random_quotes/data/models/quote_model.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<QuoteCategory>>> getCategories();
  Future<Either<Failure, QuoteModel>> getCategoryQuote(String category);
}
