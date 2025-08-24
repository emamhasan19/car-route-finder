import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constants/app_constants.dart';

class LocationPermissionDialog extends StatelessWidget {
  const LocationPermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppConstants.locationPermissionRequired),
      content: const Text(AppConstants.locationPermissionMessage),
      actions: [
        TextButton(
          onPressed: () => SystemNavigator.pop(),
          child: const Text(AppConstants.cancel),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop(true);
            await openAppSettings();
          },
          child: const Text(AppConstants.openSettings),
        ),
      ],
    );
  }
}
