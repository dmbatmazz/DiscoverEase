import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:discover_ease/pages/google_mapspage.dart';
import 'package:discover_ease/screens/home_screen.dart';
import 'package:discover_ease/pages/entry_page.dart';
import 'package:discover_ease/screens/onboarding_screen.dart';
import 'package:discover_ease/testpage.dart';
import 'package:flutter/services.dart';
import 'package:discover_ease/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:discover_ease/functionality/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// DEFINING routes: {[PAGE NAME]} ON MaterialApp => routes: {'/homepage': (context) => const PAGENAME()}

// TO GET THE HEX LIKE THIS -> https://imagecolorpicker.com/en
// #febd97 == 0xFFfebd97 ---- SO ALWAYS ADD 0xFF and then the value after #
Color top = const Color(0xFFfebd97);
Color midTop = const Color(0xFFfeece2);
Color midBot = const Color(0xFFf7ddd0);
Color bot = const Color(0xFFe1bfb3);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(
    child: MaterialApp(
      title: "DiscoverEase",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFfebd97),
          brightness: Brightness.light,
          //Override
          primary: Colors.red[200],
          secondary: Colors.green[200],
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 224, 226, 209),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Home(),
      ),
    ),
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.top]);
    return Column(
      children: [
        const SizedBox(height: 50,),
        Row(
          children: [
            ElevatedButton(
              child: const Text("Onboarding Page"),
              onPressed: () {
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => const OnboardingScreen())
                );
              },
            ),
            ElevatedButton(
              child: const Text("Register page"),
              onPressed: () {
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => const EntryPage())
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
        Row(
          children: [
            ElevatedButton(
              child: const Text("Google Maps"),
              onPressed: () {
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => const GoogleMaps())
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
        Row(
          children: [
            ElevatedButton(
              child: const Text("New Home page"),
              onPressed: () {
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => const HomePage())
                );
              },
            ),
          ]
        )
      ],
    );
  }
}
