import 'package:flutter/material.dart';
import 'package:fmd_app/models/place_search.dart';
import 'package:fmd_app/services/geolocator_service.dart';
import 'package:fmd_app/services/places_service.dart';
import 'package:geolocator/geolocator.dart';
import '../services/places_service.dart';

class ApplicationBloc with ChangeNotifier {
  final geolocatorService = GeolocatorService();
  final placesService = PlacesService();
  //variables
  late Position currentLocation ;
  late List<PlaceSearch> searchResults;

  ApplicationBloc() {
    
      Geolocator.requestPermission();
      setCurrentLocation();
    
  }
  // Future<Position> setCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   permission = await Geolocator.requestPermission();

  //   if (permission == LocationPermission.denied) {
  //     return Future.error('Location permissions are denied');
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   print(position);

  //   currentLocation = await Geolocator.getCurrentPosition();
  //   notifyListeners();
  //   throw false;
  // }

  setCurrentLocation() async {
    
      currentLocation = await geolocatorService.getCurrentLocation();
      notifyListeners();
   
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutoComplete(searchTerm);
    notifyListeners();
  }
}
