import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class QuotesStack extends StatelessWidget {
  const QuotesStack({
    super.key,
    required this.cardController,
    required this.quotesList,
    this.onCardSwiped,
  });

  final SwipeableCardSectionController cardController;
  final List<Widget> quotesList;
  final Function? onCardSwiped;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SpinKitFadingCircle(
            color: AppColors.primaryColor,
          ),
        ),
        SwipeableCardsSection(
          cardController: cardController,
          context: context,
          items: quotesList,
          onCardSwiped: (dir, index, widget) {
            if (onCardSwiped != null) {
              onCardSwiped!();
            }
          },
          enableSwipeUp: true,
          enableSwipeDown: false,
        ),
      ],
    );
  }
}
