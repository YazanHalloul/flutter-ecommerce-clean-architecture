
import 'package:technical_assignment/features/product/domain/entities/product_entity.dart';
import 'package:technical_assignment/features/product/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<List<ProductEntity>> call() {
    return repository.getProducts();
  }
}
