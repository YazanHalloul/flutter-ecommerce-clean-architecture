part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  final List<ProductEntity> filteredProducts;
  final List<ProductEntity> popularProducts;
  final String searchQuery;
  final SortOption sortOption;
  final ProductFilter productFilter;
  final FilterLimits filterLimits;

  const ProductLoaded({
    required this.products,
    required this.searchQuery,
    required this.sortOption,
    required this.filteredProducts,
    required this.productFilter,
    required this.filterLimits,
    required this.popularProducts,
  });

  @override
  List<Object> get props => [
    products,
    searchQuery,
    filteredProducts,
    sortOption,
    productFilter,
    popularProducts
  ];
  ProductLoaded copyWith({
    List<ProductEntity>? products,
    List<ProductEntity>? filteredProducts,
    List<ProductEntity>? popularProducts,
    String? searchQuery,
    SortOption? sortOption,
    ProductFilter? productFilter,
    FilterLimits? filterLimits,

  }) {
    return ProductLoaded(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      popularProducts: popularProducts ?? this.popularProducts,
      searchQuery: searchQuery ?? this.searchQuery,
      sortOption: sortOption ?? this.sortOption,
      productFilter: productFilter ?? this.productFilter,
      filterLimits: filterLimits ?? this.filterLimits,
    );
  }
}

class ProductSearching extends ProductState {
  final ProductState previousState;

  const ProductSearching({required this.previousState});

  @override
  List<Object> get props => [previousState];
}


class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
