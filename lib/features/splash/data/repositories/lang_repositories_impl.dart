import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/exceptions.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/features/splash/data/datasources/lang_local_data_sourse.dart';
import 'package:quotes/features/splash/domain/repositories/lang_repositories.dart';

class LangRepositoriesImpl extends LangRepositories {
  LangLocalDataSource langLocalDataSource;
  LangRepositoriesImpl({required this.langLocalDataSource});

  @override
  Future<Either<Failure, bool>> changeLang({required String langCode}) async {
    try {
      final isLangChanged =
          await langLocalDataSource.changeLang(langCode: langCode);
      return Right(isLangChanged);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getSavedLang() async {
    try {
      final savedLang = await langLocalDataSource.getSavedLang();
      return Right(savedLang);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
