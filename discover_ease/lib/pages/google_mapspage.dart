import 'dart:async';
import 'package:discover_ease/functionality/auto_complete_result.dart';
import 'package:discover_ease/functionality/map_services.dart';
import 'package:discover_ease/widgets/searchplaces.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends ConsumerStatefulWidget {
  const GoogleMaps({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends ConsumerState<GoogleMaps> {
  final Completer<GoogleMapController> _controller = Completer();

  Timer? _debounce;
  int polylineIdCounter = 1;
  int markerIdCounter = 1;
  Set<Marker> _markers = <Marker>{};
  Set<Polyline> _polylines = <Polyline>{};

  bool searchToggle = false;
  bool radiusSlider = false;
  bool pressedNear = false;
  bool cardTapped = false;
  bool getDirections = false;

  TextEditingController searchController = TextEditingController();
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  void _setPolyLine(List<PointLatLng> points){
    final String polyLineIdVal = 'polyline_$polylineIdCounter';
    polylineIdCounter++;
    _polylines.add(Polyline(
      polylineId: PolylineId(polyLineIdVal),
      width: 2,
      color: Colors.blue,
      points: points.map((e)=> LatLng(e.latitude,e.longitude)).toList()
      ));
  }

  static const CameraPosition _kGooglePlex = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746);
  @override
  Widget build(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  final allSearchResults = ref.watch(placeResultsProvider);
  final searchFlag = ref.watch(searchToggleProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    markers: _markers,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller){
                      _controller.complete(controller);
                    },
                  ),
                ),
                searchToggle?
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 40, 15, 5),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:  Colors.white,
                        ),
                        child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15
                            ),
                            border: InputBorder.none,
                            hintText: 'Search',
                            
                            suffixIcon: IconButton(
                              onPressed: () {setState(() {
                                searchToggle = false;
                                searchController.text = '';
                                _markers = {};
                                searchFlag.toggleSearch();
                              });}, 
                              icon: const Icon(Icons.close),
                              ),
                          ),
                          onChanged: (value) {
                            if(_debounce?.isActive ?? false) {
                              _debounce?.cancel();
                            }
                            _debounce = Timer(
                              const Duration(milliseconds: 700), ()async {
                                if(value.length > 2){
                                  if(!searchFlag.searhToggle){
                                    searchFlag.toggleSearch();
                                    _markers = {};
                                  }
                                  List<AutoCompleteResult> searchResults = await MapServices().searchPlaces(value);
                                  allSearchResults.setResults(searchResults);
                                }
                                else{
                                  List<AutoCompleteResult> emptyList = [];
                                  allSearchResults.setResults(emptyList);
                                }
                              }
                              );
                          },
                        ),
                      )
                    ],
                  ),
                  ): Container(),
                  searchFlag.searhToggle ?
                  allSearchResults.allReturnedResults.isNotEmpty ?
                  Positioned(
                    top: 100,
                    left: 15,
                    child: Container(
                      height: 200,
                      width: screenWidth - 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.7),
                      ),
                      child: ListView(
                        children: [
                          ...allSearchResults.allReturnedResults.map((e) => buildListItem(e, searchFlag))
                        ],
                      ),
                    ),
                  ):
                  Positioned(
                    top: 100,
                    left: 15,
                    child: Container(
                      height: 200,
                      width: screenWidth - 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.7),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            const Text("No results to show", style: TextStyle(fontFamily: 'WorkSans', fontWeight: FontWeight.w200),),
                            const SizedBox(height: 5,),
                            SizedBox(
                              width: 125,
                              child: ElevatedButton(
                                onPressed: (){
                                  searchFlag.toggleSearch();
                                },
                                child: const Center(
                                  child: Text("Close this", style: TextStyle(color: Colors.white,fontFamily: 'WorkSans', fontWeight: FontWeight.w300),
                                  ),
                                )
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                    ): Container(),
                    getDirections? 
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 40, 15, 5),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                            ),
                            child: TextFormField(
                              controller: _originController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                border: InputBorder.none,
                                hintText: "Origin"
                              ),
                            ),
                          ),
                          const SizedBox(height: 3,),
                          
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                            ),
                            child: TextFormField(
                              controller: _destinationController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                border: InputBorder.none,
                                hintText: "Destination",
                                suffixIcon: SizedBox(
                                  width: 96,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () async{
                                          var directions = await MapServices().getDirections(_originController.text, _destinationController.text);
                                          _markers = {};
                                          _polylines = {};
                                          gotoPlace(
                                            directions['start_location']['lat'], 
                                            directions['start_location']['lng'], 
                                            directions['end_location']['lat'], 
                                            directions['end_location']['lng'],
                                            directions["bounds_ne"],
                                            directions["bounds_sw"]
                                            );
                                          _setPolyLine(directions['polyline_decoded']);
                                        }, 
                                        icon: const Icon(Icons.search)
                                        ),
                                        IconButton(
                                        onPressed: () async{
                                          getDirections = false;
                                          _originController.text = '';
                                          _destinationController.text = '';
                                        }, 
                                        icon: const Icon(Icons.close)
                                        ),
                                    ],
                                  ),
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                    ):Container(),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FabCircularMenu(
        alignment: Alignment.bottomLeft,
        fabColor: Colors.blue.shade50,
        fabOpenColor: Colors.red.shade100,
        ringDiameter: 250.0,
        ringWidth: 60.0,
        ringColor: Colors.blue.shade50,
        fabSize: 60.0,
        children: [
          IconButton(
            onPressed: (){
              setState(() {
                searchToggle = true;
                radiusSlider = false;
                pressedNear = false;
                cardTapped = false;
                getDirections = false;
              });
            }, 
            icon: const Icon(Icons.search)
            ),
            IconButton(
            onPressed: (){
              setState(() {
                searchToggle = false;
                radiusSlider = false;
                pressedNear = false;
                cardTapped = false;
                getDirections = true;
              });
            }, 
            icon: const Icon(Icons.navigation)
            ),
        ]
        ),
    );
  }

gotoPlace(double lat, double lng, double endLat, double endLng, Map<String, dynamic> boundsNe, Map<String, dynamic> boundsSw,) async{
  final GoogleMapController controller = await _controller.future;

  controller.animateCamera(
    CameraUpdate.newLatLngBounds(
      LatLngBounds(
        southwest: LatLng(boundsSw['lat'], boundsSw['lng']), 
        northeast: LatLng(boundsNe['lat'], boundsNe['lng'])), 
        25));
  
  _setMarker(LatLng(lat, lng));
  _setMarker(LatLng(endLat, endLng));
}

Future<void> gotoSearchedPlace(double lat, double lng) async{
  final GoogleMapController controller = await _controller.future;

  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, lng), zoom: 12)));
}
// ignore: unused_element
void _setMarker(point){
  var counter  = markerIdCounter++;
  
  final Marker marker = Marker(markerId: MarkerId('marker_$counter'), position: point,
  onTap: (){},
  icon: BitmapDescriptor.defaultMarker
  );
  setState(() {
    _markers.add(marker);
  });
}

  Widget buildListItem(AutoCompleteResult placeItem, searchFlag){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTapDown: (_){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onTap: () async{
          var place = await MapServices().getPlace(placeItem.placeId);
          gotoSearchedPlace(place['geometry']['location']['lat'], place['geometry']['location']['lng']);
          searchFlag.toggleSearch();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, color: Colors.green, size: 25,),
            const SizedBox(width: 4,),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width -75,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(placeItem.description ?? ""),
              )
            )
          ],
        ),
      ),
    );
  }

}