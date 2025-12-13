import 'package:shop_task/Feature/prodects/domain/entities/reviews_entities.dart';

class ProductEntity {
  final String? title;
  final String? shippingInformation;
  final double? price;
  final double? rating;
  final List<Reviews>? reviews;
  final List<String>? images;

  ProductEntity({
    required this.title,
    required this.shippingInformation,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.images,
  });
}
