import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/base/base.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/logger/log.dart';
import '../../../../data/models/route_result.dart';
import '../../../../domain/entities/location_entity.dart';
import '../../../../domain/use_cases/location_use_case.dart';
import '../../../../domain/use_cases/map_use_case.dart';
import '../utils/map_utils.dart';
import 'map_state.dart';

part 'map_provider.g.dart';

@riverpod
class MapNotifier extends _$MapNotifier {
  late final CheckLocationPermissionUseCase _checkLocationPermissionUseCase;
  late final RequestLocationPermissionUseCase _requestLocationPermissionUseCase;
  late final CheckLocationServiceUseCase _checkLocationServiceUseCase;
  late final RequestLocationServiceUseCase _requestLocationServiceUseCase;
  late final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  late final CheckLocationAvailabilityUseCase _checkLocationAvailabilityUseCase;
  late final CalculateRouteUseCase _calculateRouteUseCase;
  late final GetRouteInfoUseCase _getRouteInfoUseCase;

  GoogleMapController? _mapController;

  @override
  MapState build() {
    _initializeUseCases();
    return MapState(
      cameraPosition: MapUtils.getDefaultCameraPosition(),
      hasLocationPermission: null,
      permissionRequestAttempts: 0,
    );
  }

  void _initializeUseCases() {
    _checkLocationPermissionUseCase = ref.read(
      checkLocationPermissionUseCaseProvider,
    );
    _requestLocationPermissionUseCase = ref.read(
      requestLocationPermissionUseCaseProvider,
    );
    _checkLocationServiceUseCase = ref.read(
      checkLocationServiceUseCaseProvider,
    );
    _requestLocationServiceUseCase = ref.read(
      requestLocationServiceUseCaseProvider,
    );
    _getCurrentLocationUseCase = ref.read(getCurrentLocationUseCaseProvider);
    _checkLocationAvailabilityUseCase = ref.read(
      checkLocationAvailabilityUseCaseProvider,
    );
    _calculateRouteUseCase = ref.read(calculateRouteUseCaseProvider);
    _getRouteInfoUseCase = ref.read(getRouteInfoUseCaseProvider);
  }

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  GoogleMapController? getMapController() {
    return _mapController;
  }

  void updatePermissionRequestAttempts(int attempts) {
    state = state.copyWith(permissionRequestAttempts: attempts);
  }

  int get permissionRequestAttempts => state.permissionRequestAttempts;

  void incrementPermissionRequestAttempts() {
    state = state.copyWith(
      permissionRequestAttempts: state.permissionRequestAttempts + 1,
    );
  }

  void notifyMapControllerUpdated() {
    state = state.copyWith();
  }

  Future<bool> checkLocationPermission() async {
    try {
      if (!await _ensureLocationServiceEnabled()) {
        return false;
      }

      final permissionEntity = await _checkLocationPermissionUseCase.call();

      if (permissionEntity.isGranted || permissionEntity.isLimited) {
        await _getCurrentLocation();
        _updateLocationPermissionState(true);
        return true;
      }
      _updateLocationPermissionState(false);
      return false;
    } catch (e) {
      Log.error('Error checking location permission: $e');
      _updateLocationPermissionState(false);
      return false;
    }
  }

  Future<bool> recheckLocationPermission() async {
    try {
      final serviceEntity = await _checkLocationServiceUseCase.call();
      if (!serviceEntity.isEnabled) {
        _updateLocationPermissionState(false);
        return false;
      }

      final permissionEntity = await _checkLocationPermissionUseCase.call();

      if (permissionEntity.isGranted || permissionEntity.isLimited) {
        await _getCurrentLocation();
        _updateLocationPermissionState(true);
        return true;
      } else {
        _updateLocationPermissionState(false);
        return false;
      }
    } catch (e) {
      Log.error('Error rechecking location permission: $e');
      _updateLocationPermissionState(false);
      return false;
    }
  }

  Future<bool> _ensureLocationServiceEnabled() async {
    final serviceEntity = await _checkLocationServiceUseCase.call();
    if (serviceEntity.isEnabled) return true;

    return _requestLocationServiceUseCase.call();
  }

  void _updateLocationPermissionState(bool hasPermission) {
    state = state.copyWith(hasLocationPermission: hasPermission);
  }

  Future<void> _getCurrentLocation() async {
    try {
      final availabilityEntity = await _checkLocationAvailabilityUseCase.call();

      if (!availabilityEntity.isAvailable) {
        _setDefaultCameraPosition();
        return;
      }

      final result = await _getCurrentLocationUseCase.call();

      result.when(
        success: (locationEntity) {
          if (locationEntity.isAvailable) {
            _updateCurrentLocation(locationEntity.position);
          } else {
            _setDefaultCameraPosition();
          }
        },
        failure: (error) {
          Log.error('Failed to get current location: $error');
          _setDefaultCameraPosition();
        },
      );
    } catch (e) {
      Log.error('Error getting current location: $e');
      _setDefaultCameraPosition();
    }
  }

  void _updateCurrentLocation(LatLng position) {
    final cameraPosition = MapUtils.getCurrentLocationCameraPosition(position);

    state = state.copyWith(
      currentLocation: position,
      cameraPosition: cameraPosition,
    );

    _animateCameraToPosition(cameraPosition);
  }

  void _setDefaultCameraPosition() {
    final defaultPosition = MapUtils.getDefaultCameraPosition();
    state = state.copyWith(cameraPosition: defaultPosition);
  }

  void _animateCameraToPosition(CameraPosition position) {
    if (_mapController != null) {
      _mapController?.animateCamera(CameraUpdate.newCameraPosition(position));
    }
  }

