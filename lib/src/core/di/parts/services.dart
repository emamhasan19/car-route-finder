part of '../dependency_injection.dart';

@Riverpod(keepAlive: true)
LocationService locationService(Ref ref) {
  return LocationService();
}
