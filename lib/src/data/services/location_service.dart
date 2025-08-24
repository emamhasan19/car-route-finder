import 'package:location/location.dart' hide PermissionStatus;
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  final Location _location = Location();

  Future<bool> hasLocationPermission() async {
    final permission = await Permission.location.status;
    final result = permission.isGranted || permission.isLimited;
    return result;
  }

  Future<bool> requestLocationPermission() async {
    try {
      // Use location package's permission request for proper Android dialog
      final hasPermission = await _location.hasPermission();

      if (PermissionStatus.granted == hasPermission ||
          PermissionStatus.limited == hasPermission) {
        return true;
      }

      // Request permission using location package
      final permissionStatus = await _location.requestPermission();

      final result =
          permissionStatus == PermissionStatus.granted ||
          permissionStatus == PermissionStatus.limited;
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isLocationServiceEnabled() async {
    return _location.serviceEnabled();
  }

  Future<bool> requestLocationService() async {
    return _location.requestService();
  }

  Future<LocationData?> getCurrentLocation() async {
    try {
      if (await hasLocationPermission()) {
        // Check if location service is enabled
        final serviceEnabled = await isLocationServiceEnabled();

        if (!serviceEnabled) {
          // Request to enable location service
          final serviceRequested = await requestLocationService();
          if (!serviceRequested) {
            return null;
          }
        }

        final locationData = await _location.getLocation();

        return locationData;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> isLocationAvailable() async {
    final hasPermission = await hasLocationPermission();
    final serviceEnabled = await isLocationServiceEnabled();
    return hasPermission && serviceEnabled;
  }

  Future<bool> isPermissionPermanentlyDenied() async {
    final status = await Permission.location.status;
    return status.isPermanentlyDenied;
  }

  Future<bool> isPermissionDenied() async {
    final status = await Permission.location.status;
    return status.isDenied;
  }

  Future<bool> isPermissionLimited() async {
    final status = await Permission.location.status;
    final result = status.isLimited;
    return result;
  }
}
