import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: "Demo",
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      home: const HomePage(),
    )
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _email; // Late = "There's no value yet but there will be before I use it."
  late final TextEditingController _password;

  @override
  void initState() { // Initial state of the variables
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
  @override
  void dispose() { // Cleaning the memory
    _email.dispose();
    _password.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        ),
        body: FutureBuilder( // FutureBuilder is a function that has the widgets under 'builder' and a 'future'
                            // In this case we want Firebase.initializeApp to happen before the screen is loaded, and once the 'future' is complete
                            // then the function 'builds' the application visually
          future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,),
          builder: (context, snapshot) { // This is pretty much "Loading" part of the process where we set up the backend
          switch (snapshot.connectionState){
            case ConnectionState.done:{
              return Column(
            children: [
              TextField(controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Enter your email here"
              ),
              ),
              TextField(
              controller: _password,
              obscureText: true, // Password text field
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: "Enter your password here",
              ),
              ),
              TextButton(
              onPressed: () async{
                final email = _email.text; // Grabbing the inputs from the textfields
                final password = _password.text;
                final userCred =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email, 
                  password: password);
                  print(userCred);
              },
              child: const Text("register"),
              ),
            ],
          );
            } // ConnectionState.done:
            default:
            return const Text("Loading");
           } // Switch
          }, //Builder
        ),
    );
  }
}