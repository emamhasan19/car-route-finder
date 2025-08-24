import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/logger/log.dart';
import '../../../../data/models/route_result.dart';

class RouteCalculator {
  RouteCalculator({required this.apiKey})
    : polylinePoints = PolylinePoints.enhanced(apiKey);
  final PolylinePoints polylinePoints;
  final String apiKey;

  Future<RouteResult?> calculateShortestRoute(
    LatLng origin,
    LatLng destination,
  ) async {
    try {
      // Get enhanced route with traffic-aware routing
      RoutesApiResponse response = await polylinePoints
          .getRouteBetweenCoordinatesV2(
            request: RequestConverter.createEnhancedRequest(
              origin: PointLatLng(origin.latitude, origin.longitude),
              destination: PointLatLng(
                destination.latitude,
                destination.longitude,
              ),
              travelMode: TravelMode.driving,
              routingPreference: RoutingPreference.trafficAware,
              alternatives: true, // Get multiple route options
              extraComputations: [
                ExtraComputation.fuelConsumption,
                ExtraComputation.tolls,
              ],
            ),
          );

      if (response.routes.isEmpty) {
        Log.error('No routes found: ${response.errorMessage}');
        return null;
      }

      // Find the optimal route based on duration and distance
      Route bestRoute = _findOptimalRoute(response.routes);

      // Convert polyline points to LatLng coordinates
      List<LatLng> polylineCoordinates = [];
      if (bestRoute.polylinePoints != null) {
        polylineCoordinates = bestRoute.polylinePoints!
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      }

      return RouteResult(
        route: bestRoute,
        polylineCoordinates: polylineCoordinates,
        duration: Duration(seconds: bestRoute.duration ?? 0),
        distanceMeters: bestRoute.distanceMeters,
        distanceText: bestRoute.distanceMeters != null
            ? '${(bestRoute.distanceMeters! / 1000).toStringAsFixed(1)} '
                  '${AppConstants.kilometers}'
            : AppConstants.na,
        durationText: _formatDuration(bestRoute.duration ?? 0),
        totalRoutes: response.routes.length,
      );
    } catch (e) {
      Log.error('Error calculating route: $e');
      return null;
    }
  }

  Route _findOptimalRoute(List<Route> routes) {
    if (routes.isEmpty) throw Exception(AppConstants.noRoutesAvailable);
    if (routes.length == 1) return routes.first;

    Route bestRoute = routes.first;
    double bestScore = double.infinity;

    for (Route route in routes) {
      double score = _calculateRouteScore(route);
      if (score < bestScore) {
        bestScore = score;
        bestRoute = route;
      }
    }

    return bestRoute;
  }

  // Calculate route score based on duration and distance
  // Lower score = better route
  double _calculateRouteScore(Route route) {
    if (route.duration == null || route.distanceMeters == null) {
      return double.infinity;
    }

    // Convert duration to minutes for scoring
    double durationMinutes = route.duration! / 60.0;
    double distanceKm = route.distanceMeters! / 1000.0;

    // Weighted scoring: prioritize duration over distance
    // You can adjust these weights based on your preferences
    double durationWeight = 0.7; // 70% weight for duration
    double distanceWeight = 0.3; // 30% weight for distance

    // Normalize values (you might want to adjust these base values)
    double normalizedDuration = durationMinutes / 60.0; // Normalize to hours
    double normalizedDistance = distanceKm / 100.0; // Normalize to 100km chunks

    return (normalizedDuration * durationWeight) +
        (normalizedDistance * distanceWeight);
  }

  String _formatDuration(int seconds) {
    if (seconds <= 0) return '0m';

    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m';
    } else {
      return '${remainingSeconds}s';
    }
  }

  Future<List<RouteResult>> getAllRouteOptions(
    LatLng origin,
    LatLng destination,
  ) async {
    try {
      RoutesApiResponse response = await polylinePoints
          .getRouteBetweenCoordinatesV2(
            request: RequestConverter.createEnhancedRequest(
              origin: PointLatLng(origin.latitude, origin.longitude),
              destination: PointLatLng(
                destination.latitude,
                destination.longitude,
              ),
              alternatives: true,
              travelMode: TravelMode.driving,
              routingPreference: RoutingPreference.trafficAware,
            ),
          );

      if (response.routes.isEmpty) return [];

      List<RouteResult> results = [];
      for (int i = 0; i < response.routes.length; i++) {
        Route route = response.routes[i];

        List<LatLng> polylineCoordinates = [];
        if (route.polylinePoints != null) {
          polylineCoordinates = route.polylinePoints!
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();
        }

        results.add(
          RouteResult(
            route: route,
            polylineCoordinates: polylineCoordinates,
            duration: Duration(seconds: route.duration ?? 0),
            distanceMeters: route.distanceMeters,
            distanceText: route.distanceMeters != null
                ? '${(route.distanceMeters! / 1000).toStringAsFixed(1)} km'
                : AppConstants.na,
            durationText: _formatDuration(route.duration ?? 0),
            totalRoutes: response.routes.length,
            routeIndex: i,
            routeScore: _calculateRouteScore(route),
          ),
        );
      }

      // Sort by score (best routes first)
      results.sort((a, b) => a.routeScore.compareTo(b.routeScore));
      return results;
    } catch (e) {
      Log.error('Error getting route options: $e');
      return [];
    }
  }
}
