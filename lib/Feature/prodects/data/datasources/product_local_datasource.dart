import 'package:shop_task/core/errors/expentions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shop_task/core/database/sqlite/database_helper.dart';
import 'package:shop_task/Feature/prodects/data/models/product_model.dart';

class ProductLocalDatasourceSqlite {
  final DatabaseHelper databaseHelper;

  ProductLocalDatasourceSqlite(this.databaseHelper);
  Future<void> cacheProducts(List<ProductModel> products) async {
    final Database db = await databaseHelper.database;

    final batch = db.batch();

    for (final product in products) {
      batch.insert(
        'products',
        product.toDbMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<ProductModel>> getCachedProducts() async {
    final Database db = await databaseHelper.database;

    final result = await db.query('products');

    if (result.isEmpty) {
      throw CacheExeption(errorMessage: "no cached data found");
    }

    return result.map((map) => ProductModel.fromDb(map)).toList();
  }
}
