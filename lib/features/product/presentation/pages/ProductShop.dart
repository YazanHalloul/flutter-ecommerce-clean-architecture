import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technical_assignment/features/product/domain/entities/sort_option.dart';
import 'package:technical_assignment/features/product/presentation/cubit/product_cubit.dart';
import 'package:technical_assignment/features/product/presentation/cubit/sort_option_ext.dart';
import 'package:technical_assignment/features/product/presentation/widgets/filter_bottom_sheet.dart';
import 'package:technical_assignment/features/product/presentation/widgets/product_cart.dart';
import 'package:technical_assignment/features/product/presentation/widgets/products_grid_view.dart';

class ProductShop extends StatefulWidget {
  const ProductShop({super.key});

  @override
  State<ProductShop> createState() => _ProductShopState();
}

class _ProductShopState extends State<ProductShop> {
  int selectedCategory = 0;

  List<String> categories = [
    "All",
    "Electronics",
    "Clothing",
    "Home",
    "Books",
    "Toys",
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final FocusNode _searchFocusNode = FocusNode();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: BlocSelector<ProductCubit, ProductState, String>(
                    selector: (state) =>
                        state is ProductLoaded ? state.searchQuery : '',
                    builder: (context, state) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 7.0),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          focusNode: _searchFocusNode,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: (value) {
                            context.read<ProductCubit>().setSearchQuery(value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Search for products',
                            border: InputBorder.none,
                            icon: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: _searchFocusNode.hasFocus
                                  ? null
                                  : const Icon(Icons.search),
                            ),

                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor,
                                width: 2.5,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 7.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.tune),
                      onPressed: () {
                        final productCubit = context.read<ProductCubit>();
                        if (productCubit.state is ProductLoaded) {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (bottomSheetContext) {
                              return BlocProvider.value(
                                value: productCubit,
                                child: FilterBottomSheet(),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                BlocSelector<ProductCubit, ProductState, SortOption>(
                  selector: (state) {
                    return state is ProductLoaded
                        ? state.sortOption
                        : SortOption.none;
                  },
                  builder: (context, state) {
                    return PopupMenuButton<SortOption>(
                      color: Colors.grey[100],
                      offset: Offset(0, 53),
                      constraints: BoxConstraints(minWidth: double.infinity),
                      onSelected: (value) {
                        context.read<ProductCubit>().setSortOption(value);
                        FocusScope.of(context).unfocus();
                      },
                      itemBuilder: (context) => SortOption.values.map((option) {
                        return PopupMenuItem(
                          value: option,
                          child: Row(
                            children: [
                              Text(option.menuLabel),
                              Spacer(),
                              state == option
                                  ? FaIcon(
                                      FontAwesomeIcons.solidCircleCheck,
                                      size: 17,
                                      color: primaryColor,
                                    )
                                  : const FaIcon(
                                      FontAwesomeIcons.circle,
                                      size: 17,
                                    ),
                            ],
                          ),
                        );
                      }).toList(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 13,
                          horizontal: 8,
                        ),
                        margin: EdgeInsets.only(right: 7),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(state.label),
                            SizedBox(width: 3),
                            state.getSortIcon,
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: index == selectedCategory
                          ? primaryColor
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedCategory = index;
                          });
                        },
                        child: Text(
                          categories[index],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Products",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  return switch (state) {
                    ProductLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    ProductLoaded() => ProductsGridView(
                      products: state.filteredProducts,
                    ),
                    // TODO: Handle this case.
                    ProductError() => throw UnimplementedError(),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
