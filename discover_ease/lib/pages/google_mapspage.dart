// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
// GOOGLE MAPS WIDGET
class MapWidget extends StatefulWidget {
  const MapWidget({super.key});
  
  @override
  State<MapWidget> createState() => _MapWidgetState();
}
class _MapWidgetState extends State<MapWidget> { // Google Maps view Widget
    
  @override
  void initState() {
    
    
    super.initState();
    Permission.location.request();
  }
  
    // Must get the users current position
  static const LatLng targetDestination = LatLng(39.824684484754435, 32.72376542456045); 
  @override
  Widget build(BuildContext context) {
    double _latitude = 0.0;
    double _longitude = 0.0;
    getcurrentlocation().then((position) {
                  setState(() {
                    _latitude  = position.latitude;
                    _longitude = position.longitude;
                    print('$_latitude $_longitude');
                  });
                 });
    LatLng initPos = LatLng(_latitude, _longitude);
    return Scaffold(
      appBar: AppBar(), // FOR DEBUGGING REMOVE LATER
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initPos,
          zoom: 15
        ),
        markers: {
           Marker(
            markerId: const MarkerId("current"),
            icon: BitmapDescriptor.defaultMarker,
            position: initPos
            ),
            
            const Marker(
            markerId: MarkerId("destination"),
            icon: BitmapDescriptor.defaultMarker,
            position: targetDestination
            )
        },
      ),
    );
  }

  Future<Position> getcurrentlocation() async{
  LocationPermission perm = await Geolocator.checkPermission(); // CHECKS FOR LOCATION PERMISSION
  bool isLocationEnabled = await Geolocator.isLocationServiceEnabled(); // CHECKS IF GPS SERVICE ENABLED ON THE PHONE
  //print(isLocationEnabled);

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
      return await Geolocator.getCurrentPosition();
    case LocationPermission.always:
      return await Geolocator.getCurrentPosition();
  }
    return await Future.error("error");
  }
}