import 'package:shop_task/Feature/prodects/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  int? id;
  final String? description;
  final String? category;
  final double? discountPercentage;
  int? stock;
  List<String>? tags;
  final String? brand;

  ProductModel({
    required super.title,
    required super.shippingInformation,
    required super.price,
    required super.rating,
    required super.reviews,
    required super.images,
    required this.description,
  });
}
