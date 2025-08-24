import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class MapControls extends StatelessWidget {
  const MapControls({
    super.key,
    required this.mapController,
    required this.currentLocation,
    required this.hasLocationPermission,
    required this.bottomOffset,
  });

  final GoogleMapController? mapController;
  final LatLng? currentLocation;
  final bool hasLocationPermission;
  final double bottomOffset;

  @override
  Widget build(BuildContext context) {
    if (!hasLocationPermission) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        // Zoom Controls
        Positioned(
          bottom: bottomOffset + 20,
          right: 16,
          child: _buildZoomControls(),
        ),

        // My Location Button
        Positioned(right: 16, top: 20, child: _buildMyLocationButton()),
      ],
    );
  }

  Widget _buildZoomControls() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: AppSpace.radius12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildZoomButton(icon: Icons.add, onTap: _zoomIn, isTop: true),
          Container(height: 1, color: AppColors.white),
          _buildZoomButton(icon: Icons.remove, onTap: _zoomOut, isTop: false),
        ],
      ),
    );
  }

  Widget _buildMyLocationButton() {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: _goToMyLocation,
          borderRadius: AppSpace.radius24,
          child: const Icon(
            Icons.my_location,
            color: AppColors.secondary,
            size: 22,
          ),
        ),
      ),
    );
  }

  Widget _buildZoomButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isTop,
  }) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppSpace.getConditionalRadius(isTop),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Icon(icon, color: AppColors.secondary, size: 22),
        ),
      ),
    );
  }

  Future<void> _zoomIn() async {
    if (mapController != null) {
      await mapController!.animateCamera(CameraUpdate.zoomIn());
    } else {}
  }

  Future<void> _zoomOut() async {
    if (mapController != null) {
      await mapController!.animateCamera(CameraUpdate.zoomOut());
    } else {}
  }

  Future<void> _goToMyLocation() async {
    if (mapController != null && currentLocation != null) {
      await mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(currentLocation!, 16.0),
      );
    } else {}
  }
}
