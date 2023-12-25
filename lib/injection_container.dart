import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/app_interceptors.dart';
import 'package:quotes/core/api/dio_consumer.dart';
import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/features/categories/data/datasources/quote_category_local_data.dart';
import 'package:quotes/features/categories/data/datasources/quote_category_remote_data.dart';
import 'package:quotes/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:quotes/features/categories/domain/repositories/categories_repository.dart';
import 'package:quotes/features/categories/domain/usecases/get_quote_by_category.dart';
import 'package:quotes/features/categories/domain/usecases/get_quote_categories_usecase.dart';
import 'package:quotes/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:quotes/features/favorite_quote/data/datasources/favoritr_local_data_source.dart';
import 'package:quotes/features/favorite_quote/data/repositories/favorite_repository_impl.dart';
import 'package:quotes/features/favorite_quote/domain/repositories/favorite_repository.dart';
import 'package:quotes/features/favorite_quote/domain/usecases/add_quote_to_favorite_use_case.dart';
import 'package:quotes/features/favorite_quote/domain/usecases/delete_quote_from_favorite_use_case.dart';
import 'package:quotes/features/favorite_quote/domain/usecases/get_favorite_quotes_use_case.dart';
import 'package:quotes/features/favorite_quote/domain/usecases/init_favorite_database_use_case.dart';
import 'package:quotes/features/favorite_quote/presentation/cubit/favorite_quote_cubit.dart';
import 'package:quotes/features/home/presentation/cubit/home_cubit.dart';
import 'package:quotes/features/random_quotes/data/datasources/random_quote_local_data.dart';
import 'package:quotes/features/random_quotes/data/datasources/random_quote_remote_data.dart';
import 'package:quotes/features/random_quotes/data/repositories/quote_repository_impl.dart';
import 'package:quotes/features/random_quotes/domain/repositories/quote_repository.dart';
import 'package:quotes/features/random_quotes/domain/usecases/get_random_quote.dart';
import 'package:quotes/features/random_quotes/presentation/cubit/random_quotes_cubit.dart';
import 'package:quotes/features/search/data/datasources/search_remote_data_source.dart';
import 'package:quotes/features/search/data/repositories/search_repository_impl.dart';
import 'package:quotes/features/search/domain/repositories/search_repository.dart';
import 'package:quotes/features/search/domain/usecases/search_quote_use_case.dart';
import 'package:quotes/features/search/presentation/cubit/search_cubit.dart';
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
  sl.registerFactory<SearchCubit>(() => SearchCubit(searchQuoteUseCase: sl()));
  sl.registerFactory<CategoriesCubit>(() => CategoriesCubit(
      getQuoteCategoriesUseCase: sl(), getQuoteByCategoryUseCase: sl()));
  sl.registerFactory<FavoriteQuoteCubit>(() => FavoriteQuoteCubit(
      addQuoteToFavoriteUseCase: sl(),
      deleteQuoteFromFavoriteUseCase: sl(),
      getFavoriteQuotesUseCase: sl(),
      initFavoriteDatabaseUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetRandomQuote(quoteRepository: sl()));
  sl.registerLazySingleton(() => ChangeLangUseCase(langRepositories: sl()));
  sl.registerLazySingleton(() => GetSavedLangUseCase(langRepositories: sl()));
  sl.registerLazySingleton(() => SearchQuoteUseCase(searchRepository: sl()));
  sl.registerLazySingleton(
      () => GetQuoteCategoriesUseCase(categoryRepository: sl()));
  sl.registerLazySingleton(
      () => GetQuoteByCategoryUseCase(categoryRepository: sl()));
  sl.registerLazySingleton(
      () => GetFavoriteQuotesUseCase(favoriteQuoteRepository: sl()));
  sl.registerLazySingleton(
      () => AddQuoteToFavoriteUseCase(favoriteQuoteRepository: sl()));
  sl.registerLazySingleton(
      () => DeleteQuoteFromFavoriteUseCase(favoriteQuoteRepository: sl()));
  sl.registerLazySingleton(
      () => InitFavoriteDatabaseUseCase(favoriteQuoteRepository: sl()));

  // Repository
  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
      randomQuoteLocalDataSource: sl(),
      randomQuoteRemoteDataSource: sl(),
      networkInfo: sl()));
  sl.registerLazySingleton<LangRepositories>(
      () => LangRepositoriesImpl(langLocalDataSource: sl()));

  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(
      networkInfo: sl(), localDataSource: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(
        searchRemoteDataSource: sl(),
      ));
  sl.registerLazySingleton<FavoriteQuoteRepository>(
      () => FavoriteQuoteRepositoryImpl(
            localDataSource: sl(),
          ));

  // Data Sources
  sl.registerLazySingleton<RandomQuoteLocalDataSource>(
      () => RandomQuoteLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<RandomQuoteRemoteDataSource>(
      () => RandomQuoteRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<LangLocalDataSource>(
      () => LangLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<QuoteCategoryLocalDataSource>(
      () => QuoteCategoryLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<QuoteCategoryRemoteDataSource>(
      () => QuoteCategoryRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<FavoriteQuoteLocalDataSource>(
      () => FavoriteQuoteLocalDataSourceImpl());

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
