import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_task/Feature/prodects/data/datasources/product_local_datasource.dart';
import 'package:shop_task/Feature/prodects/data/datasources/product_remote_datasource.dart';
import 'package:shop_task/Feature/prodects/data/reposotries/product_reposotiry_implementation.dart';
import 'package:shop_task/Feature/prodects/domain/UseCases/get_product.dart';
import 'package:shop_task/Feature/prodects/domain/reposotories/product_reposotory.dart';
import 'package:shop_task/Feature/prodects/presentation/bloc/products/products_bloc.dart';
import 'package:shop_task/core/connection/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc / Cubit
  sl.registerFactory(() => ProductsBloc(getProductUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetProductUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ProductReposotory>(
    () => ProductReposotiryImplementation(
      remoteDatasource: sl(),
      localDatasource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDatasource(api: sl()),
  );
  sl.registerLazySingleton<ProductLocalDatasource>(
    () => ProductLocalDatasource(sl(), sharedPreferences: sl()),
  );

  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
