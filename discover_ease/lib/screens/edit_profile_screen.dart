import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:discover_ease/widgets/bottom_navbar.dart';

class EditProfileScreen extends StatefulWidget {
  final Function(String) onUpdateProfileImage; // Profil resminin güncellendiğinde kullanılacak fonksiyon

  const EditProfileScreen({Key? key, required this.onUpdateProfileImage}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _selectedImage = "assets/profile_images/im1.png"; // Default profile image
  String _username = "@username";
  String _fullName = "username@gmail.com";
  String _birthYear = "08.08.1998"; // Default birth year

  final List<String> _imageList = [
    "assets/profile_images/im1.png",
    "assets/profile_images/im2.png",
    //"assets/profile_images/im3.png",
    //"assets/profile_images/im4.png",
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
      _username = prefs.getString('username') ?? "";
      _fullName = prefs.getString('full_name') ?? "";
      _birthYear = prefs.getString('birth_year') ?? "08.08.1998";
    });
  }

  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('profile_image', _selectedImage);
    prefs.setString('username', _username);
    prefs.setString('full_name', _fullName);
    prefs.setString('birth_year', _birthYear);

    widget.onUpdateProfileImage(_selectedImage); // Yeni profil resmini güncelle
    _showSnackBar(context); // Snackbar göster
    Navigator.of(context).pop(); // Kaydet düğmesine basıldıktan sonra sayfadan çık
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
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 203, 224, 234),
      body: SingleChildScrollView(
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
              style: TextStyle(fontSize: 20),
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
              initialValue: _username,
              decoration: InputDecoration(labelText: 'Username'),
              onChanged: (value) {
                setState(() {
                  _username = value;
                });
              },
            ),
            TextFormField(
              initialValue: _fullName,
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _fullName = value;
                });
              },
            ),
            TextFormField(
              initialValue: _birthYear,
              decoration: InputDecoration(labelText: 'Birth Year (DD.MM.YYYY)'),
              onChanged: (value) {
                if (value.length == 10) { // Check if the input length is exactly 10 characters
                  setState(() {
                    _birthYear = value;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfileData,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(), // Tab menüsü ekle
    );
  }
}
