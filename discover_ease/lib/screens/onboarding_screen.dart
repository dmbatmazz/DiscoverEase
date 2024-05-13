import 'package:discover_ease/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.black,
        scrollPhysics: const BouncingScrollPhysics(),
        pages: [
          
          PageViewModel(
          titleWidget: const Text("Title Here", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          body: "Descriptions here",
          image: Image.asset("assets/city/city18.jpg", height: 400, width: 400,),
        ),

        PageViewModel(
          titleWidget: const Text("Title Here", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          body: "Descriptions here",
          image: Image.asset("assets/city/city18.jpg", height: 400, width: 400,),
        ),

        PageViewModel(
          titleWidget: const Text("Title Here", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          body: "Descriptions here",
          image: Image.asset("assets/city/city18.jpg", height: 400, width: 400,),
        ),
        ],
        onDone: (){
          Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context)=>const HomePage(),// TODO CHANGE TO SIGNIN SCREEN
                          )
                          );
        },
        onSkip: (){
          Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context)=>const HomePage(),
                          )
                          );
        },
        showSkipButton: true,
        skip: const Text("Skip", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.pink),),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.purple),),
        next: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.blueAccent,),
        dotsDecorator: DotsDecorator(size: const Size.square(10), activeSize: const Size(20, 10), color: Colors.black, activeColor: Colors.deepOrangeAccent, spacing: const EdgeInsets.symmetric(horizontal: 3), activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
        
      ),
    );
  }
}