import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
void main() {
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
      //padding: const EdgeInsets.all(50),
      margin: const EdgeInsets.all(50),
      child: const MapWidget(),
    );
  }
}


class MapWidget extends StatefulWidget {
  const MapWidget({super.key});
  
  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Location _locationController = Location();
  LatLng? currentPosition;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
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
  
  
  
  
  
  
  Future<void> getLocationUpdates() async{
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();

    if(serviceEnabled){
      serviceEnabled = await _locationController.requestService();
    }else{
      return;
    }
    permissionGranted = await _locationController.hasPermission();
    if(permissionGranted == PermissionStatus.denied){
      permissionGranted = await _locationController.requestPermission();
      if(permissionGranted != PermissionStatus.granted){
        return;
      }
    }
    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if(currentLocation.latitude  !=null &&
         currentLocation.longitude !=null){
          setState(() {
            currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
            print(currentLocation);
          });
          
         }
    });
  }
}