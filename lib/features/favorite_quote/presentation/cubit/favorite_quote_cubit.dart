import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/usecases/usecase.dart';
import 'package:quotes/features/favorite_quote/domain/usecases/add_quote_to_favorite_use_case.dart';
import 'package:quotes/features/favorite_quote/domain/usecases/delete_quote_from_favorite_use_case.dart';
import 'package:quotes/features/favorite_quote/domain/usecases/get_favorite_quotes_use_case.dart';
import 'package:quotes/features/favorite_quote/domain/usecases/init_favorite_database_use_case.dart';
import 'package:quotes/features/random_quotes/domain/entities/quote.dart';

part 'favorite_quote_state.dart';

class FavoriteQuoteCubit extends Cubit<FavoriteQuoteState> {
  FavoriteQuoteCubit(
      {required this.getFavoriteQuotesUseCase,
      required this.addQuoteToFavoriteUseCase,
      required this.deleteQuoteFromFavoriteUseCase,
      required this.initFavoriteDatabaseUseCase})
      : super(FavoriteQuoteInitial());
  static FavoriteQuoteCubit get(BuildContext context) =>
      BlocProvider.of(context);

  final InitFavoriteDatabaseUseCase initFavoriteDatabaseUseCase;
  final GetFavoriteQuotesUseCase getFavoriteQuotesUseCase;
  final AddQuoteToFavoriteUseCase addQuoteToFavoriteUseCase;
  final DeleteQuoteFromFavoriteUseCase deleteQuoteFromFavoriteUseCase;

  List<Quote> quotesList = [];
  Future<void> initFavoriteDatabase() async {
    emit(InitFavoriteDatabaseQuoteLoading());
    try {
      initFavoriteDatabaseUseCase(NoParams());
      emit(InitFavoriteDatabaseQuoteLoaded());
    } catch (e) {
      emit(InitFavoriteDatabaseQuoteError(msg: e.toString()));
    }
  }

  Future<void> getFavoriteQuotes() async {
    emit(GetFavoriteDatabaseQuoteLoading());
    try {
      final result = await getFavoriteQuotesUseCase(NoParams());
      result.fold((l) {
        emit(GetFavoriteDatabaseQuoteError(msg: l.toString()));
      }, (r) {
        quotesList = r;
        emit(GetFavoriteDatabaseQuoteLoaded());
      });
    } catch (e) {
      emit(GetFavoriteDatabaseQuoteError(msg: e.toString()));
    }
  }

  Future<void> addQuoteToFavorite(Quote quote) async {
    try {
      await addQuoteToFavoriteUseCase(quote);
      await getFavoriteQuotes();
      emit(AddQuoteToFavoriteSuccess());
    } catch (e) {
      emit(AddQuoteToFavoriteError(msg: e.toString()));
    }
  }

  Future<void> deleteQuoteFromFavorite(Quote quote) async {
    try {
      await deleteQuoteFromFavoriteUseCase(quote);
      await getFavoriteQuotes();
      emit(DeleteQuoteToFavoriteSuccess());
    } catch (e) {
      emit(DeleteQuoteToFavoriteError(msg: e.toString()));
    }
  }
}
