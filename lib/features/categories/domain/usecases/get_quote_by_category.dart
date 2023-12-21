import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/usecases/usecase.dart';
import 'package:quotes/features/categories/domain/repositories/categories_repository.dart';
import 'package:quotes/features/random_quotes/data/models/quote_model.dart';

class GetQuoteByCategoryUseCase implements UseCase<QuoteModel, String> {
  final CategoryRepository categoryRepository;

  GetQuoteByCategoryUseCase({required this.categoryRepository});

  @override
  Future<Either<Failure, QuoteModel>> call(String category) async {
    return await categoryRepository.getCategoryQuote(category);
  }
}
