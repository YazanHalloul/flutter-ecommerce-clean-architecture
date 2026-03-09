import 'package:technical_assignment/core/network/api_client.dart';
import 'package:technical_assignment/features/product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProduct();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient client;

  ProductRemoteDataSourceImpl(this.client);

  @override
  Future<List<ProductModel>> getProduct() async {
    try {
      final response = await client.get("/products");

      if (response.statusCode == 200) {
        print(response.data["products"]);

        final data = response.data["products"] as List<dynamic>;

        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
