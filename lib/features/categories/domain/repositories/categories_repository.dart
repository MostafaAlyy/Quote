import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/features/categories/domain/entities/quote_category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<QuoteCategory>>> getCategories();
}
