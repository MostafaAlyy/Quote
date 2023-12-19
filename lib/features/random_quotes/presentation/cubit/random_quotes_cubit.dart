import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/usecases/usecase.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/random_quotes/domain/entities/quote.dart';
import 'package:quotes/features/random_quotes/domain/usecases/get_random_quote.dart';
import 'package:quotes/features/random_quotes/presentation/widgets/quote_card.dart';

part 'random_quotes_state.dart';

class RandomQuotesCubit extends Cubit<RandomQuotesState> {
  RandomQuotesCubit({required this.getRandomQuoteUseCase})
      : super(RandomQuotesInitial());
  static RandomQuotesCubit get(BuildContext context) =>
      BlocProvider.of(context);

  final GetRandomQuote getRandomQuoteUseCase;

  List<Widget> quotesList = [];
  Future<void> initRandomQuotesList() async {
    emit(RandomQuotesListLoading());
    for (var i = 0; i < 3; i++) {
      Either<Failure, Quote> response = await getRandomQuoteUseCase(NoParams());
      response.fold(
          (failure) =>
              emit(RandomQuotesListError(msg: mapFailureToMsg(failure))),
          (quote) => quotesList
              .add(QuoteCard(msg: quote.content, author: quote.author)));
    }
    emit(RandomQuotesListLoaded());
  }

  Future<void> getRandomQuote() async {
    emit(RandomQuotesLoading());
    Either<Failure, Quote> response = await getRandomQuoteUseCase(NoParams());
    emit(response.fold(
        (failure) => RandomQuotesError(msg: mapFailureToMsg(failure)),
        (quote) => RandomQuotesLoaded(quote: quote)));
  }

  String mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return AppStrings.serverFailureMsg;
      case CacheFailure _:
        return AppStrings.cacheFailureMsg;
      default:
        return AppStrings.unexpectedFailureMsg;
    }
  }
}
