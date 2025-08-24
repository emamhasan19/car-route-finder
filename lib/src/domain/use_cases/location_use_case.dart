import '../../core/base/result.dart';
import '../entities/location_entity.dart';
import '../repositories/location_repository.dart';

final class CheckLocationPermissionUseCase {
  CheckLocationPermissionUseCase(this.repository);

  final LocationRepository repository;

  Future<LocationPermissionEntity> call() async {
    return repository.checkLocationPermission();
  }
}

final class RequestLocationPermissionUseCase {
  RequestLocationPermissionUseCase(this.repository);

  final LocationRepository repository;

  Future<bool> call() async {
    return repository.requestLocationPermission();
  }
}

final class CheckLocationServiceUseCase {
  CheckLocationServiceUseCase(this.repository);

  final LocationRepository repository;

  Future<LocationServiceEntity> call() async {
    return repository.checkLocationService();
  }
}

final class RequestLocationServiceUseCase {
  RequestLocationServiceUseCase(this.repository);

  final LocationRepository repository;

  Future<bool> call() async {
    return repository.requestLocationService();
  }
}

final class GetCurrentLocationUseCase {
  GetCurrentLocationUseCase(this.repository);

  final LocationRepository repository;

  Future<Result<CurrentLocationEntity>> call() async {
    return repository.getCurrentLocation();
  }
}

final class CheckLocationAvailabilityUseCase {
  CheckLocationAvailabilityUseCase(this.repository);

  final LocationRepository repository;

  Future<LocationAvailabilityEntity> call() async {
    return repository.checkLocationAvailability();
  }
}

final class GetPermissionStatusUseCase {
  GetPermissionStatusUseCase(this.repository);

  final LocationRepository repository;

  Future<bool> call() async {
    return repository.getPermissionStatus();
  }
}
