import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  static const LatLng initPos = LatLng(39.816139251599274, 32.7219522517209); // Must get the users current position
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initPos,
          zoom: 15
        ),
      ),
    );
  }
}