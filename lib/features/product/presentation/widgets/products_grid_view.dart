import 'package:flutter/material.dart';
import 'package:technical_assignment/features/product/domain/entities/product_entity.dart';
import 'package:technical_assignment/features/product/presentation/widgets/product_cart.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key, required this.products});
  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      padding: const EdgeInsets.all(10.0),
      itemBuilder: (context, index) {
        return ProductCart(
          key: ValueKey(products[index].id),
          product: products[index],
        );
      },
      itemCount: products.length,
      shrinkWrap: true,
    );
  }
}