  void onMapTap(LatLng position) {
    final currentState = state;
    final markers = List<Marker>.from(currentState.markers);

    if (markers.length < AppConstants.maxMarkers) {
      final markerId = 'point_${markers.length + 1}';
      final isOrigin = markers.isEmpty;

      final newMarker = MapUtils.createMarker(
        id: markerId,
        position: position,
        isOrigin: isOrigin,
      );

      markers.add(newMarker);
      state = currentState.copyWith(markers: markers);
    }
  }

  void findRoute() {
    final currentState = state;
    if (currentState.markers.length == AppConstants.maxMarkers) {
      _calculateRoute(
        currentState.markers[0].position,
        currentState.markers[1].position,
      );
    }
  }

  Future<void> _calculateRoute(LatLng origin, LatLng destination) async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await _calculateRouteUseCase.call(
        origin: origin,
        destination: destination,
      );

      result.when(
        success: (routeResult) {
          _handleRouteCalculationSuccess(routeResult, origin, destination);
        },
        failure: (error) {
          _handleRouteCalculationFailure(error);
        },
      );
    } catch (e) {
      _handleRouteCalculationFailure(e.toString());
    }
  }

  void _handleRouteCalculationSuccess(
    RouteResult routeResult,
    LatLng origin,
    LatLng destination,
  ) {
    final polyline = MapUtils.createRoutePolyline(
      routeResult.polylineCoordinates,
    );

    final routeInfo = _getRouteInfoUseCase.call(
      origin: origin,
      destination: destination,
      distance: routeResult.distanceInKm,
      duration: routeResult.durationInMinutes.toInt(),
    );

    state = state.copyWith(
      polylines: [polyline],
      routeInfo: routeInfo,
      isLoading: false,
    );

    _fitRouteInView(routeResult.polylineCoordinates);
  }

  void _handleRouteCalculationFailure(dynamic error) {
    state = state.copyWith(isLoading: false);
    Log.error('Route calculation failed: $error');
  }

  Future<void> _fitRouteInView(List<LatLng> coordinates) async {
    if (_mapController == null || coordinates.isEmpty) {
      return;
    }

    try {
      final bounds = MapUtils.calculateBounds(coordinates);

      await _mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, AppConstants.routeBoundsPadding),
      );
    } catch (e) {
      Log.error('Error fitting route in view: $e');
    }
  }

  void clearRoute() {
    state = state.copyWith(
      markers: [],
      clearRouteInfo: true,
      polylines: [],
      isLoading: false,
    );
  }

  void forceMapInitialization() async {
    try {
      if (state.hasLocationPermission == true) {
        await _getCurrentLocation();
      } else {
        state = state.copyWith(
          cameraPosition: MapUtils.getDefaultCameraPosition(),
        );
      }
    } catch (e) {
      Log.error('Error in forceMapInitialization: $e');
      state = state.copyWith(
        cameraPosition: MapUtils.getDefaultCameraPosition(),
      );
    }
  }

  Future<void> handleAppResume() async {
    try {
      final availabilityEntity = await _checkLocationAvailabilityUseCase.call();

      if (availabilityEntity.isAvailable) {
        _updateLocationPermissionState(true);

        if (state.currentLocation == null) {
          await _getCurrentLocation();
        }

        _ensureValidCameraPosition();
      } else {
        _updateLocationPermissionState(false);
      }
    } catch (e) {
      Log.error('Error handling app resume: $e');
      _updateLocationPermissionState(false);
    }
  }

  void _ensureValidCameraPosition() async {
    if (state.cameraPosition == null) {
      if (state.currentLocation != null) {
        state = state.copyWith(
          cameraPosition: MapUtils.getCurrentLocationCameraPosition(
            state.currentLocation!,
          ),
        );
      } else {
        forceMapInitialization();
      }
    }
  }

  Future<void> handleLocationServiceEnabled() async {
    try {
      final permissionEntity = await _checkLocationPermissionUseCase.call();

      if (permissionEntity.isGranted || permissionEntity.isLimited) {
        await _getCurrentLocation();
        _updateLocationPermissionState(true);
      } else {
        final granted = await _requestLocationPermissionUseCase.call();
        if (granted) {
          await _getCurrentLocation();
          _updateLocationPermissionState(true);
        } else {
          _updateLocationPermissionState(false);
        }
      }
    } catch (e) {
      Log.error('Error handling location service enabled: $e');
      _updateLocationPermissionState(false);
    }
  }

  Future<bool> isLocationServiceEnabled() async {
    try {
      final serviceEntity = await _checkLocationServiceUseCase.call();
      return serviceEntity.isEnabled;
    } catch (e) {
      Log.error('Error checking location service: $e');
      return false;
    }
  }

  Future<bool> requestLocationService() async {
    try {
      return await _requestLocationServiceUseCase.call();
    } catch (e) {
      Log.error('Error requesting location service: $e');
      return false;
    }
  }

  Future<bool> requestLocationPermission() async {
    try {
      final granted = await _requestLocationPermissionUseCase.call();

      if (granted) {
        await _getCurrentLocation();
        _updateLocationPermissionState(true);
        return true;
      } else {
        final permissionEntity = await _checkLocationPermissionUseCase.call();
        if (permissionEntity.isLimited) {
          await _getCurrentLocation();
          _updateLocationPermissionState(true);
          return true;
        }
        _updateLocationPermissionState(false);
        return false;
      }
    } catch (e) {
      Log.error('Error requesting location permission: $e');
      _updateLocationPermissionState(false);
      return false;
    }
  }

  Future<LocationPermissionEntity> getPermissionDetails() async {
    try {
      return await _checkLocationPermissionUseCase.call();
    } catch (e) {
      Log.error('Error getting permission details: $e');
      return const LocationPermissionEntity(
        isGranted: false,
        isPermanentlyDenied: false,
        isLimited: false,
      );
    }
  }
}
