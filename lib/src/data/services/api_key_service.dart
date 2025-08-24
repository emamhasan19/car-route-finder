import 'package:flutter/services.dart';

class ApiKeyService {
  static const MethodChannel _channel = MethodChannel(
    'com.example.car_route_application/api_config',
  );

  /// Get Google Maps API key from native Android configuration
  static Future<String> getGoogleMapsApiKey() async {
    try {
      final String apiKey = await _channel.invokeMethod('getGoogleMapsApiKey');
      if (apiKey.isNotEmpty) {
        return apiKey;
      } else {
        throw Exception('Empty API key received from native configuration');
      }
    } on PlatformException catch (e) {
      throw Exception('❌ Unexpected error getting API key: ${e.message}');
    } catch (e) {
      throw Exception('❌ Unexpected error getting API key: $e');
    }
  }
}
