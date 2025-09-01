import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responder_app/base/base_repository.dart';
import 'package:responder_app/theme/app_images.dart';
import '../utils/location_utils.dart';
import '../utils/permissions_utils.dart';
import 'base_controller.dart';

abstract class BaseGoogleMapController<R extends BaseRepository> extends BaseController<R> {
  /// Data #####################################################################
  static const String apiKey = 'AIzaSyDEoH6fPfYEsYVv-XVTxUH-qKcmA8AAWos';
  static const String unitMarkerId = 'current_location';
  final String mapWidgetId = 'map_view_id';
  final double zoomLevel = 15;
  GoogleMapController? mapController;
  LatLng? unitLocation;
  final Set<Marker> markers = {};

  /// Lifecycle Methods ########################################################
  @override
  onCreate() async{
    _loadUnitLocation();
  }
  /// Helper Methods ###########################################################
  Future<void> _loadUnitLocation()async{
    if(await PermissionsUtils.checkAndRequestLocationPermission()){
      unitLocation = await LocationUtils.getCurrentLatLng();
    }else{
      unitLocation = LocationUtils.fallbackLocation;
    }
    update([mapWidgetId]);
  }

  void onMapReady(GoogleMapController controller) {
    mapController = controller;
    _addUnitMarker();
    _animateCameraToUnitLocation();
  }

  void _animateCameraToUnitLocation() {
    if (unitLocation != null) {
      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(unitLocation!, zoomLevel),
      );
    }
  }

  Future<void> _addUnitMarker() async {
    final BitmapDescriptor customIcon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(48, 48)), AppImages.ambulance);
    markers.add(
      Marker(
        markerId: const MarkerId(unitMarkerId),
        position: unitLocation ?? LocationUtils.fallbackLocation, // Example position
        icon: customIcon,
      ),
    );
    update([mapWidgetId]);
  }

}