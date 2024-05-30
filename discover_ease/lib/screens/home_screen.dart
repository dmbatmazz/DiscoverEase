import 'package:discover_ease/screens/post_screen.dart';
import 'package:discover_ease/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:discover_ease/widgets/home_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    var category = [
    "Best places",
    "Most Visited",
    "Hotels",
    "Tours",
    "Restaurants",
    "Attractions"
  ];
    return Scaffold(
      appBar: const PreferredSize( preferredSize: Size.fromHeight(90.0), child: HomeAppBar(),),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
              Row(
                children: [
                  Expanded(
                  // ignore: sized_box_for_whitespace
                  child: Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context)=>const PostScreen(),
                          )
                          );
                      },
                      child: Container(
                        width: 160,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(image: AssetImage("assets/city/city${index+3}.jpg"),
                          fit: BoxFit.cover,
                          opacity: 0.7,
                          )
                        ),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              child: const Icon(Icons.bookmark, 
                              color: Colors.white, 
                              size: 30,),
                            ),
                            const Spacer(),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: const Text("City Name", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                            )
                            ],
                        ),
                      ),
                    );
                  })
                  )
                  ),
                ],
              ),
               const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(children: [
                    for(int i = 0; i<category.length ; i++)
                    Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white, 
                                              borderRadius:  BorderRadius.circular(10), 
                                              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)]
                                              ),
                    child:  Text(category[i], 
                                                style: const TextStyle(
                                                fontSize: 15, 
                                                fontWeight: FontWeight.w500),
                     ),
                    )
                  ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder( 
              physics: const NeverScrollableScrollPhysics(),
              itemCount: category.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(padding: const EdgeInsets.all(15),
                child:  Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context)=>const PostScreen(),
                          )
                          );
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(image: AssetImage("assets/city/city${index+1}.jpg"), fit: BoxFit.cover, opacity: 0.8),
                        ),
                        child: const Row(
                          children: [
                            Column(
                                children: [
                                  Spacer(),
                                  Icon(Icons.star, color: Colors.amber,),
                                  Text("4.5", style: TextStyle(fontWeight: FontWeight.w500),)// TODO SHIFT THE ICON TO BOTTOM
                                ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.bookmark_add_outlined,color: Colors.white,), // TODO SHIFT THE ICON TO LEFT
                                  ],
                                ),
                                Spacer(),
                                Text("City name here", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white,)),
                              ],
                            )
                            ],
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 5),
                    ),
                  ],
                ),
                );
              })
            ],
            ),
          ),
    ),
    ),
    bottomNavigationBar:  BottomNavBar(),
    );
  }
}