import 'package:get_it/get_it.dart';
import 'package:technical_assignment/core/network/api_client.dart';
import 'package:technical_assignment/features/product/data/datasources/product_remote_data_source.dart';
import 'package:technical_assignment/features/product/data/repositories/product_repository_impl.dart';
import 'package:technical_assignment/features/product/domain/repositories/product_repository.dart';
import 'package:technical_assignment/features/product/domain/usecases/get_products.dart';

final getIt = GetIt.instance;

void setupInjection() {

  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  // Remote data source (IMPLEMENTATION)
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(getIt()),
  );

  // Repository (DOMAIN interface → DATA implementation)
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt()),
  );

  // Use case
  getIt.registerLazySingleton<GetProducts>(
    () => GetProducts(getIt()),
  );
}
