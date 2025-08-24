import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteResult {
  RouteResult({
    required this.route,
    required this.polylineCoordinates,
    required this.duration,
    required this.distanceMeters,
    required this.distanceText,
    required this.durationText,
    required this.totalRoutes,
    this.routeIndex = 0,
    this.routeScore = 0.0,
  });
  final Route route;
  final List<LatLng> polylineCoordinates;
  final Duration? duration;
  final int? distanceMeters;
  final String distanceText;
  final String durationText;
  final int totalRoutes;
  final int routeIndex;
  final double routeScore;

  double get distanceInKm =>
      distanceMeters != null ? distanceMeters! / 1000.0 : 0.0;
  double get durationInMinutes => duration?.inMinutes.toDouble() ?? 0.0;
  double get durationInHours =>
      duration != null ? duration!.inMinutes / 60.0 : 0.0;

  bool get isOptimal => routeIndex == 0;

  String get routeQuality {
    if (routeScore < 1.0) return 'Excellent';
    if (routeScore < 2.0) return 'Good';
    if (routeScore < 3.0) return 'Fair';
    return 'Poor';
  }

  @override
  String toString() {
    return 'RouteResult(distance: $distanceText, duration: $durationText, '
        'score: ${routeScore.toStringAsFixed(2)}, quality: $routeQuality)';
  }
}
