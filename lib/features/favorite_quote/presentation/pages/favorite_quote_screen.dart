import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/widgets/quote_list_view.dart';
import 'package:quotes/features/favorite_quote/presentation/cubit/favorite_quote_cubit.dart';
import 'package:quotes/core/widgets/error_widget.dart' as error_widget;

class FavoriteQuoteScreen extends StatelessWidget {
  const FavoriteQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteQuoteCubit, FavoriteQuoteState>(
        builder: (context, state) {
          var cupit = FavoriteQuoteCubit.get(context);
          if (state is GetFavoriteDatabaseQuoteError) {
            return error_widget.ErrorWidget(onPress: () {
              cupit.getFavoriteQuotes();
            });
          } else if (state is GetFavoriteDatabaseQuoteLoading) {
            return Center(
                child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
            ));
          } else {
            return Padding(
                padding: EdgeInsets.all(12.r),
                child: ConditionalBuilder(
                  condition: cupit.quotesList.isEmpty,
                  builder: (context) =>
                      const Center(child: Text('No favorite quotes')),
                  fallback: (context) => Column(
                    children: [
                      QuoteListView(
                          quotes: FavoriteQuoteCubit.get(context)
                              .quotesList
                              .toList()),
                    ],
                  ),
                ));
          }
        },
      ),
    );
  }
}
