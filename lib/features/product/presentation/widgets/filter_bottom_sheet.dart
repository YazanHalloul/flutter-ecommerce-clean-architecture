import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technical_assignment/features/product/domain/entities/product_filters.dart';
import 'package:technical_assignment/features/product/presentation/cubit/product_cubit.dart';
import 'package:technical_assignment/features/product/presentation/widgets/filter_range_slider.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late double tempMinPrice;
  late double tempMaxPrice;
  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final cubitState = context.read<ProductCubit>().state as ProductLoaded;

    if (!initialized) {
      tempMinPrice = cubitState.productFilter.minPrice;
      tempMaxPrice = cubitState.productFilter.maxPrice;
      initialized = true;
    }
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Filter",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Divider(color: const Color(0xFF222831)),

          FilterRangeSlider(
            title: "Price",
            min: cubitState.filterLimits.minPrice,
            max: cubitState.filterLimits.maxPrice,
            currentMin: tempMinPrice,
            currentMax: tempMaxPrice,
            onChanged: (values) {
              setState(() {
                tempMinPrice = values.start;
                tempMaxPrice = values.end;
              });
            },
            suffixText: '\$',
          ),

          Divider(color: const Color(0xFF222831)),

          Align(
            alignment: AlignmentGeometry.topLeft,
            child: Text(
              "Ratings",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              5,
              (index) => Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: index == 0
                    ? FaIcon(
                        FontAwesomeIcons.solidStar,
                        color: primaryColor,
                        size: 18,
                      )
                    : Text("$index+"),
              ),
            ),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),

            onPressed: () {
              context.read<ProductCubit>().setProductFilters(
                ProductFilter(minPrice: tempMinPrice, maxPrice: tempMaxPrice),
              );
              Navigator.pop(context);
            },
            child: Text(
              "Show Filters",
              style: TextStyle(
                color: const Color(0xFF222831),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
