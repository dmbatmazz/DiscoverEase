import 'package:flutter/material.dart';
import 'package:discover_ease/pages/register_page.dart';
import 'package:discover_ease/pages/onboarding_page.dart';
import 'package:discover_ease/testpage.dart';
// DEFINING routes: {[PAGE NAME]} ON MaterialApp => routes: {'/homepage': (context) => const PAGENAME()}
// 
void main() async{
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Testing text"),
        backgroundColor: Colors.brown[700],
        centerTitle: true,
      ),
      body: const Home(),
      
    )
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
            MaterialPageRoute(builder: (context) => const RegisterPage())
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
      
    );
  }
}
