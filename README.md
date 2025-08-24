# Car Route Finder Application

A Flutter application that provides interactive car route planning using Google Maps with Clean Architecture implementation.

## 🚀 Features

- **Interactive Map Interface**: Users can pan and zoom the map with smooth interactions
- **Point Selection**: Tap on the map to select origin and destination points with visual markers
- **Route Display**: Automatically shows the optimal car route between selected points with polylines
- **Route Information**: Displays comprehensive route details including distance, duration, and coordinates
- **Location Services**: Current location detection with permission handling
- **Clean UI**: Modern Material Design with custom theme support
- **Responsive Design**: Optimized for various screen sizes and orientations

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
Presentation Layer (UI) → Domain Layer (Business Logic) → Data Layer (Data Access)
```

### Architecture Layers

- **Presentation Layer** (`lib/src/presentation/`): UI components, state management using Riverpod, and navigation
- **Domain Layer** (`lib/src/domain/`): Business logic, entities, use cases, and repository interfaces
- **Data Layer** (`lib/src/data/`): Repository implementations, data models, and external services
- **Core Layer** (`lib/src/core/`): Base classes, utilities, dependency injection, and configuration

### Key Benefits

- ✅ **Separation of Concerns**: UI logic separated from business logic and data access
- ✅ **Testability**: Each layer can be tested independently
- ✅ **Maintainability**: Clear structure makes code easier to understand and modify
- ✅ **Scalability**: Easy to add new features following the same pattern
- ✅ **Dependency Inversion**: High-level modules don't depend on low-level modules

## 📋 Prerequisites

Before running this project, ensure you have:

- **Flutter SDK**: Version 3.8.1 or higher
- **Dart SDK**: Compatible with Flutter version
- **Android Studio** or **VS Code** with Flutter extensions
- **Google Maps API Key**: Required for map functionality
- **Android SDK**: For Android development
- **Xcode**: For iOS development (macOS only)

## 🛠️ Installation & Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd car_route_application
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Google Maps API Key Setup

#### Option A: Secret Gradle Plugin (Recommended for Production)

This project uses the Secret Gradle Plugin for secure API key storage.

1. **Create `android/local.properties`** (copy from template if available):
```properties
sdk.dir=/path/to/your/android/sdk
flutter.sdk=/path/to/your/flutter/sdk
flutter.buildMode=debug
flutter.versionName=1.0.0
flutter.versionCode=1

# Google Maps API Key (Secret)
MAPS_API_KEY=YOUR_ACTUAL_GOOGLE_MAPS_API_KEY
```

2. **The Secret Gradle Plugin automatically**:
   - Reads secrets from `local.properties`
   - Injects them into `BuildConfig`
   - Makes them available to your native code

#### Option B: Direct Configuration (Development Only)

**⚠️ Warning: This method is NOT recommended for production use**

##### Android
Add your API key to `android/app/src/main/AndroidManifest.xml`:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_API_KEY"/>
```

##### iOS
Add your API key to `ios/Runner/AppDelegate.swift`:
```swift
GMSServices.provideAPIKey("YOUR_API_KEY")
```

### 4. Generate Code

Run the build runner to generate necessary files:
```bash
flutter packages pub run build_runner build
```

### 5. Run the Application

```bash
flutter run
```

## 🔧 Dependencies

### Core Dependencies

- **`flutter_riverpod`**: State management and dependency injection
- **`go_router`**: Navigation and routing
- **`google_maps_flutter`**: Google Maps integration
- **`flutter_polyline_points`**: Route polyline handling
- **`location`**: Location services and GPS functionality
- **`permission_handler`**: Permission management for location access

### Development Dependencies

- **`build_runner`**: Code generation
- **`freezed`**: Immutable data classes
- **`riverpod_annotation`**: Code generation for Riverpod
- **`flutter_lints`**: Code quality and style enforcement

## 🗂️ Project Structure

