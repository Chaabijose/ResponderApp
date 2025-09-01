import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationUtils {
  /// Data *********************************************************************
  static const LatLng fallbackLocation = LatLng(30.0459751, 31.2242988); // cairo tower

  /// Methods ******************************************************************
  static Future<LatLng?> getCurrentLatLng() async {
    try {
      final location = Location();

      // Directly get location without asking for permission here
      final locationData = await location.getLocation();

      if (locationData.latitude != null && locationData.longitude != null) {
        return LatLng(locationData.latitude!, locationData.longitude!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
