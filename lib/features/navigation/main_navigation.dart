import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technical_assignment/features/navigation/main_navigation_cubit.dart';
import 'package:technical_assignment/features/product/presentation/pages/HomePage.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<Widget> _pages = <Widget>[
    Homepage(),
    Text('Index 1'),
    Text('Index 2'),
    Text('Index 3'),
    Text('Index 4'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainNavigationCubit(),
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
                selectedIconTheme: IconThemeData(color: Color(0xFFFFD369)),
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
