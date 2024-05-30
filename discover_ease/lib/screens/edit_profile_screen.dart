import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:discover_ease/widgets/bottom_navbar.dart';
import 'dart:ui'; 

class EditProfileScreen extends StatefulWidget {
  final Function(String) onUpdateProfileImage; 
  final String fullName;
  final String email;

  const EditProfileScreen({
    Key? key,
    required this.onUpdateProfileImage,
    required this.fullName,
    required this.email,
  }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _selectedImage = "assets/profile_images/im1.png";
  String _birthYear = "08.08.1998"; 

  final List<String> _imageList = [
    "assets/profile_images/im1.png",
    "assets/profile_images/im2.png",
    "assets/profile_images/im5.png",
    "assets/profile_images/im6.png",
    "assets/profile_images/im7.png",
    "assets/profile_images/im8.png",
    "assets/profile_images/im9.png",
    "assets/profile_images/im10.png",
  ];

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedImage = prefs.getString('profile_image') ?? "assets/profile_images/im1.png";
      _birthYear = prefs.getString('birth_year') ?? "08.08.1998";
    });
  }

  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', _selectedImage);
    await prefs.setString('birth_year', _birthYear);

    widget.onUpdateProfileImage(_selectedImage);
    _showSnackBar(context);
    Navigator.of(context).pop();
  }

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Profile updated successfully!', style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings', style: TextStyle(color: Colors.black87)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(_selectedImage),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Choose Your Profile Picture',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: _imageList.map((image) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImage = image;
                          });
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(image),
                          child: _selectedImage == image
                              ? Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: widget.fullName,
                  enabled: false, // Make it uneditable
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                TextFormField(
                  initialValue: widget.email,
                  enabled: false, 
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                TextFormField(
                  initialValue: _birthYear,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Birth Year (DD.MM.YYYY)',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), 
                    ),
                   focusedBorder: UnderlineInputBorder(
                   borderSide: BorderSide(color: Colors.white), 
                   ),
                  ),
                  onChanged: (value) {
                    if (value.length == 10) {
                      setState(() {
                        _birthYear = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: _saveProfileData,
                  style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(43, 192, 192, 192)), // Arka plan rengi
                  overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(15)), // Düğme içeriğinin kenar boşluğu
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Düğme köşelerinin yuvarlaklığı
                  side: BorderSide(color: Colors.transparent), // Kenar rengi
      ),
    ),
  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
