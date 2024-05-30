import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:discover_ease/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const DiscoverEase());
}

class DiscoverEase extends StatelessWidget {
  const DiscoverEase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: EntryPage(),
    );
  }
}

class EntryPage extends StatelessWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/city/city15.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  color: Colors.white,
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200],
                          ),
                          child: TabBar(
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black54,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.teal,
                            ),
                            tabs: [
                              Tab(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: const Text('Login'),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: const Text('Register'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 350,
                          child: TabBarView(
                            children: [
                              LoginCard(),
                              SignupCard(),
                            ].map((Widget widget) {
                              return SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: widget,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginCard extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginCard({Key? key});

  void handleLogin(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Kullanıcının adını al
      String fullName = userCredential.user?.displayName ?? "Full Name";

      // Giriş başarılı olduğunda kullanıcı bilgilerini sakla
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      prefs.setString('full_name', fullName);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Profile()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              suffixIcon: const Icon(Icons.visibility_off),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Switch(value: true, onChanged: (bool? value) {}),
                  const Text('Remember Me'),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () => handleLogin(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
              ),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () {
                  DefaultTabController.of(context)?.animateTo(1);
                },
                child: const Text('Register now'),
              ),
            ],
          ),
        ],
    );
  }
}

class SignupCard extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  SignupCard({Key? key});

  void handleSignup(BuildContext context) async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Kayıt işlemi başarılı olduğunda kullanıcı bilgilerini sakla
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('full_name', name); // Tam adı kaydet
        prefs.setString('email', email); // E-posta adresini kaydet

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup Successful!')),
        );

        // Kayıt işlemi tamamlandıktan sonra profile sayfasına git
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign up: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Full Name',
              prefixIcon: const Icon(Icons.person),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              suffixIcon: const Icon(Icons.visibility_off),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: const Icon(Icons.lock),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              suffixIcon: const Icon(Icons.visibility_off),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () => handleSignup(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
              ),
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
