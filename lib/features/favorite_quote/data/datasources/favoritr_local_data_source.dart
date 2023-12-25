import 'package:flutter/material.dart';
import 'package:quotes/core/error/exceptions.dart';
import 'package:quotes/features/random_quotes/data/models/quote_model.dart';
import 'package:quotes/features/random_quotes/domain/entities/quote.dart';
import 'package:sqflite/sqflite.dart';

abstract class FavoriteQuoteLocalDataSource {
  Future<void> initDatabase();
  Future<void> addQuote(Quote quote);
  Future<void> deleteQuote(Quote quote);
  Future<Set<Quote>> getFavoriteQuotes();
}

class FavoriteQuoteLocalDataSourceImpl implements FavoriteQuoteLocalDataSource {
  late final Database database;

  @override
  Future<void> initDatabase() async {
    try {
      database = await openDatabase('favorite_quotes.db', version: 1,
          onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE favorite_quotes(id TEXT PRIMARY KEY , quote TEXT, author TEXT)');
      });
    } catch (e) {
      throw LocalDatabaseException();
    }
  }

  @override
  Future<void> addQuote(Quote quote) async {
    try {
      await database.rawInsert(
          'INSERT INTO favorite_quotes(id,quote, author) VALUES("${quote.id}","${quote.content}", "${quote.author}")');
    } catch (e) {
      debugPrint(e.toString());
      throw LocalDatabaseException();
    }
  }

  @override
  Future<void> deleteQuote(Quote quote) async {
    try {
      await database
          .execute('DELETE FROM favorite_quotes WHERE id = "${quote.id}"');
    } catch (e) {
      throw LocalDatabaseException();
    }
  }

  @override
  Future<Set<Quote>> getFavoriteQuotes() async {
    try {
      Set<Quote> quotes = {};
      database.rawQuery('SELECT * FROM favorite_quotes').then((value) => {
            value.forEach((element) {
              debugPrint(element.toString());
              quotes.add(QuoteModel(
                  author: element['author'] as String,
                  content: element['quote'] as String,
                  id: element['id'] as String,
                  tags: const [],
                  authorSlug: '',
                  length: 0,
                  dateAdded: DateTime.now(),
                  dateModified: DateTime.now()));
            })
          });

      return quotes;
    } catch (e) {
      throw LocalDatabaseException();
    }
  }
}
