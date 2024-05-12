import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class PostBottomNavBaar extends StatelessWidget {
  const PostBottomNavBaar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/2.5,
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      decoration: const BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),

        )
      ),
      child: ListView(
        children:  [
          Padding(
            padding: const EdgeInsets.only(),
            child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("City Name, Country", style: TextStyle(color: Colors.white60,fontSize: 23, fontWeight: FontWeight.w600),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 25,),
                        Text("4.5", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.black)),
                        //Icon(Icons.star, color: Colors.amber,),
                        //Icon(Icons.star, color: Colors.amber,),
                        ],
                        )
                  ],
                ),
                const SizedBox(height: 25,),
                const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", 
                style: TextStyle(color: Colors.black, fontSize: 16), textAlign: TextAlign.justify,),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5,),
                      child: Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset("assets/city/city4.jpg", fit: BoxFit.cover, width: 120, height: 90,),
                        )
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5,),
                      child: Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset("assets/city/city5.jpg", fit: BoxFit.cover, width: 120, height: 90,),
                        )
                        ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 90,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(image: AssetImage("assets/city/city1.jpg"),fit: BoxFit.cover, opacity: 0.4)
                        ),
                        child: const Text("10+", style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w600),),
                      )
                      )
                    ],
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      Container(
                        //alignment: Alignment,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color.fromARGB(255, 245, 153, 153)),
                        child: const Text("Book Now", style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.w400),),
                      )
                    ],
                    ),
                )
                ],
                ),
            )
          ],
      ),
    );
  }
}