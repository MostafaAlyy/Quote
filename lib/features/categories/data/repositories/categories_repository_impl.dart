import 'package:dartz/dartz.dart';
import 'package:quotes/core/error/exceptions.dart';
import 'package:quotes/core/error/failure.dart';
import 'package:quotes/core/network/network_info.dart';
import 'package:quotes/features/categories/data/datasources/quote_category_local_data.dart';
import 'package:quotes/features/categories/data/datasources/quote_category_remote_data.dart';
import 'package:quotes/features/categories/domain/entities/quote_category.dart';
import 'package:quotes/features/categories/domain/repositories/categories_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final QuoteCategoryRemoteDataSource remoteDataSource;
  final QuoteCategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<QuoteCategory>>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategories = await remoteDataSource.getCategories();
        localDataSource.cacheCategories(remoteCategories);
        return Right(remoteCategories);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCategories = await localDataSource.getLastCategories();
        return Right(localCategories);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
