// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class NearByPlaces extends StatefulWidget {
  const NearByPlaces({super.key});

  @override
  State<NearByPlaces> createState() => _NearByPlacesState();
}

class _NearByPlacesState extends State<NearByPlaces> {

  String apikey = "AIzaSyB1eAs0QhSrXAOUfiLQFmwSSzxW1AvPfiE";
  late String _latitude;
  late String _longitude;
  late String _userlocation;
  bool? isChecked = false;


  String radius = "30";       // Testing values can delete later when im done here
  double lat =  39.816139251599274; 
  double long = 32.7219522517209;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Places"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                onPressed: (){
                  getnearplaces();
                }, 
                child: const Text("Get near places")
                ),
                ElevatedButton(
                onPressed: (){
                 getcurrentlocation().then((position) {
                  setState(() {
                    _latitude  = position.latitude.toString();
                    _longitude = position.longitude.toString();
                    _userlocation = "$_latitude,$_longitude";
                    print('$_latitude $_longitude');
                  });
                 }).catchError((error){
                  // Error handling if there is one even
                  print("Error: $error");
                 });
                }, 
                child: const Text("Get current location")
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Rad"),
                Text("A"),
                Text("B"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [ 
                Checkbox(value: isChecked, onChanged: (value) {
                  setState(() {
                    isChecked = value;
                    radius = "30";
                    print(radius);
                  }
                  );
                },
                ),
                Checkbox(value: isChecked, onChanged: (value) {
                  setState(() {
                    isChecked = value;
                    radius = "60";
                    print(radius);
                  }
                  );
                },
                ),
                Checkbox(value: isChecked, onChanged: (value) {
                  setState(() {
                    isChecked = value;
                    radius = "90";
                    print(radius);
                  }
                  );
                },
                )
                
              ],
            )
          ],
        ),
      ),
    );
  }

void getnearplaces() async{
  
    var request = http.Request('GET', Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=39.816139251599274,32.7219522517209&radius=1500&type=hotel|library&key=AIzaSyB1eAs0QhSrXAOUfiLQFmwSSzxW1AvPfiE'));
      /*'https://maps.googleapis.com/maps/api/place/nearbysearch/json'+
      '?location=' + userLocation + 
      '&radius=' + radius +
      '&type=' + _type +
      '&key=' + apikey)
      );*/
http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print("success");
  print(await response.stream.bytesToString());
}
else {
  print("fail");
  print(response.reasonPhrase);
}

  }

Future<Position> getcurrentlocation() async{
  LocationPermission perm = await Geolocator.checkPermission(); // CHECKS FOR LOCATION PERMISSION
  bool isLocationEnabled = await Geolocator.isLocationServiceEnabled(); // CHECKS IF GPS SERVICE ENABLED ON THE PHONE
  print(isLocationEnabled);

  if(!isLocationEnabled){
    Geolocator.openLocationSettings();
  }

  switch (perm) {
    case LocationPermission.unableToDetermine:
      print('unableToDetermine');
      break;
    case LocationPermission.denied:
      Geolocator.requestPermission();
      print('denied');
      break;
    case LocationPermission.deniedForever:
      print('deniedForever');
      break;
    case LocationPermission.whileInUse:
      //print(await Geolocator.getCurrentPosition());
      return await Geolocator.getCurrentPosition();
    case LocationPermission.always:
      //print(await Geolocator.getCurrentPosition());
      return await Geolocator.getCurrentPosition();
  }
    return await Future.error("error");
  }

}