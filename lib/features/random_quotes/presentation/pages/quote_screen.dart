import 'package:flutter/material.dart';
import 'package:quotes/features/random_quotes/presentation/widgets/quote_stack.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class QuoteScreen extends StatelessWidget {
  QuoteScreen({super.key});

  final SwipeableCardSectionController cardController =
      SwipeableCardSectionController();

  @override
  Widget build(BuildContext context) {
    return QuotesStack(cardController: cardController);
  }
}
