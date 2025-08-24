class AppConstants {
  // App Information
  static const appName = 'Car Route';

  // UI Labels and Titles
  static const routeInformation = 'Route Information';
  static const distance = 'Distance';
  static const duration = 'Duration';
  static const origin = 'Origin';
  static const destination = 'Destination';
  static const marker = 'Marker';
  static const preparingNavigationExp =
      'Preparing your navigation experience...';

  // Button Texts
  static const clear = 'Clear';
  static const findRoute = 'Find Route';
  static const cancel = 'Cancel';
  static const remove = 'Remove';
  static const openSettings = 'Open Settings';
  static const grantPermission = 'Grant Permission';

  // Dialog Titles and Content
  static const locationPermissionRequired = 'Location Permission Required';
  static const locationPermissionMessage =
      'This app needs location permission to show your current location on the'
      ' map and provide accurate route information.\n\n'
      'Please go to Settings > Apps > [App Name] > Permissions and enable '
      'Location access.';

  // Snackbar Messages
  static const locationPermissionGranted =
      'Location permission granted! Map updated with your location.';
  static const locationPermissionGrantedTemporarily =
      'Location permission granted for this session.';
  static const locationPermissionNotGranted =
      'Location permission not granted. Please enable it in settings.';
  static const checkingLocationPermission = 'Checking location permission...';
  static const enableLocationServices =
      'Please enable Location Services in your device settings to use this'
      'app.';

  // Route Quality Labels
  static const routeQualityExcellent = 'Excellent';
  static const routeQualityGood = 'Good';
  static const routeQualityFair = 'Fair';
  static const routeQualityPoor = 'Poor';

  // Units
  static const kilometers = 'km';
  static const minutes = 'min';
  static const hours = 'h';
  static const seconds = 's';
  static const na = 'N/A';

  // Error Messages
  static const emptyApiKeyError =
      'Empty API key received from native configuration';
  static const unexpectedApiKeyError =
      'Unexpected error getting API key: {error}';
  static const noRoutesAvailable = 'No routes available';
  static const noRoutesFound = 'No routes found: {error}';

  // Map Constants
  static const defaultLatitude = 23.8041;
  static const defaultLongitude = 90.4152;
  static const defaultZoom = 12.0;
  static const currentLocationZoom = 15.0;
  static const routePolylineWidth = 5;
  static const routeBoundsPadding = 200.0;
  static const maxMarkers = 2;
}
