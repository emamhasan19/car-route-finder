import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/logger/log.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/common_loader.dart';
import '../riverpod/map_provider.dart';
import '../widgets/widgets.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> with WidgetsBindingObserver {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkLocationPermission();

    Future.delayed(const Duration(seconds: 2), () async {
      if (mounted) {
        final mapState = ref.read(mapNotifierProvider);
        if (mapState.cameraPosition == null) {
          ref.read(mapNotifierProvider.notifier).forceMapInitialization();
        }
      }
    });

    _listenForPermissionChanges();

    _addSafetyTimeout();
  }

  void _listenForPermissionChanges() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      final mapState = ref.read(mapNotifierProvider);
      if (mapState.hasLocationPermission == false) {
        _checkLocationPermission();
      } else {
        timer.cancel();
      }
    });
  }

  void _addSafetyTimeout() {
    Timer(const Duration(seconds: 10), () {
      if (mounted) {
        final mapState = ref.read(mapNotifierProvider);
        if (mapState.hasLocationPermission == false) {
          ref
              .read(mapNotifierProvider.notifier)
              .updatePermissionRequestAttempts(3);
        }
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          _checkLocationServiceAndPermission();
        }
      });
    }
  }

  Future<void> _checkLocationPermission() async {
    try {
      final serviceEnabled = await ref
          .read(mapNotifierProvider.notifier)
          .isLocationServiceEnabled();

      if (!serviceEnabled) {
        final serviceRequested = await ref
            .read(mapNotifierProvider.notifier)
            .requestLocationService();

        if (serviceRequested && mounted) {
          await _requestAppPermission();
        }
        return;
      }

      final hasPermission = await ref
          .read(mapNotifierProvider.notifier)
          .checkLocationPermission();

      if (hasPermission) {
        final mapState = ref.read(mapNotifierProvider);
        if (mapState.cameraPosition == null) {
          ref.read(mapNotifierProvider.notifier).forceMapInitialization();
        }
      } else {
        await _requestAppPermission();
      }
    } catch (e) {
      Log.error('Error checking location permission: $e');
    }
  }

  Future<void> _requestAppPermission() async {
    try {
      ref
          .read(mapNotifierProvider.notifier)
          .incrementPermissionRequestAttempts();

      if (ref.read(mapNotifierProvider.notifier).permissionRequestAttempts >
          2) {
        ref
            .read(mapNotifierProvider.notifier)
            .updatePermissionRequestAttempts(
              ref.read(mapNotifierProvider.notifier).permissionRequestAttempts,
            );
        return;
      }

      final granted = await ref
          .read(mapNotifierProvider.notifier)
          .requestLocationPermission();

      if (granted) {
        ref
            .read(mapNotifierProvider.notifier)
            .updatePermissionRequestAttempts(0);

        await Future.delayed(const Duration(milliseconds: 1000));

        await ref
            .read(mapNotifierProvider.notifier)
            .recheckLocationPermission();

        await _ensureMapInitialized();
      } else {
        ref
            .read(mapNotifierProvider.notifier)
            .updatePermissionRequestAttempts(
              ref.read(mapNotifierProvider.notifier).permissionRequestAttempts,
            );
      }
    } catch (e) {
      ref
          .read(mapNotifierProvider.notifier)
          .updatePermissionRequestAttempts(
            ref.read(mapNotifierProvider.notifier).permissionRequestAttempts,
          );
    }
  }

  void _resetPermissionRequestCounter() {
    ref.read(mapNotifierProvider.notifier).updatePermissionRequestAttempts(0);
  }

  Future<void> _logPermissionState() async {
    try {
      final permissionEntity = await ref
          .read(mapNotifierProvider.notifier)
          .getPermissionDetails();
    } catch (e) {
      Log.error('Error logging permission state: $e');
    }
  }

  Future<bool> _wasPermissionExplicitlyDenied() async {
    try {
      final permissionEntity = await ref
          .read(mapNotifierProvider.notifier)
          .getPermissionDetails();

      return !permissionEntity.isGranted &&
          !permissionEntity.isLimited &&
          !permissionEntity.isPermanentlyDenied;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _shouldShowPermissionMessage() async {
    try {
      await _logPermissionState();

      if (ref.read(mapNotifierProvider.notifier).permissionRequestAttempts >
          2) {
        return true;
      }

      final serviceEnabled = await ref
          .read(mapNotifierProvider.notifier)
          .isLocationServiceEnabled();

      if (!serviceEnabled) {
        return true;
      }

      final hasPermission = await ref
          .read(mapNotifierProvider.notifier)
          .checkLocationPermission();

      if (hasPermission) {
        return false;
      }

      final wasExplicitlyDenied = await _wasPermissionExplicitlyDenied();

      if (wasExplicitlyDenied) {
        return true;
      }
      final permissionEntity = await ref
          .read(mapNotifierProvider.notifier)
          .getPermissionDetails();

      if (permissionEntity.isPermanentlyDenied ||
          (!permissionEntity.isGranted && !permissionEntity.isLimited)) {
        return true;
      }

      return false;
    } catch (e) {
      return true;
    }
  }

  Future<bool> _needsPermissionRequest() async {
    try {
      await _logPermissionState();

      if (ref.read(mapNotifierProvider.notifier).permissionRequestAttempts >
          2) {
        return false;
      }

      final serviceEnabled = await ref
          .read(mapNotifierProvider.notifier)
          .isLocationServiceEnabled();

      if (!serviceEnabled) {
        return false;
      }

      final hasPermission = await ref
          .read(mapNotifierProvider.notifier)
          .checkLocationPermission();

      if (hasPermission) {
        return false;
      }

      final wasExplicitlyDenied = await _wasPermissionExplicitlyDenied();

      if (wasExplicitlyDenied) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void _handleMapOrMarkerTap(LatLng position) {
    ref.read(mapNotifierProvider.notifier).onMapTap(position);
  }

  GoogleMapController? get _mapControllerFromProvider {
    return ref.read(mapNotifierProvider.notifier).getMapController();
  }

  Future<void> _ensureMapInitialized() async {
    try {
      final mapState = ref.read(mapNotifierProvider);

      if (mapState.hasLocationPermission == true &&
          mapState.cameraPosition == null) {
        ref.read(mapNotifierProvider.notifier).forceMapInitialization();

        await Future.delayed(const Duration(milliseconds: 500));

        await ref
            .read(mapNotifierProvider.notifier)
            .recheckLocationPermission();
      }
    } catch (e) {
      Log.error('Error ensuring map initialization: $e');
    }
  }

  Future<void> _handleGrantPermission() async {
    if (mounted) {
      final granted = await ref
          .read(mapNotifierProvider.notifier)
          .requestLocationPermission();

      await Future.delayed(const Duration(milliseconds: 500));

      final currentPermissionStatus = await ref
          .read(mapNotifierProvider.notifier)
          .checkLocationPermission();

      if (currentPermissionStatus) {
        final permissionEntity = await ref
            .read(mapNotifierProvider.notifier)
            .getPermissionDetails();

        final message = permissionEntity.isLimited
            ? AppConstants.locationPermissionGrantedTemporarily
            : AppConstants.locationPermissionGranted;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        _resetPermissionRequestCounter();

        await Future.delayed(const Duration(milliseconds: 1000));

        await ref
            .read(mapNotifierProvider.notifier)
            .recheckLocationPermission();

        await _ensureMapInitialized();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppConstants.locationPermissionNotGranted),
            backgroundColor: AppColors.error,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Widget _buildPermissionMessage() {
    return FutureBuilder<bool>(
      future: _needsPermissionRequest(),
      builder: (context, snapshot) {
        final needsPermissionRequest = snapshot.data ?? false;

        if (needsPermissionRequest) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _requestAppPermission();
          });
        }

        return Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_off,
                size: 80,
                color: AppColors.primary,
              ),
              AppSpace.verticalSpacing24,
              Text(
                AppConstants.locationPermissionRequired,
                style: AppTextStyle.bold24,
                textAlign: TextAlign.center,
              ),
              AppSpace.verticalSpacing16,
              Text(
                needsPermissionRequest
                    ? 'Location service is enabled. Requesting location permission...'
                    : 'Location permission is required to use this app. Please enable it in settings.',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
              AppSpace.verticalSpacing32,
              if (needsPermissionRequest)
                const CircularProgressIndicator()
              else
                CommonButton(
                  onPress: () async {
                    await openAppSettings();
                  },
                  icon: Icons.settings,
                  text: AppConstants.openSettings,
                  backgroundColor: AppColors.grey,
                ),
              AppSpace.verticalSpacing16,
              if (needsPermissionRequest) ...[
                const Text(
                  'If permission dialog doesn\'t appear, tap below:',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                AppSpace.verticalSpacing16,
                CommonButton(
                  onPress: _handleGrantPermission,
                  icon: Icons.location_on,
                  text: 'Try Again',
                  backgroundColor: AppColors.primary,
                ),
                AppSpace.verticalSpacing16,
                CommonButton(
                  onPress: () async {
                    await openAppSettings();
                  },
                  icon: Icons.settings,
                  text: AppConstants.openSettings,
                  backgroundColor: AppColors.grey,
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mapNotifierProvider);

    final bool hasMarkers = mapState.markers.isNotEmpty;
    final double buttonAreaHeight = hasMarkers ? 140 : 80;
    final double safeAreaBottom = MediaQuery.of(context).padding.bottom;
    final double totalBottomSpace = buttonAreaHeight + safeAreaBottom + 40;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        centerTitle: true,
      ),
      body: mapState.hasLocationPermission == null
          ? const Center(child: CommonLoader())
          : mapState.hasLocationPermission == false
          ? FutureBuilder<bool>(
              future: _shouldShowPermissionMessage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CommonLoader());
                }

                final shouldShowMessage = snapshot.data ?? true;

                if (shouldShowMessage) {
                  return _buildPermissionMessage();
                } else {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Requesting location permission...'),
                      ],
                    ),
                  );
                }
              },
            )
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    ref
                        .read(mapNotifierProvider.notifier)
                        .setMapController(controller);

                    _mapController = controller;

                    ref
                        .read(mapNotifierProvider.notifier)
                        .notifyMapControllerUpdated();

                    if (mapState.hasLocationPermission == true &&
                        mapState.currentLocation == null) {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        if (mounted) {
                          ref
                              .read(mapNotifierProvider.notifier)
                              .recheckLocationPermission();
                        }
                      });
                    }
                  },
                  initialCameraPosition:
                      mapState.cameraPosition ??
                      const CameraPosition(
                        target: LatLng(23.8041, 90.4152),
                        zoom: 12.0,
                      ),
                  onTap: (LatLng position) {
                    _handleMapOrMarkerTap(position);
                  },
                  markers: mapState.markers.toSet(),
                  polylines: mapState.polylines.toSet(),
                  myLocationEnabled: mapState.hasLocationPermission ?? false,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                ),
                if (mapState.isLoading) const Center(child: CommonLoader()),
                MapOverlay(routeInfo: mapState.routeInfo),
                MapControls(
                  key: ValueKey(
                    'map_controls_${_mapControllerFromProvider?.hashCode}_${mapState.currentLocation?.hashCode}',
                  ),
                  mapController: _mapControllerFromProvider,
                  currentLocation: mapState.currentLocation,
                  hasLocationPermission:
                      mapState.hasLocationPermission ?? false,
                  bottomOffset: totalBottomSpace,
                ),
                MapActionButtons(markerCount: mapState.markers.length),
              ],
            ),
    );
  }

  Future<void> _checkLocationServiceAndPermission() async {
    final serviceEnabled = await ref
        .read(mapNotifierProvider.notifier)
        .isLocationServiceEnabled();

    if (serviceEnabled) {
      final hasPermission = await ref
          .read(mapNotifierProvider.notifier)
          .recheckLocationPermission();

      if (hasPermission) {
        await ref.read(mapNotifierProvider.notifier).handleAppResume();
      } else {
        await _requestAppPermission();
      }
    } else {
      final serviceRequested = await ref
          .read(mapNotifierProvider.notifier)
          .requestLocationService();

      if (serviceRequested) {
        await ref
            .read(mapNotifierProvider.notifier)
            .handleLocationServiceEnabled();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppConstants.enableLocationServices),
              backgroundColor: AppColors.grey,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }
}
