import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/base/result.dart';
import '../../data/models/route_info.dart';
import '../../data/models/route_result.dart';
import '../repositories/map_repository.dart';

final class CalculateRouteUseCase {
  CalculateRouteUseCase(this.repository);

  final MapRepository repository;

  Future<Result<RouteResult>> call({
    required LatLng origin,
    required LatLng destination,
  }) async {
    return repository.calculateRoute(origin: origin, destination: destination);
  }
}

final class GetRouteInfoUseCase {
  GetRouteInfoUseCase(this.repository);

  final MapRepository repository;

  RouteInfo call({
    required LatLng origin,
    required LatLng destination,
    required double distance,
    required int duration,
  }) {
    return repository.createRouteInfo(
      origin: origin,
      destination: destination,
      distance: distance,
      duration: duration,
    );
  }
}
