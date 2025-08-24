import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/base/result.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../services/location_service.dart';

final class LocationRepositoryImpl extends LocationRepository {
  LocationRepositoryImpl({required this.locationService});

  final LocationService locationService;

  @override
  Future<LocationPermissionEntity> checkLocationPermission() async {
    final hasPermission = await locationService.hasLocationPermission();
    final isPermanentlyDenied = await locationService
        .isPermissionPermanentlyDenied();
    final isLimited = await locationService.isPermissionLimited();

    return LocationPermissionEntity(
      isGranted: hasPermission,
      isPermanentlyDenied: isPermanentlyDenied,
      isLimited: isLimited,
    );
  }

  @override
  Future<bool> requestLocationPermission() async {
    return locationService.requestLocationPermission();
  }

  @override
  Future<LocationServiceEntity> checkLocationService() async {
    final isEnabled = await locationService.isLocationServiceEnabled();

    return LocationServiceEntity(isEnabled: isEnabled);
  }

  @override
  Future<bool> requestLocationService() async {
    return locationService.requestLocationService();
  }

  @override
  Future<Result<CurrentLocationEntity>> getCurrentLocation() async {
    final locationData = await locationService.getCurrentLocation();

    if (locationData != null) {
      final position = LatLng(locationData.latitude!, locationData.longitude!);

      final result = Result.success(
        CurrentLocationEntity(position: position, isAvailable: true),
      );
      return result;
    } else {
      return const Result.success(
        CurrentLocationEntity(position: LatLng(0, 0), isAvailable: false),
      );
    }
  }

  @override
  Future<LocationAvailabilityEntity> checkLocationAvailability() async {
    final hasPermission = await locationService.hasLocationPermission();

    final serviceEnabled = await locationService.isLocationServiceEnabled();

    final isAvailable = await locationService.isLocationAvailable();

    final result = LocationAvailabilityEntity(
      hasPermission: hasPermission,
      serviceEnabled: serviceEnabled,
      isAvailable: isAvailable,
    );

    return result;
  }

  @override
  Future<bool> getPermissionStatus() async {
    return locationService.hasLocationPermission();
  }
}
