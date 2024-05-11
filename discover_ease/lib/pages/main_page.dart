import 'package:discover_ease/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<IconData> _icons = [
    FontAwesomeIcons.plane,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.person,
    FontAwesomeIcons.bicycle,
  ];

Widget _buildIcon(int index){
  return GestureDetector(
    onTap: () {
      setState(() {
        _selectedIndex = index;
        // TODO
        // CHANGE THE SCREEN ACCORDINGLY TO WHAT IS SELECTED DEPENDING ON THE INDEX
      });
    },
    child: Container(
    height: 60.0, 
    width: 60.0,
    decoration: BoxDecoration(  
    color: _selectedIndex == index? Theme.of(context).colorScheme.secondary : Colors.brown, // BACKGROUND OF THE ICON , SELECTED : NOT-SELECTED
    borderRadius: BorderRadius.circular(30.0), // BUBBLE AROUND THE ICON
    ),
    child: Icon(
      _icons[index],
      size: 25.0, // SIZE OF THE ICON
      color: _selectedIndex == index? Theme.of(context).colorScheme.primary : Colors.white70// ICONS COLOR, SELECTED : NOT-SELECTED
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // DEBUGGING REMOVE LATER
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text("What would you like to find", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _icons.asMap().entries.map((MapEntry map) => _buildIcon(map.key)).toList()
            ),
            const SizedBox(height: 20.0,),
            const Destionation()
          ],
        ),
        ),
    );
  }
}

class Destionation extends StatelessWidget {
  const Destionation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Top Destionations", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, letterSpacing: 1.5)
                      ),
                      
                      GestureDetector(
                        onTap: () {
                          
                        }, 
                        child: Text("See all", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0, fontWeight: FontWeight.w600, letterSpacing: 1),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 300,
                color: Colors.red,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10, // TODO  GET THE NUMBER OF THE DESTINATIONS FROM THE API AND USE THAT .LENGHT AS ITEM COUNT
                  
                  itemBuilder: ((context, index) {
                    return const Text("CITY NAMES"); // TODO GET THE CITY NAMES FROM THE API
                  }
                  )

                  )
                ),
              ],
            );
  }
}