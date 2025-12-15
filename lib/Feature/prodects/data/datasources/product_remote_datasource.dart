import 'dart:convert';

import 'package:shop_task/Feature/prodects/data/models/product_model.dart';
import 'package:shop_task/core/database/api/api_consumer.dart';
import 'package:shop_task/core/database/api/end_points.dart';

class ProductRemoteDatasource {
  final ApiConsumer api;

  ProductRemoteDatasource({required this.api});
  Future<List<ProductModel>> getproduct() async {
    final response = await api.get("${EndPoints.product}");
    final List products = json.decode(response);
    final List<ProductModel> productlist = products
        .map((product) => ProductModel.fromJson(product))
        .toList();
    return productlist;
  }
}
