import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:discover_ease/widgets/home_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(preferredSize: Size.fromHeight(90.0), child: HomeAppBar(),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(children: [Expanded(
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  width: 160,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    //city1.jpg
                    image: DecorationImage(image: AssetImage("assets/city/city${index+1}.jps"))
                  ),
                ),
              );
            })
            )),
          ],
          ),
    ),
    )
    );
  }
}