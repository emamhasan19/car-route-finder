package com.example.car_route_application

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.car_route_application/api_config"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getGoogleMapsApiKey" -> {
                    // Get the API key from BuildConfig (Secret Gradle Plugin will inject it here)
                    val apiKey = BuildConfig.MAPS_API_KEY
                    result.success(apiKey)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
