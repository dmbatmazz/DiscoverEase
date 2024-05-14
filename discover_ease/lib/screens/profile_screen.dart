import 'package:discover_ease/widgets/profile_screen_menu.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(isDark? Icons.sunny : Icons.dark_mode_outlined))
        ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(width: 120, height: 120,
                child: ClipRRect(borderRadius: BorderRadius.circular(100), child: const Image(image: AssetImage("assets/goof.png"), fit: BoxFit.cover,))
                ),
                const SizedBox(height: 10),
                const Text("User Name here", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.white),),
                const Text("Possibly email or other little things here", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200, color: Colors.white54)),
                const SizedBox(height: 20),
                SizedBox(width: 120, child: ElevatedButton(onPressed: (){}, child: const Text("Edit Profile"))),
                const SizedBox(height: 30,),
                const Divider(),
                const SizedBox(height: 10,),
                const ProfileMenu(),
                ],
            ),
          ),
        )
    );
  }
}