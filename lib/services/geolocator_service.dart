import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    try {
      return await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: true,
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      throw Exception(e);
    }
    // wrap in try catch
  }
}
