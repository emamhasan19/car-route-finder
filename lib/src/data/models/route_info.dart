import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteInfo {
  const RouteInfo({
    required this.distance,
    required this.duration,
    required this.origin,
    required this.destination,
  });
  final double distance;
  final int duration;
  final LatLng origin;
  final LatLng destination;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RouteInfo &&
        other.distance == distance &&
        other.duration == duration &&
        other.origin == origin &&
        other.destination == destination;
  }

  @override
  int get hashCode {
    return Object.hash(distance, duration, origin, destination);
  }

  @override
  String toString() {
    return 'RouteInfo(distance: $distance, duration: $duration, origin: $origin, destination: $destination)';
  }
}
