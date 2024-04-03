import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';


void main() async{
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Testing text"),
        backgroundColor: Colors.brown[700],
        centerTitle: true,
      ),
      body: const Home(),
      
    )
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      margin: const EdgeInsets.all(50),
      child: const MapWidget(), 
    );
  }
}

// GOOGLE MAPS WIDGET
class MapWidget extends StatefulWidget {
  const MapWidget({super.key});
  
  @override
  State<MapWidget> createState() => _MapWidgetState();
}
class _MapWidgetState extends State<MapWidget> { // Google Maps view Widget
  //final Location _locationController = Location();
  LatLng? currentPosition;

  @override
  void initState() {
    super.initState();
    Permission.location.request();
    //getLocationUpdates();
  }
  static const LatLng initPos = LatLng(39.816139251599274, 32.7219522517209); // Must get the users current position
  static const LatLng targetDestination = LatLng(39.824684484754435, 32.72376542456045); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: initPos,
          zoom: 15
        ),
        markers: {
          const Marker(
            markerId: MarkerId("current"),
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
}