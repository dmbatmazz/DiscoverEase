import 'package:flutter/material.dart';
import 'package:discover_ease/pages/entry_page.dart';
import 'package:discover_ease/pages/onboarding_page.dart';
import 'package:discover_ease/testpage.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// DEFINING routes: {[PAGE NAME]} ON MaterialApp => routes: {'/homepage': (context) => const PAGENAME()}


// TO GET THE HEX LIKE THIS -> https://imagecolorpicker.com/en
// #febd97 == 0xFFfebd97 ---- SO ALWAYS ADD 0xFF and then the value after #
Color top = const Color(0xFFfebd97);
Color midTop = const Color(0xFFfeece2);
Color midBot = const Color(0xFFf7ddd0);
Color bot = const Color(0xFFe1bfb3);

void main() async{
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Testing text"),
        //backgroundColor: Colors.brown[700],
        centerTitle: true,
      ),
      body: const Home(),

      bottomNavigationBar: const GNav(
        backgroundColor: Color(0xFFfebd97),
        color: Color(0xFFf7ddd0),
        activeColor:  Color(0xFFfeece2),
        tabBackgroundColor: Color.fromARGB(255, 63, 60, 60),
        padding: EdgeInsets.all(16),
        gap: 5,
        curve: Easing.standardAccelerate,
      tabs:[
        GButton(icon: Icons.home,
        text: "Home",
        ),
        GButton(icon: Icons.favorite,
        text: "Likes",),
        GButton(icon: Icons.search,
        text: "Search",),
        GButton(icon: Icons.settings,
        text: "Settings",),
      ]
      ),
    )
  )
  );
}


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: []);
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              child: const Text("Onboarding Page"),
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const OnboardingPage())
                );
              },
            ),
            ElevatedButton(
              child: const Text("Register page"),
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const EnteryPage())
                );
              },
            ),
            ElevatedButton(
              child: const Text("Profile"),
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const Profile())
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
