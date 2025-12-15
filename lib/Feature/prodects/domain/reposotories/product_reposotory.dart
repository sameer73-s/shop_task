import 'package:dartz/dartz.dart';
import 'package:shop_task/Feature/prodects/domain/entities/product_entity.dart';
import 'package:shop_task/core/errors/failure.dart';

// ignore: unused_element
abstract class ProductReposotory {
  Future<Either<Failure, List<ProductEntity>>> getproducts();
}
