import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/media_query_extension.dart';
import 'package:quotes/features/random_quotes/presentation/cubit/random_quotes_cubit.dart';
import 'package:quotes/features/random_quotes/presentation/widgets/quote_card.dart';
import 'package:swipeable_card_stack/swipe_controller.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:quotes/core/widgets/error_widget.dart' as error_widget;

class QuotesStack extends StatefulWidget {
  const QuotesStack({
    super.key,
    required this.cardController,
  });

  final SwipeableCardSectionController cardController;

  @override
  State<QuotesStack> createState() => _QuotesStackState();
}

class _QuotesStackState extends State<QuotesStack> {
  _initRandomQuotesList() =>
      BlocProvider.of<RandomQuotesCubit>(context).initRandomQuotesList();
  @override
  void initState() {
    super.initState();
    _initRandomQuotesList();
  }

  @override
  Widget build(BuildContext context) {
    var cupit = RandomQuotesCubit.get(context);
    return BlocConsumer<RandomQuotesCubit, RandomQuotesState>(
        listener: (context, state) {
      if (state is RandomQuotesLoaded) {
        widget.cardController.addItem(QuoteCard(
          author: state.quote.author,
          msg: state.quote.content,
        ));
      }
    }, builder: (context, state) {
      if (state is RandomQuotesListLoading) {
        return Center(
          child: SpinKitFadingCircle(
            color: AppColors.primaryColor,
          ),
        );
      } else if (state is RandomQuotesError || state is RandomQuotesListError) {
        return error_widget.ErrorWidget(onPress: () {
          (state is RandomQuotesError)
              ? cupit.getRandomQuote()
              : cupit.initRandomQuotesList();
        });
      } else {
        return SizedBox(
          height: context.height * 0.8,
          child: Center(
            child: Stack(
              children: [
                Center(
                  child: SpinKitFadingCircle(
                    color: AppColors.primaryColor,
                  ),
                ),
                SwipeableCardsSection(
                  cardController: widget.cardController,
                  context: context,
                  items: cupit.quotesList,
                  onCardSwiped: (dir, index, widget) {
                    cupit.getRandomQuote();
                  },
                  enableSwipeUp: true,
                  enableSwipeDown: false,
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
