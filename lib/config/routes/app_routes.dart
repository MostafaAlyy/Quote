import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/favorite_quote/presentation/pages/favorite_quote_screen.dart';
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
          builder: (context) => BlocProvider(
            create: (context) => di.sl<RandomQuotesCubit>(),
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
