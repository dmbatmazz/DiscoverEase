import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Trips',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor:Color.fromARGB(255, 205, 251, 242),
      unselectedItemColor: Colors.white,
      backgroundColor: Color.fromARGB(255, 42, 140, 122),
      onTap: onTap,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 205, 251, 242)),
      unselectedLabelStyle: const TextStyle(color: Colors.white),
      selectedIconTheme: const IconThemeData(color:Color.fromARGB(255, 205, 251, 242)),
      unselectedIconTheme: const IconThemeData(color: Colors.white),
    );
  }
}