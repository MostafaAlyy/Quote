import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/features/random_quotes/domain/entities/quote.dart';
import 'package:quotes/core/widgets/quote_card.dart';

class QuoteListView extends StatelessWidget {
  const QuoteListView({
    super.key,
    required this.quotes,
  });
  final List<Quote> quotes;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return QuoteCard(
            quote: quotes[index],
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          height: 20.h,
        ),
      ),
    );
  }
}
