import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/app_interceptors.dart';
import 'package:quotes/core/api/dio_consumer.dart';
import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/features/home/presentation/cubit/home_cubit.dart';
import 'package:quotes/features/random_quotes/data/datasources/random_quote_local_data.dart';
import 'package:quotes/features/random_quotes/data/datasources/random_quote_remote_data.dart';
import 'package:quotes/features/random_quotes/data/repositories/quote_repository_impl.dart';
import 'package:quotes/features/random_quotes/domain/repositories/quote_repository.dart';
import 'package:quotes/features/random_quotes/domain/usecases/get_random_quote.dart';
import 'package:quotes/features/random_quotes/presentation/cubit/random_quotes_cubit.dart';
import 'package:quotes/features/splash/data/datasources/lang_local_data_sourse.dart';
import 'package:quotes/features/splash/data/repositories/lang_repositories_impl.dart';
import 'package:quotes/features/splash/domain/repositories/lang_repositories.dart';
import 'package:quotes/features/splash/domain/usecases/change_lang.dart';
import 'package:quotes/features/splash/domain/usecases/get_saved_lang.dart';
import 'package:quotes/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> serviceLocatorInit() async {
  //! Features
  // Bloc
  sl.registerFactory<RandomQuotesCubit>(
      () => RandomQuotesCubit(getRandomQuoteUseCase: sl()));
  sl.registerFactory<LocaleCubit>(
      () => LocaleCubit(changeLangUseCase: sl(), getSavedLangUseCase: sl()));
  sl.registerFactory<HomeCubit>(() => HomeCubit());
  // Use Cases
  sl.registerLazySingleton(() => GetRandomQuote(quoteRepository: sl()));
  sl.registerLazySingleton(() => ChangeLangUseCase(langRepositories: sl()));
  sl.registerLazySingleton(() => GetSavedLangUseCase(langRepositories: sl()));
  // Repository
  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
      randomQuoteLocalDataSource: sl(),
      randomQuoteRemoteDataSource: sl(),
      networkInfo: sl()));
  sl.registerLazySingleton<LangRepositories>(
      () => LangRepositoriesImpl(langLocalDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<RandomQuoteLocalDataSource>(
      () => RandomQuoteLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<RandomQuoteRemoteDataSource>(
      () => RandomQuoteRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<LangLocalDataSource>(
      () => LangLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnection: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  //! Externals
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton(() => Dio());
}
