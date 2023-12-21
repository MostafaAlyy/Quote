import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:quotes/features/random_quotes/presentation/cubit/random_quotes_cubit.dart';
import 'package:quotes/features/random_quotes/presentation/widgets/quote_stack.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:quotes/core/widgets/error_widget.dart' as error_widget;
import 'package:quotes/features/random_quotes/presentation/widgets/quote_card.dart';
import 'package:quotes/core/utils/media_query_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuoteByCategoryScreen extends StatefulWidget {
  const QuoteByCategoryScreen({super.key, required this.category});
  final String category;
  @override
  State<QuoteByCategoryScreen> createState() => _QuoteByCategoryScreenState();
}

class _QuoteByCategoryScreenState extends State<QuoteByCategoryScreen> {
  final SwipeableCardSectionController cardController =
      SwipeableCardSectionController();
  _initQuotesByCategoryList() =>
      CategoriesCubit.get(context).initQuotesByCategoryList(widget.category);
  @override
  void initState() {
    _initQuotesByCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cupit = CategoriesCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.category,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: AppColors.primaryColor)),
      ),
      body: BlocConsumer<CategoriesCubit, CategoriesState>(
          listener: (context, state) {
        if (state is CategoryQuotesLoaded) {
          cardController.addItem(QuoteCard(
            author: state.quote.author,
            msg: state.quote.content,
          ));
        }
      }, builder: (context, state) {
        if (state is CategoryQuotesListLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
            ),
          );
        } else if (state is CategoryQuotesListError ||
            state is CategoryQuotesError) {
          return error_widget.ErrorWidget(onPress: () {
            (state is CategoryQuotesError)
                ? cupit.getCategoryQuote(widget.category)
                : cupit.initQuotesByCategoryList(widget.category);
          });
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SizedBox(
              height: context.height * 0.8,
              child: Center(
                child: QuotesStack(
                    cardController: cardController,
                    quotesList: cupit.quotesByCategoryList,
                    onCardSwiped: () {
                      cupit.getCategoryQuote(widget.category);
                    }),
              ),
            ),
          );
        }
      }),
    );
  }
}
