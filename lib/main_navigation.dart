import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technical_assignment/features/product/presentation/pages/HomePage.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    Text('Index 1: Business', style: optionStyle),
    Text('Index 2: School', style: optionStyle),
    Text('Index 2: School', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_currentIndex)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Color.fromARGB(255, 201, 201, 201),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          // backgroundColor: Colors.black,
          showUnselectedLabels: false,
          selectedItemColor: Color(0xFF222831),
          selectedIconTheme: IconThemeData(color: Color(0xFFFFD369),),
          unselectedItemColor: Color(0xFF222831),
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          currentIndex: _currentIndex,
          onTap: (index) {
            _onItemTapped(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house),
              activeIcon: FaIcon(FontAwesomeIcons.solidHouse),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
              activeIcon: FaIcon(FontAwesomeIcons.magnifyingGlass),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: const FaIcon(FontAwesomeIcons.heart),
              activeIcon: const FaIcon(FontAwesomeIcons.solidHeart),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: const FaIcon(FontAwesomeIcons.user),
              activeIcon: const FaIcon(FontAwesomeIcons.solidUser),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:technical_assignment/features/storeShop/presentation/pages/HomePage.dart';

// class MainNavigationScreen extends StatefulWidget {
//   const MainNavigationScreen({super.key});

//   @override
//   State<MainNavigationScreen> createState() => _MainNavigationScreenState();
// }

// class _MainNavigationScreenState extends State<MainNavigationScreen> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     Homepage(),
//     Scaffold(body: Center(child: Text('Index 1: Business'))),
//     Scaffold(body: Center(child: Text('Index 2: School'))),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           _pages[_selectedIndex],
//           Positioned(
//             left: 20,
//             right: 20,
//             bottom: 20,
//             child: Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Color(0xFF222831),
//                 borderRadius: BorderRadius.circular(40),
//                 boxShadow: const [
//                   BoxShadow(
//                     blurRadius: 10,
//                     color: Color.fromARGB(255, 201, 201, 201),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                        FaIcon(
//                         FontAwesomeIcons.house,
//                         color: _selectedIndex == 0
//                           ? Color(0xFFFFD369)
//                           : Colors.white,
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         'Home',
//                         style: TextStyle(
//                           color: _selectedIndex == 0
//                           ? Color(0xFFFFD369)
//                           : Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                   IconButton(
//                     icon: const FaIcon(
//                       FontAwesomeIcons.house,
//                       color: Color(0xFFFFD369),
//                     ),
//                     onPressed: () => _onItemTapped(0),
//                   ),

//                   IconButton(
//                     icon: const FaIcon(
//                       FontAwesomeIcons.heart,
//                       color: Color(0xFFFFD369),
//                     ),
//                     onPressed: () => _onItemTapped(1),
//                   ),

//                   IconButton(
//                     icon: const FaIcon(
//                       FontAwesomeIcons.user,
//                       color: Color(0xFFFFD369),
//                     ),
//                     onPressed: () => _onItemTapped(2),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
