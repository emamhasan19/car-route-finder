import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/base/repository.dart';
import '../../core/base/result.dart';
import '../../data/models/route_info.dart';
import '../../data/models/route_result.dart';

abstract base class MapRepository extends Repository {
  Future<Result<RouteResult>> calculateRoute({
    required LatLng origin,
    required LatLng destination,
  });

  RouteInfo createRouteInfo({
    required LatLng origin,
    required LatLng destination,
    required double distance,
    required int duration,
  });
}
