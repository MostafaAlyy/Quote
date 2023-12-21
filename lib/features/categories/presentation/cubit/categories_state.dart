part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class GetCategoriesListLoading extends CategoriesState {}

class CategoriesListLoaded extends CategoriesState {}

class GetCategoriesListError extends CategoriesState {
  final String msg;

  const GetCategoriesListError({required this.msg});
}

class CategoryQuotesListLoading extends CategoriesState {}

class CategoryQuotesListError extends CategoriesState {
  final String msg;

  const CategoryQuotesListError({required this.msg});
}

class CategoryQuotesListLoaded extends CategoriesState {}

class CategoryQuotesLoading extends CategoriesState {}

class CategoryQuotesError extends CategoriesState {
  final String msg;

  const CategoryQuotesError({required this.msg});
}

class CategoryQuotesLoaded extends CategoriesState {
  final Quote quote;

  const CategoryQuotesLoaded({required this.quote});
}
