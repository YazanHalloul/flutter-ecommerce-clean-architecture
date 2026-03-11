import 'package:equatable/equatable.dart';

class ProductFilter extends Equatable {
  final double minPrice;
  final double maxPrice;

  ProductFilter({required this.minPrice, required this.maxPrice});

  ProductFilter copyWith({double? minPrice, double? maxPrice}) {
    return ProductFilter(
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }
  
  @override
  List<Object?> get props =>[maxPrice, minPrice];
}
