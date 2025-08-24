import '../../core/base/repository.dart';
import '../../core/base/result.dart';
import '../entities/location_entity.dart';

abstract base class LocationRepository extends Repository {
  /// Check current location permission status
  Future<LocationPermissionEntity> checkLocationPermission();

  /// Request location permission
  Future<bool> requestLocationPermission();

  /// Check if location service is enabled
  Future<LocationServiceEntity> checkLocationService();

  /// Request to enable location service
  Future<bool> requestLocationService();

  /// Get current location
  Future<Result<CurrentLocationEntity>> getCurrentLocation();

  /// Check overall location availability
  Future<LocationAvailabilityEntity> checkLocationAvailability();

  /// Get permission status
  Future<bool> getPermissionStatus();
}
