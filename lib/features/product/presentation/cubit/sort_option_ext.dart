import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technical_assignment/features/product/domain/entities/sort_option.dart';

extension SortOptionX on SortOption {
  String get label {
    switch (this) {
      case SortOption.priceLowToHigh || SortOption.priceHighToLow:
        return "Price";
      case SortOption.ratingHighToLow || SortOption.ratingLowToHigh:
        return "Rating";
      default:
        return "Default";
    }
  }

  String get menuLabel {
    switch (this) {
      case SortOption.priceLowToHigh:
        return "Price Low To High";
      case SortOption.priceHighToLow:
        return "Price High To Low";
      case SortOption.ratingLowToHigh:
        return "Rating Low To High";
      case SortOption.ratingHighToLow:
        return "Rating High To Low";
      default:
        return "Default";
    }
  }

  Icon get getSortIcon {
    switch (this) {
      case SortOption.priceLowToHigh || SortOption.ratingLowToHigh:
        return const FaIcon(FontAwesomeIcons.arrowDownShortWide, size: 17);

      case SortOption.priceHighToLow || SortOption.ratingHighToLow:
        return const FaIcon(FontAwesomeIcons.arrowDownWideShort, size: 17);

      default:
        return const FaIcon(FontAwesomeIcons.upDown, size: 15);
    }
  }
}
