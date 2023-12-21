import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/search/domain/entities/search_quote_response.dart';
import 'package:quotes/features/search/domain/usecases/search_quote_use_case.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchQuoteUseCase}) : super(SearchInitial());
  static SearchCubit get(BuildContext context) => BlocProvider.of(context);
  final TextEditingController searchController = TextEditingController();
  final SearchQuoteUseCase searchQuoteUseCase;
  void searchQuote() async {
    emit(SearchLoading());
    final searchQuoteResponse = await searchQuoteUseCase(searchController.text);
    searchQuoteResponse.fold(
      (failure) => emit(SearchError(message: mapFailureToMsg(failure))),
      (searchQuoteResponse) => emit(SearchLoaded(searchQuoteResponse)),
    );
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
