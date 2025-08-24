import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../data/models/route_info.dart';

class MapState {
  const MapState({
    this.markers = const [],
    this.polylines = const [],
    this.routeInfo,
    this.isLoading = false,
    this.currentLocation,
    this.cameraPosition,
    this.hasLocationPermission, // null = not checked yet
    this.permissionRequestAttempts = 0,
  });

  final List<Marker> markers;
  final List<Polyline> polylines;
  final RouteInfo? routeInfo;
  final bool isLoading;
  final LatLng? currentLocation;
  final CameraPosition? cameraPosition;
  final bool? hasLocationPermission;
  final int permissionRequestAttempts;

  MapState copyWith({
    List<Marker>? markers,
    List<Polyline>? polylines,
    RouteInfo? routeInfo,
    bool clearRouteInfo = false,
    bool? isLoading,
    LatLng? currentLocation,
    CameraPosition? cameraPosition,
    bool? hasLocationPermission,
    int? permissionRequestAttempts,
  }) {
    return MapState(
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      routeInfo: clearRouteInfo ? null : (routeInfo ?? this.routeInfo),
      isLoading: isLoading ?? this.isLoading,
      currentLocation: currentLocation ?? this.currentLocation,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      hasLocationPermission:
          hasLocationPermission ?? this.hasLocationPermission,
      permissionRequestAttempts: permissionRequestAttempts ?? this.permissionRequestAttempts,
    );
  }
}
