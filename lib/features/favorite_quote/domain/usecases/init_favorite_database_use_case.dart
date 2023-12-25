import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/usecases/usecase.dart';
import 'package:quotes/features/favorite_quote/domain/repositories/favorite_repository.dart';

class InitFavoriteDatabaseUseCase extends UseCase<void, NoParams> {
  final FavoriteQuoteRepository favoriteQuoteRepository;

  InitFavoriteDatabaseUseCase({required this.favoriteQuoteRepository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    try {
      await favoriteQuoteRepository.initFavoriteDatabase();
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure());
    }
  }
}
