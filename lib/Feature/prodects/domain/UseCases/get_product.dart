import 'package:dartz/dartz.dart';
import 'package:shop_task/Feature/prodects/domain/entities/product_entity.dart';
import 'package:shop_task/Feature/prodects/domain/reposotories/product_reposotory.dart';
import 'package:shop_task/core/errors/failure.dart';

class GetProductUseCase {
  final ProductReposotory reposotory;

  GetProductUseCase(this.reposotory);
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return reposotory.getproducts();
  }
}