```
lib/
├── main.dart                          # Application entry point
├── src/
│   ├── core/                         # Core functionality
│   │   ├── base/                     # Base classes and interfaces
│   │   ├── config/                   # Configuration files
│   │   ├── constants/                # Application constants
│   │   ├── di/                       # Dependency injection
│   │   └── logger/                   # Logging utilities
│   ├── data/                         # Data layer
│   │   ├── models/                   # Data models
│   │   ├── repositories/             # Repository implementations
│   │   └── services/                 # External services
│   ├── domain/                       # Domain layer
│   │   ├── entities/                 # Business entities
│   │   ├── repositories/             # Repository interfaces
│   │   └── use_cases/                # Business logic use cases
│   └── presentation/                 # Presentation layer
│       ├── core/                     # Core UI components
│       │   ├── router/               # Navigation routing
│       │   ├── theme/                # App theming
│       │   └── widgets/              # Common widgets
│       └── features/                 # Feature-specific UI
│           └── map/                  # Map feature
│               ├── models/           # Map-specific models
│               ├── riverpod/         # State management
│               ├── utils/            # Map utilities
│               ├── view/             # Map page
│               └── widgets/          # Map-specific widgets
```

## 🚗 Usage

### Basic Route Planning

1. **Launch the App**: Open the application to see the interactive map
2. **Set Origin Point**: Tap anywhere on the map to set the origin point (green marker)
3. **Set Destination**: Tap again to set the destination point (red marker)
4. **View Route**: The optimal car route will automatically be displayed with:
   - Route polyline on the map
   - Distance and duration information
   - Turn-by-turn directions
5. **Clear Route**: Use the clear button to reset and plan a new route

### Advanced Features

- **Current Location**: Use the location button to center the map on your current position
- **Map Controls**: Zoom in/out, pan, and rotate the map view
- **Route Information**: View detailed route statistics and coordinates
- **Permission Handling**: Automatic location permission requests with user-friendly dialogs

## 🔐 Security Features

### API Key Management

- **Secret Gradle Plugin**: Securely stores API keys in `local.properties` (not committed to git)
- **Development Fallback**: Development keys available with clear warnings (NOT for production)
- **Native Integration**: API keys retrieved through native method channels
- **Build-time Injection**: Keys injected during build process, not exposed in APK

### Security Best Practices

- ✅ API keys are not hardcoded in source code
- ✅ `local.properties` is gitignored
- ✅ Keys are not exposed in APK files
- ✅ Follows Android security best practices

## 🚀 Building for Production

### Android

```bash
# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release
```

### iOS

```bash
# Build for iOS
flutter build ios --release
```

## 🔧 Troubleshooting

### Common Issues

#### API Key Not Found
- Ensure `local.properties` exists and contains `MAPS_API_KEY`
- Check that the Secret Gradle Plugin is properly configured
- Verify `buildFeatures.buildConfig = true` is set in `build.gradle.kts`

#### Location Permissions
- Ensure location permissions are granted in device settings
- Check that location services are enabled
- Verify app has necessary permissions in manifest files

#### Build Errors
- Run `flutter clean` and `flutter pub get`
- Ensure all dependencies are compatible
- Check Flutter and Dart SDK versions

## 📱 Platform Support

- **Android**: API level 21+ (Android 5.0+)
- **iOS**: iOS 11.0+
- **Web**: Modern browsers with WebGL support
- **Desktop**: Windows, macOS, and Linux (experimental)

**Note**: This application requires a valid Google Maps API key to function. Please ensure you have proper API key setup before running the application.

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/19209439-c1ec-48f6-99f3-4d6ebdf6f91f" alt="img1" style="width: 100%;"></td>
    <td><img src="https://github.com/user-attachments/assets/f30fd581-3c93-4f1c-8291-09141278f206" alt="img2" style="width: 100%;"></td>
    <td><img src="https://github.com/user-attachments/assets/bd878a76-0ea7-49af-a9b8-cac252b0357d" alt="img3" style="width: 100%;"></td>
    <td><img src="https://github.com/user-attachments/assets/43d89df7-69de-40d1-993e-404922123f72" alt="img4" style="width: 100%;"></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/bd51431d-f0e1-4cf7-aff5-1256c800f13c" alt="img5" style="width: 100%;"></td>
    <td><img src="https://github.com/user-attachments/assets/42ef3579-2662-4251-a1dc-8e8296fcb35d" alt="img6" style="width: 100%;"></td>
    <td><img src="https://github.com/user-attachments/assets/95c16b04-e036-4a94-88b5-d39e0eb0946c" alt="img7" style="width: 100%;"></td>
    <td><img src="https://github.com/user-attachments/assets/eb538c8f-8e6a-4e4f-b6eb-400b4f223372" alt="img8" style="width: 100%;"></td>
  </tr>
</table>

