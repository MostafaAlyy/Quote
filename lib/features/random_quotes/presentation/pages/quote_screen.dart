import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/config/locale/app_localizations.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/assets_manager.dart';
import 'package:quotes/core/utils/media_query_extension.dart';
import 'package:quotes/features/random_quotes/presentation/widgets/quote_stack.dart';
import 'package:quotes/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class QuoteScreen extends StatelessWidget {
  QuoteScreen({super.key});

  final SwipeableCardSectionController cardController =
      SwipeableCardSectionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.translate_outlined,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            if (AppLocalizations.of(context)!.isEnLocale) {
              BlocProvider.of<LocaleCubit>(context).toArabic();
            } else {
              BlocProvider.of<LocaleCubit>(context).toEnglish();
            }
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.translate('app_name')!,
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: AppColors.primaryColor),
          //  SizedBox(
          //   height: context.height * 0.2,
          //   child: Image.asset(
          //     ImgAssets.quoteImg,
          //     fit: BoxFit.fill,
          //     color: AppColors.appBarTitleColor,
          //   ),
        ),
      ),
      body: QuotesStack(cardController: cardController),
    );
  }
}
