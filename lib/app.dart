import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/config/locale/app_localizations_setup.dart';
import 'package:quotes/config/routes/app_routes.dart';
import 'package:quotes/config/themes/app_theme.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:quotes/injection_container.dart' as di;

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => di.sl<LocaleCubit>(),
        child: BlocBuilder<LocaleCubit, LocaleState>(
            buildWhen: (previousState, currentState) {
              return previousState != currentState;
            },
            builder: (context, state) => ScreenUtilInit(
                  designSize: const Size(360, 690),
                  minTextAdapt: true,
                  splitScreenMode: true,
                  child: MaterialApp(
                    locale: state.locale,
                    title: AppStrings.appName,
                    debugShowCheckedModeBanner: false,
                    theme: appTheme(),
                    onGenerateRoute: AppRoutes.onGenerateRoute,
                    supportedLocales: AppLocalizationsSetup.supportedLocales,
                    localeResolutionCallback:
                        AppLocalizationsSetup.localeResolutionCallback,
                    localizationsDelegates:
                        AppLocalizationsSetup.localizationsDelegates,
                  ),
                )));
  }
}
