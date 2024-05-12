import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
      return CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.pink,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined),
            label: 'Main',),
            CurvedNavigationBarItem(
            child: Icon(Icons.card_travel),
            label: 'Trip',),
            CurvedNavigationBarItem(
            child: Icon(Icons.search, color:  Colors.amber),
            label: 'Search',),
            CurvedNavigationBarItem(
            child: Icon(Icons.person),
            label: 'Profile',),
            CurvedNavigationBarItem(
            child: Icon(Icons.person),
            label: 'Profile',),
        ],
      );
  }
}