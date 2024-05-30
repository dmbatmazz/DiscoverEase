import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:discover_ease/screens/home_screen.dart';
import 'package:discover_ease/screens/post_screen.dart';
import 'package:discover_ease/screens/profile_screen.dart';
import 'package:discover_ease/screens/search_screen.dart';
import 'package:discover_ease/screens/trip_plan_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
      return CurvedNavigationBar(
       
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.pink,
        index: 0,
        onTap: (value) {
         Navigator.push(context,
              switch(value) {
                0=> MaterialPageRoute(builder: (context)=>const HomePage()),
                1=> MaterialPageRoute(builder: (context)=> TripPlanPage()),
                2=> MaterialPageRoute(builder: (context)=>const SearchScreen()),
                3=> MaterialPageRoute(builder: (context)=>const PostScreen()),
                4=> MaterialPageRoute(builder: (context)=>const Profile()),
                
                // TODO: Handle this case.
                int() => throw UnimplementedError(),
              }
          );
        },
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined),
            label: 'Main',
            ),
            CurvedNavigationBarItem(
            child: Icon(Icons.card_travel),
            label: 'Trip',),
            CurvedNavigationBarItem(
            child: Icon(Icons.search, color:  Colors.amber),
            label: 'Search',),
            CurvedNavigationBarItem(
            child: Icon(Icons.person),
            label: 'Dont know',),
            CurvedNavigationBarItem(
            child: Icon(Icons.person),
            label: 'Profile',),
        ],
         
      );
  }
}