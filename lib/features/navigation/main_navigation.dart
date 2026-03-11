import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technical_assignment/core/DI/injection.dart';
import 'package:technical_assignment/features/navigation/main_navigation_cubit.dart';
import 'package:technical_assignment/features/product/domain/usecases/get_products.dart';
import 'package:technical_assignment/features/product/presentation/cubit/product_cubit.dart';
import 'package:technical_assignment/features/product/presentation/pages/HomePage.dart';
import 'package:technical_assignment/features/product/presentation/pages/ProductShop.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<Widget> _pages = <Widget>[
    Homepage(),
    ProductShop(),
    Text('Index 2'),
    Text('Index 3'),
    Text('Index 4'),
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainNavigationCubit()),
        BlocProvider(
          create: (_) => ProductCubit(getIt<GetProducts>())..fetchProducts(),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<MainNavigationCubit, int>(
          builder: (context, state) {
            return IndexedStack(index: state, children: _pages);
          },
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: Color.fromARGB(255, 201, 201, 201),
              ),
            ],
          ),
          child: BlocBuilder<MainNavigationCubit, int>(
            builder: (context, state) {
              return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                showUnselectedLabels: false,
                selectedItemColor: Color(0xFF222831),
                selectedIconTheme: IconThemeData(color: primaryColor),
                unselectedItemColor: Color(0xFF222831),
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                currentIndex: state,
                onTap: (index) {
                  context.read<MainNavigationCubit>().updateIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.solidHouse),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.shop),
                    label: 'Shop',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.bagShopping),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: const FaIcon(FontAwesomeIcons.solidHeart),
                    label: 'Favorite',
                  ),
                  BottomNavigationBarItem(
                    icon: const FaIcon(FontAwesomeIcons.solidUser),
                    label: 'Profile',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
