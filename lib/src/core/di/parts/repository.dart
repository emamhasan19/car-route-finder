part of '../dependency_injection.dart';

@riverpod
LocationRepository locationRepository(Ref ref) {
  return LocationRepositoryImpl(
    locationService: ref.read(locationServiceProvider),
  );
}

@riverpod
MapRepository mapRepository(Ref ref) {
  return MapRepositoryImpl();
}
