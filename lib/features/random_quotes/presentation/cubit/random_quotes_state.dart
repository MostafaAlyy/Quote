part of 'random_quotes_cubit.dart';

abstract class RandomQuotesState {}

class RandomQuotesInitial extends RandomQuotesState {}

class RandomQuotesLoading extends RandomQuotesState {}

class RandomQuotesLoaded extends RandomQuotesState {
  final Quote quote;
  RandomQuotesLoaded({required this.quote});
}

class RandomQuotesError extends RandomQuotesState {
  final String msg;

  RandomQuotesError({required this.msg});
}

class RandomQuotesListLoading extends RandomQuotesState {}

class RandomQuotesListLoaded extends RandomQuotesState {}

class RandomQuotesListError extends RandomQuotesState {
  final String msg;

  RandomQuotesListError({required this.msg});
}
