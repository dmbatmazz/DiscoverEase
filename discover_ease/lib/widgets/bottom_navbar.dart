import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
      return AnimatedBottomNavigationBar(
      barColor: Colors.white,
      controller: FloatingBottomBarController(initialIndex: 1),
      bottomBar: [
        BottomBarItem(
          icon: const Icon(Icons.home, size: 10),
          iconSelected: const Icon(Icons.home, color: Colors.amber, size: 10),
          title: "Home",
          dotColor: Colors.pink,
          onTap: (value) {},
        ),
        BottomBarItem(
          icon: const Icon(Icons.home, size: 10),
          iconSelected: const Icon(Icons.home, color: Colors.blueAccent, size: 10),
          title: "Home",
          dotColor: Colors.cyan,
          onTap: (value) {},
        ),
        BottomBarItem(
          icon: const Icon(Icons.home, size: 10),
          iconSelected: const Icon(Icons.home, color: Colors.deepOrangeAccent, size: 10),
          title: "Home",
          dotColor: Colors.black,
          onTap: (value) {},
        ),
        BottomBarItem(
          icon: const Icon(Icons.home, size: 10),
          iconSelected: const Icon(Icons.home, color: Colors.purple, size: 10),
          title: "Home",
          dotColor: Colors.black,
          onTap: (value) {},
        ),
      ],
      bottomBarCenterModel: BottomBarCenterModel(
        centerBackgroundColor: Colors.green,
        centerIcon: const FloatingCenterButton(
          child: Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
        centerIconChild: [
          FloatingCenterButtonChild(
            child: const Icon(
              Icons.home,
              color: AppColors.white,
            ),
            onTap: () {},
          ),
          FloatingCenterButtonChild(
            child: const Icon(
              Icons.access_alarm,
              color: AppColors.white,
            ),
            onTap: () {},
          ),
          FloatingCenterButtonChild(
            child: const Icon(
              Icons.ac_unit_outlined,
              color: AppColors.white,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}