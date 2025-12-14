import 'package:shop_task/Feature/prodects/domain/entities/sub_entities/reviews_entity.dart';

class ProductEntity {
  final String? title;
  final String? shippingInformation;
  final double? price;
  final double? rating;
  final List<ReviewsEntity>? reviews;
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
