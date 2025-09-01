import 'package:permission_handler/permission_handler.dart';

class PermissionsUtils {

  /// Checks and requests location permission.
  /// Returns `true` if granted, otherwise `false`.
  static Future<bool> checkAndRequestLocationPermission() async {
    // Check current permission status
    var status = await Permission.location.status;

    if (status.isGranted) {
      return true; // Already granted
    }

    if (status.isDenied) {
      // Request permission
      var result = await Permission.location.request();
      return result.isGranted;
    }

    if (status.isPermanentlyDenied) {
      // Open app settings so user can enable it manually
      await openAppSettings();
      return false;
    }

    return false;
  }
}
