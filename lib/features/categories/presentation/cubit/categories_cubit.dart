import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/usecases/usecase.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/categories/domain/entities/quote_category.dart';
import 'package:quotes/features/categories/domain/usecases/get_quote_by_category.dart';
import 'package:quotes/features/categories/domain/usecases/get_quote_categories_usecase.dart';
import 'package:quotes/features/random_quotes/domain/entities/quote.dart';
import 'package:quotes/core/widgets/quote_card.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(
      {required this.getQuoteCategoriesUseCase,
      required this.getQuoteByCategoryUseCase})
      : super(CategoriesInitial());
  static CategoriesCubit get(BuildContext context) => BlocProvider.of(context);

  final GetQuoteCategoriesUseCase getQuoteCategoriesUseCase;
  final GetQuoteByCategoryUseCase getQuoteByCategoryUseCase;

  List<QuoteCategory> categoriesList = [];

  Future<void> initCategoriesList() async {
    if (categoriesList.isEmpty) {
      emit(GetCategoriesListLoading());
      final response = await getQuoteCategoriesUseCase(NoParams());
      response.fold(
          (failure) =>
              emit(GetCategoriesListError(msg: mapFailureToMsg(failure))),
          (categories) {
        categoriesList.addAll(categories);
        emit(CategoriesListLoaded());
      });
    }
  }

  List<Widget> quotesByCategoryList = [];
  Future<void> initQuotesByCategoryList(String category) async {
    emit(CategoryQuotesListLoading());
    for (var i = 0; i < 3; i++) {
      Either<Failure, Quote> response =
          await getQuoteByCategoryUseCase(category);
      response.fold(
          (failure) =>
              emit(CategoryQuotesListError(msg: mapFailureToMsg(failure))),
          (quote) => quotesByCategoryList.add(QuoteCard(
                quote: quote,
              )));
    }
    emit(CategoryQuotesListLoaded());
  }

  Future<void> getCategoryQuote(String category) async {
    emit(CategoryQuotesLoading());
    Either<Failure, Quote> response = await getQuoteByCategoryUseCase(category);
    emit(response.fold(
        (failure) => CategoryQuotesError(msg: mapFailureToMsg(failure)),
        (quote) => CategoryQuotesLoaded(quote: quote)));
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
