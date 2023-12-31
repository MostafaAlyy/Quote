import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/features/random_quotes/presentation/cubit/random_quotes_cubit.dart';
import 'package:quotes/features/random_quotes/presentation/widgets/quote_stack.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:quotes/core/widgets/error_widget.dart' as error_widget;
import 'package:quotes/core/widgets/quote_card.dart';
import 'package:quotes/core/utils/media_query_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen>
    with AutomaticKeepAliveClientMixin<QuoteScreen> {
  final SwipeableCardSectionController cardController =
      SwipeableCardSectionController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var cupit = RandomQuotesCubit.get(context);
    return BlocConsumer<RandomQuotesCubit, RandomQuotesState>(
        listener: (context, state) {
      if (state is RandomQuotesLoaded) {
        cardController.addItem(QuoteCard(
          quote: state.quote,
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
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: SizedBox(
            height: context.height * 0.8,
            child: Center(
              child: QuotesStack(
                  cardController: cardController,
                  quotesList: cupit.quotesList,
                  onCardSwiped: () {
                    cupit.getRandomQuote();
                  }),
            ),
          ),
        );
      }
    });
  }
}
