import 'dart:ui';
import 'package:discover_ease/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:discover_ease/screens/onboarding_screen.dart';
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
      debugShowCheckedModeBanner: false,
      home: EntryPage(),
    );
  }
}

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/city/entry_page.png"),
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
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              width: 380,
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
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[200],
                        ),
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black54,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 42, 140, 122),
                          ),
                          tabs: [
                            Tab(
                              child: Container(
                                width: 150,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: const Text(
                                  'Login',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                width: 150,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: const Text('Register',
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _tabController,
                        builder: (context, child) {
                          return SizedBox(
                            height: _tabController.index == 0
                                ? 300
                                : 400, // Login sayfası 300, Register sayfası 400
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                SingleChildScrollView(
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: LoginCard(
                                        tabController: _tabController),
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: SignupCard(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginCard extends StatefulWidget {
  final TabController tabController;

  const LoginCard({Key? key, required this.tabController}) : super(key: key);

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  void handleLogin(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
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
        MaterialPageRoute(builder: (context) =>  HomePage()),
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
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
          obscureText: !_passwordVisible,
        ),
        const SizedBox(height: 10),
        const SizedBox(height: 25),
        Center(
          child: ElevatedButton(
            onPressed: () => handleLogin(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 42, 140, 122),
              shadowColor: Colors.black.withOpacity(0.3),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
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
                widget.tabController.animateTo(1);
              },
              child: const Text('Register now!'),
              style: TextButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 42, 140, 122),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SignupCard extends StatefulWidget {
  const SignupCard({Key? key}) : super(key: key);

  @override
  _SignupCardState createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

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
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('full_name', name);
        prefs.setString('email', email);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const OnboardingScreen()), // Burada yönlendirme OnboardingScreen'e yapılıyor
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
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            obscureText: !_passwordVisible,
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
              suffixIcon: IconButton(
                icon: Icon(
                  _confirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _confirmPasswordVisible = !_confirmPasswordVisible;
                  });
                },
              ),
            ),
            obscureText: !_confirmPasswordVisible,
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () => handleSignup(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 42, 140, 122),
                shadowColor: Colors.black.withOpacity(0.2),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
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
