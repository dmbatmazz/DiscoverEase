import 'package:discover_ease/pages/google_mapspage.dart';
import 'package:discover_ease/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:discover_ease/pages/entry_page.dart';
import 'package:discover_ease/pages/onboarding_page.dart';
import 'package:discover_ease/testpage.dart';
import 'package:flutter/services.dart';
import 'package:discover_ease/pages/profile_page.dart';
import 'package:discover_ease/pages/main_page.dart';
// DEFINING routes: {[PAGE NAME]} ON MaterialApp => routes: {'/homepage': (context) => const PAGENAME()}


// TO GET THE HEX LIKE THIS -> https://imagecolorpicker.com/en
// #febd97 == 0xFFfebd97 ---- SO ALWAYS ADD 0xFF and then the value after #
Color top = const Color(0xFFfebd97);
Color midTop = const Color(0xFFfeece2);
Color midBot = const Color(0xFFf7ddd0);
Color bot = const Color(0xFFe1bfb3);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: "Senior Project",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFfebd97),
        brightness: Brightness.light,

        //Override
        primary: Colors.red[200],
        secondary: Colors.green[200],
        ),
        scaffoldBackgroundColor: Colors.blue[200],
        useMaterial3: true
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Testing text"),
        centerTitle: true,
      ),
      body: const Home(),
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
        Row(children: [
          ElevatedButton(
              child: const Text("Main page"),
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const MainPage())
                );
              },
            ),
            ElevatedButton(
              child: const Text("Google Maps"),
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const MapWidget())
                );
              },
            ),
            ElevatedButton(
              child: const Text("Places-Test"),
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const NearByPlaces())
                );
              },
            ),
            ]
          
        ),
        Row(children: [
          ElevatedButton(
              child: const Text("Places-Test"),
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => const WelcomeScreen())
                );
              },
            ),
        ]
          
        )
      ],
    );
  }
}
