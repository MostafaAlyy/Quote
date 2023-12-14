import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/usecases/usecase.dart';
import 'package:quotes/features/splash/domain/repositories/lang_repositories.dart';

class ChangeLangUseCase implements UseCase<bool, String> {
  final LangRepositories langRepositories;

  ChangeLangUseCase({required this.langRepositories});
  @override
  Future<Either<Failure, bool>> call(String langCode) async {
    return await langRepositories.changeLang(langCode: langCode);
  }
}
