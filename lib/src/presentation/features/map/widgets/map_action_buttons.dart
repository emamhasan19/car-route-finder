import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/common_button.dart';
import '../riverpod/map_provider.dart';

class MapActionButtons extends ConsumerWidget {
  const MapActionButtons({super.key, required this.markerCount});

  final int markerCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 20,
      left: 20,
      right: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (markerCount > 0) ...[
            CommonButton(
              text: AppConstants.clear,
              onPress: () =>
                  ref.read(mapNotifierProvider.notifier).clearRoute(),
              icon: Icons.clear,
            ),
            AppSpace.verticalSpacing12,
          ],
          CommonButton(
            text: AppConstants.findRoute,
            onPress: () => ref.read(mapNotifierProvider.notifier).findRoute(),
            icon: Icons.route,
            isDisabled: markerCount != 2,
          ),
        ],
      ),
    );
  }
}
