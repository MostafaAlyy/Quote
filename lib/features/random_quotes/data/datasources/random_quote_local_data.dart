import 'dart:convert';

import 'package:quotes/core/error/exceptions.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/random_quotes/data/models/quote_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RandomQuoteLocalDataSource {
  Future<QuoteModel> getLastRandomQuote();
  Future<void> cachQuote(QuoteModel quote);
}

class RandomQuoteLocalDataSourceImpl implements RandomQuoteLocalDataSource {
  RandomQuoteLocalDataSourceImpl({required this.sharedPreferences});
  SharedPreferences sharedPreferences;

  @override
  Future<void> cachQuote(QuoteModel quote) {
    return sharedPreferences.setString(
        AppStrings.cachedRandomQuote, json.encode(quote));
  }

  @override
  Future<QuoteModel> getLastRandomQuote() {
    final String? jsonString =
        sharedPreferences.getString(AppStrings.cachedRandomQuote);

    if (jsonString != null) {
      final Future<QuoteModel> cacheRandomQuote =
          Future.value(QuoteModel.fromJson(json.decode(jsonString)));
      return cacheRandomQuote;
    } else {
      throw CacheException();
    }
  }
}
