import 'package:shop_task/Feature/prodects/domain/entities/sub_entities/reviews_entity.dart';

class ReveiwModel extends ReviewsEntity {
  ReveiwModel({
    required super.rating,
    required super.comment,
    required super.date,
    required super.reviewerName,
    required super.reviewerEmail,
  });
  factory ReveiwModel.fromJson(Map<String, dynamic> json) {
    return ReveiwModel(
      rating: json['rating'],
      comment: json['comment'],
      date: json['date'],
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date,
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }
}
