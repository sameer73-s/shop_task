import 'dart:convert';

import 'package:shop_task/Feature/prodects/data/models/product_model.dart';
import 'package:shop_task/core/database/api/end_points.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDatasource {
  ProductRemoteDatasource();
  Future<List<ProductModel>> getproduct({
    required int page,
  }) async {
    final url = EndPoints.baseUrl + EndPoints.products(page: page);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to load products');
    } else {
      final List jsons = json.decode(response.body)["products"];
      final List<ProductModel> productlist = jsons
          .map((product) => ProductModel.fromJson(product))
          .toList();
      return productlist;
    }
  }
}
