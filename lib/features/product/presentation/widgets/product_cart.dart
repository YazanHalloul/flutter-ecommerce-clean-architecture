import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technical_assignment/features/product/domain/entities/product_entity.dart';

class ProductCart extends StatelessWidget {
  const ProductCart({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0, 1),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    ),
                    errorWidget: (context, url, error) =>
                        FaIcon(FontAwesomeIcons.productHunt),
                  ),
                ),
              ),
              Positioned(
                top: 3,
                right: 3,
                child: Container(
                  height: 33,
                  width: 33,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    // borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.solidHeart,
                      size: 16,
                      color: product.isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      // setState(() {
                      //   products[index].isFavorite =
                      //       !products[index].isFavorite;
                      // });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${product.price}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Spacer(),

              FaIcon(
                FontAwesomeIcons.solidStar,
                size: 13,
                color: const Color(0xFFFFD369),
              ),

              SizedBox(width: 4),
              Text(
                product.rating.toStringAsFixed(1),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
