import 'package:flutter/foundation.dart';
import 'package:shop_task/Feature/prodects/data/models/sub_models/dimensions_model.dart';
import 'package:shop_task/Feature/prodects/data/models/sub_models/meta_model.dart';
import 'package:shop_task/Feature/prodects/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.title,
    required super.shippingInformation,
    required super.price,
    required super.rating,
    required super.reviews,
    required super.images,
    required this.id,
    required this.description,
    required this.category,
    required this.discountPercentage,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.availabilityStatus,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.thumbnail,
  });
  final int? id;
  final String? description;
  final String? category;
  final double? discountPercentage;
  final int? stock;
  List<String>? tags;
  final String? brand;
  final String? sku;
  final int? weight;
  final List<DimensionsModel>? dimensions;
  final String? warrantyInformation;
  final String? availabilityStatus;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final List<MetaModel>? meta;
  final String? thumbnail;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: json['price'],
      discountPercentage: json['discountPercentage'],
      stock: json['stock'],
      tags: List<String>.from(json['tags'] ?? []),
      brand: json['brand'],
      sku: json['sku'],
      weight: json['weight'],
      dimensions: (json['dimensions'] as List<dynamic>?)
          ?.map((e) => DimensionsModel.fromJson(e))
          .toList(),
      warrantyInformation: json['warrantyInformation'],
      availabilityStatus: json['availabilityStatus'],
      returnPolicy: json['returnPolicy'],
      minimumOrderQuantity: json['minimumOrderQuantity'],
      meta: (json['meta'] as List<dynamic>?)
          ?.map((e) => MetaModel.fromJson(e))
          .toList(),
      rating: json['rating'],
      reviews: json['reviews'] ?? [],
      images: List<String>.from(json['images'] ?? []),
      shippingInformation: json['shippingInformation'],
      thumbnail: json['thumbnail'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions
          ?.map((e) => {'width': e.width, 'height': e.height, 'depth': e.depth})
          .toList(),
      'warrantyInformation': warrantyInformation,
      'availabilityStatus': availabilityStatus,
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta
          ?.map(
            (e) => {
              'createdAt': e.createdAt,
              'updatedAt': e.updatedAt,
              'barcode': e.barcode,
              'qrCode': e.qrCode,
            },
          )
          .toList(),
      'rating': rating,
      'reviews': reviews,
      'images': images,
      'shippingInformation': shippingInformation,
      'thumbnail': thumbnail,
    };
  }
}
