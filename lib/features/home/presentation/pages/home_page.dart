import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/config/locale/app_localizations.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/features/home/presentation/cubit/home_cubit.dart';
import 'package:quotes/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:quotes/injection_container.dart' as di;

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<HomeCubit>(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cupit = HomeCubit.get(context);
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
              ),
            ),
            body: PageView(
              controller: cupit.pageController,
              children: cupit.pages,
              onPageChanged: (value) => cupit.changeCurrentPageIndex(value),
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: AppColors.backgroundColor,
                selectedItemColor: AppColors.primaryColor,
                unselectedItemColor: AppColors.secondaryColor,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                currentIndex: cupit.currentPageIndex,
                onTap: (value) {
                  cupit.goToPage(value);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: AppLocalizations.of(context)!.translate('home')!,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.grid_view_rounded),
                    label:
                        AppLocalizations.of(context)!.translate('categories')!,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.search),
                    label: AppLocalizations.of(context)!.translate('search')!,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.favorite),
                    label: AppLocalizations.of(context)!.translate('favorite')!,
                  ),
                ]),
          );
        },
      ),
    );
  }
}
