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
