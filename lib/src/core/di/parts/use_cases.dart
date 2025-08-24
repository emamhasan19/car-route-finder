part of '../dependency_injection.dart';

@riverpod
CheckLocationPermissionUseCase checkLocationPermissionUseCase(Ref ref) {
  final repository = ref.read(locationRepositoryProvider);
  return CheckLocationPermissionUseCase(repository);
}

@riverpod
RequestLocationPermissionUseCase requestLocationPermissionUseCase(Ref ref) {
  final repository = ref.read(locationRepositoryProvider);
  return RequestLocationPermissionUseCase(repository);
}

@riverpod
CheckLocationServiceUseCase checkLocationServiceUseCase(Ref ref) {
  final repository = ref.read(locationRepositoryProvider);
  return CheckLocationServiceUseCase(repository);
}

@riverpod
RequestLocationServiceUseCase requestLocationServiceUseCase(Ref ref) {
  final repository = ref.read(locationRepositoryProvider);
  return RequestLocationServiceUseCase(repository);
}

@riverpod
GetCurrentLocationUseCase getCurrentLocationUseCase(Ref ref) {
  final repository = ref.read(locationRepositoryProvider);
  return GetCurrentLocationUseCase(repository);
}

@riverpod
CheckLocationAvailabilityUseCase checkLocationAvailabilityUseCase(Ref ref) {
  final repository = ref.read(locationRepositoryProvider);
  return CheckLocationAvailabilityUseCase(repository);
}

@riverpod
GetPermissionStatusUseCase getPermissionStatusUseCase(Ref ref) {
  final repository = ref.read(locationRepositoryProvider);
  return GetPermissionStatusUseCase(repository);
}

@riverpod
CalculateRouteUseCase calculateRouteUseCase(Ref ref) {
  final repository = ref.read(mapRepositoryProvider);
  return CalculateRouteUseCase(repository);
}

@riverpod
GetRouteInfoUseCase getRouteInfoUseCase(Ref ref) {
  final repository = ref.read(mapRepositoryProvider);
  return GetRouteInfoUseCase(repository);
}
