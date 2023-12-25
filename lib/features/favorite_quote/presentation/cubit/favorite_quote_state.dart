part of 'favorite_quote_cubit.dart';

abstract class FavoriteQuoteState {}

class FavoriteQuoteInitial extends FavoriteQuoteState {}

class InitFavoriteDatabaseQuoteLoading extends FavoriteQuoteState {}

class InitFavoriteDatabaseQuoteLoaded extends FavoriteQuoteState {}

class InitFavoriteDatabaseQuoteError extends FavoriteQuoteState {
  final String msg;
  InitFavoriteDatabaseQuoteError({required this.msg});
}

class GetFavoriteDatabaseQuoteLoading extends FavoriteQuoteState {}

class GetFavoriteDatabaseQuoteLoaded extends FavoriteQuoteState {}

class GetFavoriteDatabaseQuoteError extends FavoriteQuoteState {
  final String msg;
  GetFavoriteDatabaseQuoteError({required this.msg});
}

class AddQuoteToFavoriteSuccess extends FavoriteQuoteState {}

class AddQuoteToFavoriteError extends FavoriteQuoteState {
  final String msg;
  AddQuoteToFavoriteError({required this.msg});
}

class DeleteQuoteToFavoriteSuccess extends FavoriteQuoteState {}

class DeleteQuoteToFavoriteError extends FavoriteQuoteState {
  final String msg;
  DeleteQuoteToFavoriteError({required this.msg});
}
