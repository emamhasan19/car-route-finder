import 'package:flutter/material.dart';

import '../../../../data/models/route_info.dart';
import 'route_info_card.dart';

class MapOverlay extends StatelessWidget {
  const MapOverlay({super.key, this.routeInfo});

  final RouteInfo? routeInfo;

  @override
  Widget build(BuildContext context) {
    if (routeInfo == null) return const SizedBox.shrink();

    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 20,
      right: 20,
      child: RouteInfoCard(routeInfo: routeInfo!),
    );
  }
}
