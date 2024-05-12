import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration:  BoxDecoration(
              color: Colors.white24,
              //boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 6,)],
              borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.sort_rounded, size: 20,),
          ),
          ),
           const Row(children: [
            Icon(Icons.location_on, color: Colors.pink,),
            Text("GET USER CITY HERE"),
            ],
            ),
        InkWell(onTap: () {},
        child: Container(padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white24,
          //boxShadow: const [BoxShadow(color: Colors.black26,blurRadius: 6)],
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.search, size: 20),
        ),
        )
        ],
      ),
    );
  }
}