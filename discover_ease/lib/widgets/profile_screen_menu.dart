import 'package:discover_ease/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

            ElevatedButton(onPressed: (){
              Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context)=>const EditProfileScreen(),
                          )
                          );
            }, 
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent)),
              child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                   Icon(Icons.settings, color: Colors.white,),
                   Text("Settings - WORKS", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
                   Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,)
              ],
            ),
            ),
            ElevatedButton(onPressed: (){}, 
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent)),
              child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                   Icon(Icons.settings, color: Colors.white,),
                   Text("add more I guess", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
                   Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,)
              ],
            ),
            ),
               SizedBox(height: 60,),
               SizedBox(width: 120, child: ElevatedButton(onPressed: (){}, child: const Text("Logout"))),

      ],
    );
  }
}