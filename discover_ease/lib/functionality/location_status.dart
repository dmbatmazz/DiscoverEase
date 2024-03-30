import 'package:geolocator/geolocator.dart';

// Permission.location.request(); Requests permission for location access

class LocationService{
  
  Future<bool> serviceStatus() async {
  bool serviceEnabled;
  serviceEnabled = await Geolocator.isLocationServiceEnabled(); // Checks if Location/GPS enabled on the phone
  if (!serviceEnabled) {
    // GPS/Location Services are disabled on the phone
    // System will automatically ask user to enable it
    return false;
  }
  return true;
}
  
  Future<Position> userCurrentPosition() async{ // Gets users current position as Longitude and Latitude. 
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  var user_latitude = position.latitude;
  var user_longitude = position.longitude;
  //TODO   Turn this into LocationData that Google Maps Widget can use easily
  return position;
}
}

