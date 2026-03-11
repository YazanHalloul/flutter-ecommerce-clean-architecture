import 'package:flutter/material.dart';
import 'package:technical_assignment/core/DI/injection.dart';
import 'package:technical_assignment/features/navigation/main_navigation.dart';
// import 'package:technical_assignment/features/storeShop/presentation/pages/HomePage.dart';

void main() {
  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto',
      primaryColor: const Color(0xFFFFD369),
      ),

      home: const MainNavigationScreen(),
    );
  }
}
