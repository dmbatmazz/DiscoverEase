import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:discover_ease/widgets/bottom_navbar.dart';
import 'package:discover_ease/screens/home_screen.dart';
import 'package:discover_ease/screens/profile_screen.dart';
import 'package:discover_ease/screens/trip_plan_screen.dart';
import 'package:discover_ease/pages/google_mapspage.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    TripPlanPage(),
    const GoogleMaps(),
    const Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Color.fromARGB(255, 42, 140, 122),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Ankara',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          // Arka plan resmi
          Positioned.fill(
            child: Image.asset(
              "assets/city/profile.png",
              fit: BoxFit.cover,
            ),
          ),
          // Bulanıklık efekti
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  travelBox(
                    'Packing Tips For Travel',
                    Color.fromARGB(255, 42, 140, 122).withOpacity(0.8),
                    [
                      'Make a packing list',
                      'Roll your clothes',
                      'Use packing cubes',
                      'Keep important items in carry-on',
                      'Limit shoes to three pairs',
                      'Use travel-sized toiletries'
                    ],
                  ),
                  SizedBox(height: 15),
                  travelBox(
                    'Things to Consider When Traveling Abroad',
                    Color.fromARGB(255, 42, 140, 122).withOpacity(0.8),
                    [
                      'Check passport validity',
                      'Research visa requirements',
                      'Get travel insurance',
                      'Learn basic phrases of local language',
                      'Keep copies of important documents'
                    ],
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () => _showConfirmationDialog(context, 'https://www.enuygun.com/bilgi/ankara-da-gezilecek-yerler-mutlaka-gorulmesi-gereken-80-yer/'),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.3),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Most Visited',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () => _showConfirmationDialog(context, 'https://www.tripadvisor.com.tr/Restaurants-g298656-Ankara.html'),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.3),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Foods & Drinks',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () => _showConfirmationDialog(context, 'https://www.biletix.com/search/TURKIYE/tr?category_sb=-1&date_sb=-1&city_sb=Ankara#!city_sb:Ankara'),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.3),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Things To Do',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget travelBox(String title, Color color, List<String> content) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), // Arka plan renginde opacity
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          for (var item in content)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text(
                '- $item',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You are about to leave the app'),
          content: Text('Are you sure?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                _launchURL(url);
              },
            ),
          ],
        );
      },
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
