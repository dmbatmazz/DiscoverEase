import 'package:flutter/material.dart';
/*
ON BOARDING PAGE

IF YOU WANNA CREATE A NEW PAGE OR CHANGE WHAT IS INSIDE IT GO TO LINE - #

IF YOU WANNA CHANGE THE BUTTON OR ANIMATION OR ANYTHING RELATED TO STRUCTURE GO TO LINE - #

IF YOU ARE GOING TO ADD A NEW VALUE AND WTF ELSE NOT, DO NOT FORGET TO ADD THAT VALUE TO EVERYWHERE AND PROPERLY ASSIGN IT ON LINES - #
*/

// UNLESS YOU KNOW EXACTLY WHAT YOU ARE DOING DO NOT TOUCH THIS
// ================================================================
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}


// STRUCTURE OF THE ONBOARDING PAGES
// ================================================================
class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;
  int pageIndex = 0;
  @override
  void initState() { // If you init something dont forget to dispose it. Otherwise Memory Loss
    _pageController = PageController(initialPage: 0);
    super.initState();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 138, 173), // TOP OF THE SCREEN WHERE TIME AND BATTERY ETC IS
      body: SafeArea( // Safe Area = the space of the top of the screen, for the backgroundColor above have to use something opace so that user can still see them
        child:
          Column(
            children: [
              Expanded(
                child: PageView.builder( // Makes a slidable page view you don't really need to touch this at all. 
                itemCount: onBoardPage.length,
                controller: _pageController,
                onPageChanged: (index){
                  setState(() {
                    pageIndex = index;
                  });
                },
                itemBuilder:(context, index) => 
                  OnboardContent( // Skeleton of the page initilized into the structure, Takes the page fron the list and puts it into PageView.build List
                image: onBoardPage[index].image,
                title: onBoardPage[index].title,
                description: onBoardPage[index].description, 
                color: onBoardPage[index].color, // NEEDS A FIX WITH HEX CODES AND WHAT NOT
                ),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // SKIPS THE ON BOARDING PAGE
                    },
                    style:ElevatedButton.styleFrom( // Style of the Button, we can change that once we setup proper UI materials
                      shape: const CircleBorder()
                    ),
                     child: const Text("Skip")
                     ),

                  const Spacer(),

                  ...List.generate(onBoardPage.length, (index) => Padding( // GENERATES A LIST OF DOT. # OF DOTS= # OF PAGES
                  padding: const EdgeInsets.all(3.0), // CAN ADJUST THIS TO PLACE IT PROPERLY
                  child: DotIndigator(isActive: index == pageIndex,),
                  )
                  ),

                  const Spacer(),
                  
                  ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(duration: const Duration(milliseconds: 200), // How long will the animation
                      curve: Curves.ease // ANIMATION OF THE PAGE
                      );
                    },
                    style:ElevatedButton.styleFrom( // Style of the Button, we can change that once we setup proper UI materials
                      shape: const CircleBorder()
                    ),
                     child: const Text("Next")
                     ),
                ],
              )
            ],
          )
        )
    );
  }
}

// SKELETON OF A ONBOARDING PAGE
// ================================================================ 
class OnboardContent extends StatelessWidget { 
   const OnboardContent({
    super.key, 
    required this.image, 
    required this.title, 
    required this.description, 
    required this.color,
  });
  final String image, title, description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 121, 121), /* Colors (color) */
      body: Column(
              children: [
      //const Spacer(),
      Image.asset(image),
      //const Spacer(),
      Text(title,
       style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
      const SizedBox(height: 30,), // Space between title text and description text
      Text(description,
       style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,),
              ],
              ),
    );
  }
}

class DotIndigator extends StatelessWidget {
  const DotIndigator({
    super.key,
    this.isActive = false
  });
final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container( // THE LITTLE SHIT THAT TRACKS THE PAGE
              height: isActive? 12 : 4, // IF ACTIVE 12 ELSE 4 
              width: 4, // HEIGHT AND WIDTH COULD BE CHANGE TO A BETTER EFFECT
              decoration: const BoxDecoration(
              color: Color.fromARGB(255, 144, 255, 255), 
              borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                );
  }
}

// PAGES LIST
// ================================================================
class Onboard{
  final String image, title, description;
  final Color  color;

  Onboard({required this.image, required this.title, required this.description, required this.color});
}
final List<Onboard> onBoardPage = [ // PAGE LIST -- YOU CAN CREATE PAGES FROM HERE
  Onboard(
    image: "assets/asset_images/placeholder_600x800.png",
    title: "1",
    description: "Description", 
    color: const Color.fromARGB(255, 231, 147, 141),
  ),
  Onboard(
    image: "assets/asset_images/placeholder_600x800.png",
    title: "2",
    description: "Description1", 
    color: const Color.fromARGB(255, 231, 147, 141),
  ),
  Onboard(
    image: "assets/asset_images/placeholder_600x800.png",
    title: "3",
    description: "Description", 
    color: const Color.fromARGB(255, 231, 147, 141),
  ),
  Onboard(
    image: "assets/asset_images/placeholder_600x800.png",
    title: "4",
    description: "Description", 
    color: const Color.fromARGB(255, 231, 147, 141),
  ),
  Onboard(
    image: "assets/asset_images/placeholder_600x800.png",
    title: "5",
    description: "Description", 
    color: const Color.fromARGB(255, 231, 147, 141),
  ),

];