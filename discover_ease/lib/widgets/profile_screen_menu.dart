import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

            ListTile( 
                  leading: Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: const Icon(Icons.settings, color: Colors.white,),
                  ),
                  title: const Text("Settings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
                  trailing: Container(
                    width: 30, height: 30, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.transparent),
                    child: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                  ),
                ),

            ListTile( 
                  leading: Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: const Icon(Icons.settings, color: Colors.white,),
                  ),
                  title: const Text("Settings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
                  trailing: Container(
                    width: 30, height: 30, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.transparent),
                    child: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                  ),
                ),

            ListTile(
                  leading: Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: const Icon(Icons.settings, color: Colors.white,),
                  ),
                  title: const Text("Settings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
                  trailing: Container(
                    width: 30, height: 30, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.transparent),
                    child: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                  ),
                ),

            ListTile(
                  leading: Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: const Icon(Icons.settings, color: Colors.white,),
                  ),
                  title: const Text("Settings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
                  trailing: Container(
                    width: 30, height: 30, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.transparent),
                    child: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                  ),
                ),

                ListTile(
                  leading: Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: const Icon(Icons.settings, color: Colors.white,),
                  ),
                  title: const Text("Settings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
                  trailing: Container(
                    width: 30, height: 30, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.transparent),
                    child: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),
                  ),
                ),


               SizedBox(height: 60,),
               SizedBox(width: 120, child: ElevatedButton(onPressed: (){}, child: const Text("Logout"))),

      ],
    );
  }
}