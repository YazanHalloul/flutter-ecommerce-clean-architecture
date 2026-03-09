import 'package:flutter/material.dart';
import 'package:technical_assignment/features/navigation/main_navigation.dart';
// import 'package:technical_assignment/features/storeShop/presentation/pages/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto'
      ),
      
      home: const MainNavigationScreen(),
    );
  }
}