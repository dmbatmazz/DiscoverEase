import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:discover_ease/widgets/bottom_navbar.dart';
import 'package:discover_ease/screens/edit_profile_screen.dart';
import 'package:discover_ease/pages/entry_page.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _profileImage = "assets/profile_images/im1.png";
  String _fullName = "";
  String _email = "";

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _fullName = prefs.getString('full_name') ?? "";
      _email = prefs.getString('email') ?? "";
    });
  }

  void _updateProfileImage(String newImage) {
    setState(() {
      _profileImage = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.dark_mode_outlined, color: Colors.black87),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/city/profile.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    width: 160,
                    height: 160,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image(
                          image: AssetImage(_profileImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _fullName, // Display full name
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.white),
                  ),
                  Text(
                    _email, // Display email
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 30),
                  ProfileMenu(
                    editProfileScreen: EditProfileScreen(
                      onUpdateProfileImage: _updateProfileImage,
                      fullName: _fullName,
                      email: _email,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final Widget editProfileScreen;

  const ProfileMenu({Key? key, required this.editProfileScreen}) : super(key: key);

  void _logout(BuildContext context) async {
    try {
      await Firebase.initializeApp();
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logout Successful!', style: TextStyle(color: Colors.white))),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const EntryPage()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log out: $e', style: TextStyle(color: Colors.white))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0, left: 8.0, right: 8.0), 
      width: double.infinity,
      child: Card(
        color: Colors.white,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _buildProfileButton(
                context,
                icon: Icons.settings,
                label: "Profile Settings",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => editProfileScreen,
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              _buildProfileButton(
                context,
                icon: Icons.star,
                label: "Favorites",
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _buildProfileButton(
                context,
                icon: Icons.info,
                label: "About",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                },
              ),
              const SizedBox(height: 10),
              _buildProfileButton(
                context,
                icon: Icons.logout,
                label: "Log Out",
                onTap: () => _logout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16.0)),
        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.black87),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.black87),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "About",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/city/profile.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "DiscoverEase",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "DiscoverEase, your ultimate travel companion, provides you with personalized recommendations and seamless travel planning tools to ensure an unforgettable journey.",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Our app utilizes advanced AI technology to curate the best travel experiences based on your preferences, making travel planning more efficient and enjoyable.",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "From discovering hidden gems to finding the best local restaurants, DiscoverEase has got you covered. Join us in exploring the world with ease and excitement!",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                          textAlign: TextAlign.center,
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
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
