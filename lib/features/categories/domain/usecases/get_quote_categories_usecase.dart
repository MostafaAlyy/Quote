import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/usecases/usecase.dart';
import 'package:quotes/features/categories/domain/entities/quote_category.dart';
import 'package:quotes/features/categories/domain/repositories/categories_repository.dart';

class GetQuoteCategoriesUseCase
    implements UseCase<List<QuoteCategory>, NoParams> {
  final CategoryRepository categoryRepository;

  GetQuoteCategoriesUseCase({required this.categoryRepository});

  @override
  Future<Either<Failure, List<QuoteCategory>>> call(NoParams params) async {
    return await categoryRepository.getCategories();
  }
}
