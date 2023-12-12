import 'package:flutter/material.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/app_strings.dart';

ThemeData appTheme() {
  return ThemeData(
      primaryColor: AppColors.primaryColor,
      hintColor: AppColors.hintColor,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      fontFamily: AppStrings.fontFamily,
      appBarTheme: const AppBarTheme(
          centerTitle: true, color: Colors.transparent, elevation: 0),
      iconTheme: IconThemeData(color: AppColors.primaryColor, size: 32),
      textTheme: TextTheme(
        labelLarge: TextStyle(
            fontSize: 70,
            color: AppColors.primaryColor,
            fontFamily: AppStrings.fontFamily),
        bodyMedium: TextStyle(
            fontSize: 20,
            color: AppColors.primaryColor,
            overflow: TextOverflow.ellipsis,
            fontFamily: AppStrings.fontFamily),
        bodySmall: TextStyle(
          fontSize: 18,
          color: AppColors.primaryColor,
        ),
      ));
}
