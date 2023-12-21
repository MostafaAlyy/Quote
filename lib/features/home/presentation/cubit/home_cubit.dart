import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/features/categories/presentation/pages/categories_page.dart';
import 'package:quotes/features/favorite_quote/presentation/pages/favorite_quote_screen.dart';
import 'package:quotes/features/random_quotes/presentation/pages/quote_screen.dart';
import 'package:quotes/features/search/presentation/pages/search_page.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  final PageController pageController = PageController();

  List<Widget> pages = [
    QuoteScreen(),
    const CategoriesPage(),
    SearchPage(),
    const FavoriteQuoteScreen()
  ];
  int currentPageIndex = 0;
  Future<void> goToPage(int index) async {
    currentPageIndex = index;
    emit(ChangingCurrentPage());
    pageController.animateToPage(currentPageIndex,
        duration: const Duration(milliseconds: 350), curve: Curves.bounceInOut);
    emit(ChangeCurrentPage());
  }

  Future<void> changeCurrentPageIndex(int index) async {
    emit(ChangingCurrentPage());
    currentPageIndex = index;
    emit(ChangeCurrentPage());
  }
}
