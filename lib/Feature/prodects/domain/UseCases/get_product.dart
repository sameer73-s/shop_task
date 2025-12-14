import 'package:dartz/dartz.dart';
import 'package:shop_task/Feature/prodects/domain/entities/product_entity.dart';
import 'package:shop_task/Feature/prodects/domain/reposotories/product_reposotory.dart';
import 'package:shop_task/core/errors/failure.dart';
import 'package:shop_task/core/params/params.dart';

class GetProduct {
  final ProductReposotory reposotory;

  GetProduct({required this.reposotory});
  Future<Either<Failure, ProductEntity>> call({
    required productsParams params,
  }) async {
    return reposotory.getproducts(params: params);
  }
}
