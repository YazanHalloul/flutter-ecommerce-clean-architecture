import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technical_assignment/core/network/api_client.dart';
import 'package:technical_assignment/features/product/data/datasources/product_remote_data_source.dart';
import 'package:technical_assignment/features/product/data/repositories/product_repository_impl.dart';
import 'package:technical_assignment/features/product/domain/entities/product_entity.dart';
import 'package:technical_assignment/features/product/domain/repositories/product_repository.dart';
import 'package:technical_assignment/features/product/domain/usecases/get_products.dart';
import 'package:technical_assignment/features/product/presentation/cubit/slider_data.dart';
import 'package:technical_assignment/features/product/presentation/widgets/product_cart.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedCategory = 0;

  final getProducts = GetProducts(
    ProductRepositoryImpl(ProductRemoteDataSourceImpl(ApiClient())),
  );

  List<ProductEntity> products = [];
  Future<void> load() async {
    final p = await getProducts();
    setState(() {
      products = p;
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Explore',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(7.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset('assets/images/profile.jpg', fit: BoxFit.cover),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 20,
                    ),
                onPressed: () {
                  // Navigate to the shopping cart page
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 15),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.6,
                viewportFraction: 0.8,
                // autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: imageSlider.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: double.infinity,
                      // margin: EdgeInsets.symmetric(horizontal: 12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(image, fit: BoxFit.cover),
                      ),
                    );
                  },
                );
              }).toList(),
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
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: FaIcon(
                      FontAwesomeIcons.fire,
                      size: 16,
                      color: Color(0xFFFFD369),
                    ),
                  ),
                  Spacer(),
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
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                padding: const EdgeInsets.all(10.0),
                itemBuilder: (context, index) {
                  return ProductCart(product: products[index]);
                },
                itemCount: products.length,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
