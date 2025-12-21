import 'package:dartz/dartz.dart';
import 'package:shop_task/Feature/prodects/data/datasources/product_local_datasource.dart';
import 'package:shop_task/Feature/prodects/data/datasources/product_remote_datasource.dart';
import 'package:shop_task/Feature/prodects/domain/entities/product_entity.dart';
import 'package:shop_task/Feature/prodects/domain/reposotories/product_reposotory.dart';
import 'package:shop_task/core/connection/network_info.dart';
import 'package:shop_task/core/errors/expentions.dart';
import 'package:shop_task/core/errors/failure.dart';

class ProductReposotiryImplementation implements ProductReposotory {
  final NetworkInfo networkInfo;
  final ProductRemoteDatasource remoteDatasource;
  final ProductLocalDatasourceSqlite localDatasource;

  ProductReposotiryImplementation({
    required this.networkInfo,
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> getproducts({
    required int page,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDatasource.getproduct(page: page);

        await localDatasource.cacheProducts(remoteProducts);

        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProducts = await localDatasource.getCachedProducts();

        return Right(localProducts);
      } on CacheExeption {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
