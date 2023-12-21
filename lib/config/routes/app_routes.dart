import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:quotes/features/home/presentation/pages/home_page.dart';
import 'package:quotes/features/random_quotes/presentation/cubit/random_quotes_cubit.dart';
import 'package:quotes/features/splash/presentation/pages/splash_screen.dart';
import 'package:quotes/injection_container.dart' as di;

class Routes {
  static const String initialRoute = '/';
  static const String homePageRoute = '/homePage';
}

class AppRoutes {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.homePageRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    di.sl<RandomQuotesCubit>()..initRandomQuotesList(),
              ),
              BlocProvider(
                create: (context) =>
                    di.sl<CategoriesCubit>()..initCategoriesList(),
              ),
            ],
            child: const HomePage(),
          ),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
              body: Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
