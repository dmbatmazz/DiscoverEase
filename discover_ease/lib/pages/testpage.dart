import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Testing Page", style: TextStyle(color: Colors.white70,
          ),
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: const TestPage(),
    ),
  ));
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.pink[600],
            child: elevatedButton2,
          )
          ),
          Expanded(child: Container(
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [elevatedButton0, elevatedButton1],
            ),
          )
          )
      ],
    );
  }
}


Widget elevatedButton0 = ElevatedButton(
  
  onPressed: () {
    Permission.location.request();
  },
  child: const Text('Ask for permission'),
);


Widget elevatedButton1 =  ElevatedButton( 

  onPressed: () {
      try{
        _determinePosition();
      }catch(e){
        print(e);
      }
    /*try{
      _determinePosition();
    }catch(e){
      // Handle all exceptions (permission denied, GPS disabled, etc.)
      if (kDebugMode) {
        print("Error getting location: $e");
      }
    }*/

  },
  child: const Text('Elevated Button1'),
);

Widget elevatedButton2 = ElevatedButton(
  
  onPressed: () {
    
  },
  child: const Text('Elevated Button2'),
);

Future<Position> _determinePosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  LocationPermission permission = await Geolocator.requestPermission();
  if (!serviceEnabled){
    if (permission == LocationPermission.denied) {
      // User denied permission, throw an exception
      return Future.error("Permission Denied");
  }else if(permission == LocationPermission.always ||
           permission == LocationPermission.whileInUse){
           serviceEnabled = await Geolocator.isLocationServiceEnabled(); // Makes it TRUE
           return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
           }
}
  return Future.error("Permission Denied"); //TODO If the permission is denied it crashes needs a way to properly handle the error
}