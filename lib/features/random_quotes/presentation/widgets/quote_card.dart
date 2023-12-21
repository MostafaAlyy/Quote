import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/features/random_quotes/presentation/cubit/random_quotes_cubit.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key, required this.msg, required this.author});
  final String msg;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.primaryColor,
              width: 2,
            )),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ",,",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  msg,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 8,
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      author,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.ios_share)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border)),
                  ],
                )
              ]),
        ));
  }
}
