import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_task/Feature/prodects/data/models/product_model.dart';
import 'package:shop_task/core/database/cache/cache_helper.dart';
import 'package:shop_task/core/errors/expentions.dart';

class ProductLocalDatasource {
  final CacheHelper cache;

  ProductLocalDatasource(
    this.cache);
  void cacheProduct(List<ProductModel>? producttoCache) {
    if (producttoCache != null) {
      cache.saveData(
        key: 'cachedproduct',
        value: json.encode(
          producttoCache
              .map<Map<String, dynamic>>(
                (productmodel) => productmodel.toJson(),
              )
              .toList(),
        ),
      );
    } else {
      throw CacheExeption(errorMessage: "no internet connection");
    }
  }

  Future<List<ProductModel>> getLastProduct() async {
    final jsonString = await cache.getData(key: 'cachedproduct');
    if (jsonString != null) {
      final List products = json.decode(jsonString);
      final List<ProductModel> productlist = products
          .map((product) => ProductModel.fromJson(product))
          .toList();
      return productlist;
    } else {
      throw CacheExeption(errorMessage: "no cached data found");
    }
  }
}
