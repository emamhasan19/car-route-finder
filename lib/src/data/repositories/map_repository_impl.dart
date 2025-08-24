import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/base/result.dart';
import '../../domain/repositories/map_repository.dart';
import '../../presentation/features/map/widgets/route_calculator.dart';
import '../models/route_info.dart';
import '../models/route_result.dart';
import '../services/api_key_service.dart';

final class MapRepositoryImpl extends MapRepository {
  MapRepositoryImpl();

  @override
  Future<Result<RouteResult>> calculateRoute({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      // Get API key from native configuration
      final apiKey = await ApiKeyService.getGoogleMapsApiKey();

      // Create RouteCalculator instance
      final routeCalculator = RouteCalculator(apiKey: apiKey);

      // Calculate route using RouteCalculator
      final result = await routeCalculator.calculateShortestRoute(
        origin,
        destination,
      );

      if (result != null) {
        return Result.success(result);
      } else {
        throw Exception('No route found');
      }
    } catch (e) {
      throw Exception('Failed to calculate route: $e');
    }
  }

  @override
  RouteInfo createRouteInfo({
    required LatLng origin,
    required LatLng destination,
    required double distance,
    required int duration,
  }) {
    return RouteInfo(
      origin: origin,
      destination: destination,
      distance: distance,
      duration: duration,
    );
  }
}
