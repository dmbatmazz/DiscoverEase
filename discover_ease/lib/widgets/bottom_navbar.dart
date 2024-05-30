import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:discover_ease/screens/home_screen.dart';
import 'package:discover_ease/screens/post_screen.dart';
import 'package:discover_ease/screens/profile_screen.dart';
import 'package:discover_ease/screens/trip_plan_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TripPlanPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PostScreen()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
        break;
      case 2:
      default:
        // İşlevsiz dünya sembolü, hiçbir işlem yapmaz.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Color.fromARGB(255, 68, 70, 68),
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: Colors.transparent,
      index: 0,
      onTap: _onItemTapped,
      items: [
        _buildNavItem(Icons.home_outlined, 0),
        _buildNavItem(Icons.card_travel, 1),
        _buildNavItem(Icons.public, 2, isLarge: true),
        _buildNavItem(Icons.post_add, 3),
        _buildNavItem(Icons.person, 4),
      ],
    );
  }

  CurvedNavigationBarItem _buildNavItem(IconData icon, int index, {bool isLarge = false}) {
    return CurvedNavigationBarItem(
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color.fromARGB(255, 249, 249, 249),
            size: isLarge ? 40.0 : 30.0,
          ),
          if (_selectedIndex == index)
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              height: 6.0,
              width: 6.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
        ],
      ),
      label: '',
    );
  }
}
