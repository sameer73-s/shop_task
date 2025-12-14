import 'package:shop_task/Feature/prodects/domain/entities/sub_entities/reviews_entity.dart';

class ReveiwModel extends ReviewsEntity {
  ReveiwModel({
    required super.rating,
    required super.comment,
    required super.date,
    required super.reviewerName,
    required super.reviewerEmail,
  });
}
