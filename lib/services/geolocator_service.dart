import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: false,
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    // wrap in try catch
  }
}
