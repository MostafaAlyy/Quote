import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/usecases/usecase.dart';
import 'package:quotes/features/favorite_quote/domain/repositories/favorite_repository.dart';
import 'package:quotes/features/random_quotes/domain/entities/quote.dart';

class AddQuoteToFavoriteUseCase extends UseCase<void, Quote> {
  final FavoriteQuoteRepository favoriteQuoteRepository;

  AddQuoteToFavoriteUseCase({required this.favoriteQuoteRepository});

  @override
  Future<Either<Failure, void>> call(Quote quote) async {
    try {
      await favoriteQuoteRepository.addQuoteToFavorites(quote);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure());
    }
  }
}
