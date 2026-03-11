import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_assignment/features/product/domain/entities/filter_limits.dart';
import 'package:technical_assignment/features/product/domain/entities/product_entity.dart';
import 'package:technical_assignment/features/product/domain/entities/product_filters.dart';
import 'package:technical_assignment/features/product/domain/entities/sort_option.dart';
import 'package:technical_assignment/features/product/domain/usecases/get_products.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProducts getProducts;

  Timer? _debounce;

  ProductCubit(this.getProducts) : super(ProductLoading());

  void fetchProducts() async {
    emit(ProductLoading());
    try {
      final result = await getProducts();

      final prices = result.map((p) => p.price);
      final minPrice = prices.reduce((a, b) => a < b ? a : b);
      final maxPrice = prices.reduce((a, b) => a > b ? a : b);

      final popular = [...result]..sort((a, b) => b.rating.compareTo(a.rating));
      emit(
        ProductLoaded(
          products: result,
          filteredProducts: result,
          popularProducts: popular.take(10).toList(),
          searchQuery: '',
          sortOption: SortOption.none,
          productFilter: ProductFilter(minPrice: minPrice, maxPrice: maxPrice),
          filterLimits: FilterLimits(minPrice: minPrice, maxPrice: maxPrice),
        ),
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void setSearchQuery(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 800), () {
      _applyFilters(searchQuery: query);
    });
  }

  void setSortOption(SortOption sortOption) {
    _applyFilters(sortOption: sortOption);
  }

  void setProductFilters(ProductFilter productFilter) {
    _applyFilters(productFilter: productFilter);
  }

  void _applyFilters({
    String? searchQuery,
    SortOption? sortOption,
    ProductFilter? productFilter,
  }) {
    final currentState = state;

    if (currentState is ProductLoaded) {
      final query = searchQuery ?? currentState.searchQuery;
      final sort = sortOption ?? currentState.sortOption;
      final filter = productFilter ?? currentState.productFilter;

      List<ProductEntity> filtered = [...currentState.products];

      if (query.isNotEmpty) {
        final searchQuery = query.toLowerCase();

        filtered = filtered.where((product) {
          return product.title.toLowerCase().contains(searchQuery);
        }).toList();
      }

      switch (sort) {
        case SortOption.priceLowToHigh:
          filtered.sort((a, b) => a.price.compareTo(b.price));
          break;
        case SortOption.priceHighToLow:
          filtered.sort((a, b) => b.price.compareTo(a.price));
          break;
        case SortOption.ratingLowToHigh:
          filtered.sort((a, b) => a.rating.compareTo(b.rating));
          break;
        case SortOption.ratingHighToLow:
          filtered.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        default:
          break;
      }
      filtered = filtered.where((product) {
        return product.price >= filter.minPrice &&
            product.price <= filter.maxPrice;
      }).toList();

      emit(
        currentState.copyWith(
          filteredProducts: filtered,
          searchQuery: query,
          sortOption: sort,
          productFilter: ProductFilter(
            minPrice: filter.minPrice,
            maxPrice: filter.maxPrice,
          ),
        ),
      );
    }
  }
}
