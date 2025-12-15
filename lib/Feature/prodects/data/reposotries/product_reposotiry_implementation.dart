import 'package:dartz/dartz.dart';
import 'package:shop_task/Feature/prodects/data/datasources/product_local_datasource.dart';
import 'package:shop_task/Feature/prodects/data/datasources/product_remote_datasource.dart';
import 'package:shop_task/Feature/prodects/domain/entities/product_entity.dart';
import 'package:shop_task/Feature/prodects/domain/reposotories/product_reposotory.dart';
import 'package:shop_task/core/connection/network_info.dart';
import 'package:shop_task/core/errors/expentions.dart';
import 'package:shop_task/core/errors/failure.dart';

class ProductReposotiryImplementation extends ProductReposotory {
  final NetworkInfo networkInfo;
  final ProductRemoteDatasource remoteDatasource;
  final ProductLocalDatasource localDatasource;

  ProductReposotiryImplementation({
    required this.networkInfo,
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> getproducts() async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteproduct = await remoteDatasource.getproduct();
        localDatasource.cacheProduct(remoteproduct);
        return right(remoteproduct);
      } on ServerException catch (e) {
        return Left(ServerFailure());
      }
    } else {}

    try {
      final localproduct = await localDatasource.getLastProduct();
      return right(localproduct);
    } on CacheExeption catch (e) {
      return Left(EmptyCacheFailure());
    }
  }
}
