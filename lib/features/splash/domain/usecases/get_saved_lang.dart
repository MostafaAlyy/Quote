import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/usecases/usecase.dart';
import 'package:quotes/features/splash/domain/repositories/lang_repositories.dart';

class GetSavedLangUseCase implements UseCase<String, NoParams> {
  final LangRepositories langRepositories;

  GetSavedLangUseCase({required this.langRepositories});
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await langRepositories.getSavedLang();
  }
}
