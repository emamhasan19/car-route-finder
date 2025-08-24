import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/app_constants.dart';

class MapUtils {
  static CameraPosition getDefaultCameraPosition() {
    return const CameraPosition(
      target: LatLng(
        AppConstants.defaultLatitude,
        AppConstants.defaultLongitude,
      ),
      zoom: AppConstants.defaultZoom,
    );
  }

  static CameraPosition getCurrentLocationCameraPosition(LatLng position) {
    return CameraPosition(
      target: position,
      zoom: AppConstants.currentLocationZoom,
    );
  }

  static Marker createMarker({
    required String id,
    required LatLng position,
    required bool isOrigin,
  }) {
    return Marker(
      markerId: MarkerId(id),
      position: position,
      infoWindow: InfoWindow(
        title: isOrigin ? AppConstants.origin : AppConstants.destination,
        snippet:
            '${position.latitude.toStringAsFixed(4)}, '
            '${position.longitude.toStringAsFixed(4)}',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        isOrigin ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed,
      ),
    );
  }

  static Polyline createRoutePolyline(List<LatLng> coordinates) {
    return Polyline(
      polylineId: const PolylineId('route'),
      points: coordinates,
      color: Colors.blue,
      width: AppConstants.routePolylineWidth,
    );
  }

  static LatLngBounds calculateBounds(List<LatLng> coordinates) {
    if (coordinates.isEmpty) {
      return LatLngBounds(
        southwest: const LatLng(
          AppConstants.defaultLatitude,
          AppConstants.defaultLongitude,
        ),
        northeast: const LatLng(
          AppConstants.defaultLatitude,
          AppConstants.defaultLongitude,
        ),
      );
    }

    double minLat = coordinates.first.latitude;
    double maxLat = coordinates.first.latitude;
    double minLng = coordinates.first.longitude;
    double maxLng = coordinates.first.longitude;

    for (final coord in coordinates) {
      if (coord.latitude < minLat) minLat = coord.latitude;
      if (coord.latitude > maxLat) maxLat = coord.latitude;
      if (coord.longitude < minLng) minLng = coord.longitude;
      if (coord.longitude > maxLng) maxLng = coord.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }
}
