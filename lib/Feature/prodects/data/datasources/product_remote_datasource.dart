import 'package:shop_task/Feature/prodects/data/models/product_model.dart';
import 'package:shop_task/core/database/api/api_consumer.dart';
import 'package:shop_task/core/database/api/end_points.dart';
import 'package:shop_task/core/params/params.dart';

class ProductRemoteDatasource {
  final ApiConsumer api;

  ProductRemoteDatasource({required this.api});
  Future<ProductModel> getproduct(productsParams params) async {
    final response = await api.get("${EndPoints.product}/${params.id}");
    return ProductModel.fromJson(response);
  }
}
