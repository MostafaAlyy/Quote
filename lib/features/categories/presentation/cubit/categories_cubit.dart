import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/usecases/usecase.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/categories/domain/entities/quote_category.dart';
import 'package:quotes/features/categories/domain/usecases/get_quote_categories_usecase.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({required this.getQuoteCategoriesUseCase})
      : super(CategoriesInitial());
  static CategoriesCubit get(BuildContext context) => BlocProvider.of(context);

  final GetQuoteCategoriesUseCase getQuoteCategoriesUseCase;

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
