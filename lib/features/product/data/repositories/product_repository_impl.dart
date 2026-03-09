import 'package:technical_assignment/features/product/data/datasources/product_remote_data_source.dart';
import 'package:technical_assignment/features/product/domain/entities/product_entity.dart';
import 'package:technical_assignment/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductEntity>> getProducts() async {
    final productModels = await remoteDataSource.getProduct();
    return productModels.map((model) => model.toEntity()).toList();
  }
}
