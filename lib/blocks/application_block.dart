import 'package:flutter/material.dart';
import 'package:fmd_app/models/place_search.dart';
import 'package:fmd_app/services/geolocator_service.dart';
import 'package:fmd_app/services/places_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/places_service.dart';

class ApplicationBloc with ChangeNotifier {
  final geolocatorService = GeolocatorService();
  final lastKnownlocation = Geolocator();
  final placesService = PlacesService();
  //variables
  late Position currentLocation;
  late List<PlaceSearch> searchResults;

  ApplicationBloc() {
    setCurrentLocation();
  }

  // setCurrentLocation() async {
  //   bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

  //   await Geolocator.checkPermission();
  //   await Geolocator.requestPermission();

  //   Future<void> requestPermission() async {
  //     await Permission.location.request();
  //   }

  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   currentLocation = position;
  //   LatLng latLngPosition = LatLng(position.latitude, position.longitude);

  //   notifyListeners();
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
