import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:discover_ease/screens/home_screen.dart';
import 'package:discover_ease/screens/profile_screen.dart';
import 'package:discover_ease/screens/trip_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:discover_ease/pages/google_mapspage.dart'; // Google Maps sayfasını içe aktarın

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

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
          MaterialPageRoute(builder: (context) =>  HomePage()),
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
          MaterialPageRoute(builder: (context) => const GoogleMaps()), // Google Map sayfasına yönlendirin
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
        // İşlevsiz dünya sembolü
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Color.fromARGB(255, 42, 140, 122),
      backgroundColor: const Color.fromARGB(255, 224, 226, 209),
      buttonBackgroundColor: Colors.transparent,
      index: 0,
      onTap: _onItemTapped,
      items: [
        _buildNavItem(Icons.home_outlined, 0),
        _buildNavItem(Icons.card_travel, 1),
        _buildNavItem(Icons.public, 2, isLarge: true), // Dünya simgesini büyük yapmak için isLarge parametresini true olarak ayarlayalım
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
            size: isLarge ? 40.0 : 30.0, // İkon boyutunu isLarge parametresine göre ayarlayalım
          ),
          if (_selectedIndex == index)
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              height: 6.0,
              width: 6.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 52, 106, 94),
              ),
            ),
        ],
      ),
      label: '',
    );
  }
}

/* !!!NAVBAR AMA TASARIMI DEĞİŞMELİ!!!
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
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
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.green,
      onTap: onTap,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(color: Colors.white),
      unselectedLabelStyle: TextStyle(color: Colors.grey),
      selectedIconTheme: IconThemeData(color: Colors.white),
      unselectedIconTheme: IconThemeData(color: Colors.grey),
    );
  }
}
*/
