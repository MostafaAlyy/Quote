import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/usecases/usecase.dart';
import 'package:quotes/features/favorite_quote/domain/repositories/favorite_repository.dart';
import 'package:quotes/features/random_quotes/domain/entities/quote.dart';

class GetFavoriteQuotesUseCase extends UseCase<Set<Quote>, NoParams> {
  final FavoriteQuoteRepository favoriteQuoteRepository;

  GetFavoriteQuotesUseCase({required this.favoriteQuoteRepository});

  @override
  Future<Either<Failure, Set<Quote>>> call(NoParams params) async =>
      await favoriteQuoteRepository.getFavoriteQuotes();
}
