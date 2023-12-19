import 'dart:convert';

import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/categories/data/models/quote_category_model.dart';
import 'package:quotes/features/categories/domain/entities/quote_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class QuoteCategoryLocalDataSource {
  Future<List<QuoteCategory>> getLastCategories();
  Future<void> cacheCategories(List<QuoteCategory> categories);
}

class QuoteCategoryLocalDataSourceImpl implements QuoteCategoryLocalDataSource {
  SharedPreferences sharedPreferences;
  QuoteCategoryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheCategories(List<QuoteCategory> categories) {
    return sharedPreferences.setStringList(AppStrings.cachedQuoteCategories,
        categories.map((e) => json.encode(e)).toList());
  }

  @override
  Future<List<QuoteCategory>> getLastCategories() {
    return Future.value(sharedPreferences
        .getStringList(AppStrings.cachedQuoteCategories)!
        .map((e) => QuoteCategoryModel.fromJson(json.decode(e)))
        .toList());
  }
}
