import 'dart:convert';

import 'package:shop_task/Feature/prodects/data/models/product_model.dart';
import 'package:shop_task/core/database/cache/cache_helper.dart';
import 'package:shop_task/core/errors/expentions.dart';

class ProductLocalDatasource {
  final CacheHelper cache;

  ProductLocalDatasource({required this.cache});
  cacheProduct(ProductModel? producttoCache) {
    if (producttoCache != null) {
      cache.saveData(
        key: 'cachedproduct',
        value: json.encode(producttoCache.toJson()),
      );
    } else {
      throw CacheExeption(errorMessage: "no internet connection");
    }
  }

  Future<ProductModel> getLastProduct() async {
    final jsonString = await cache.getData(key: 'cachedproduct');
    if (jsonString != null) {
      return ProductModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheExeption(errorMessage: "no cached data found");
    }
  }
}
