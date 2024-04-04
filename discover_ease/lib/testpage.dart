import 'package:discover_ease/main.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("INTRO PAGE"),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text(("go to home")),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),)
                  );
            },
          ),
          ),
    );
  }
}