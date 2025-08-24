import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/route_info.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class RouteInfoCard extends StatelessWidget {
  const RouteInfoCard({super.key, required this.routeInfo});
  final RouteInfo routeInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsGeometry.only(top: 12),
      decoration: BoxDecoration(
        color: AppColors.secondary.withAlpha(220),
        borderRadius: AppSpace.radius12,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(12),
            blurRadius: 12,
            offset: const Offset(0, 3),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.primary.withAlpha(8),
            blurRadius: 16,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(color: AppColors.white.withAlpha(100), width: 1),
      ),
      child: Padding(
        padding: AppSpace.padding8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Compact Header
            Container(
              width: double.infinity,
              padding: AppSpace.paddingH10V6,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withAlpha(20),
                    AppColors.primary.withAlpha(10),
                  ],
                ),
                borderRadius: AppSpace.radius4,
                border: Border.all(
                  color: AppColors.primary.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: AppSpace.padding4,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.route_outlined,
                      color: AppColors.primary,
                      size: 14,
                    ),
                  ),
                  AppSpace.horizontalSpacing8,
                  Text(
                    AppConstants.routeInformation,
                    style: AppTextStyle.bold12.copyWith(
                      color: AppColors.primary,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),

            AppSpace.verticalSpacing8,

            // Compact Distance and Duration Cards
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    icon: Icons.straighten,
                    label: AppConstants.distance,
                    value:
                        '${routeInfo.distance.toStringAsFixed(1)}'
                        ' ${AppConstants.kilometers}',
                    color: AppColors.primary,
                  ),
                ),
                AppSpace.horizontalSpacing8,
                Expanded(
                  child: _buildInfoCard(
                    icon: Icons.schedule,
                    label: AppConstants.duration,
                    value: '${routeInfo.duration} ${AppConstants.minutes}',
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),

            AppSpace.verticalSpacing8,

            // Compact Location Details
            Container(
              padding: AppSpace.padding12,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.white.withAlpha(200),
                    AppColors.white.withAlpha(150),
                  ],
                ),
                borderRadius: AppSpace.radius8,
                border: Border.all(
                  color: AppColors.grey.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _buildLocationRow(
                    icon: Icons.my_location,
                    label: 'Origin',
                    coordinates: routeInfo.origin,
                    color: AppColors.success,
                  ),
                  AppSpace.verticalSpacing8,
                  _buildLocationRow(
                    icon: Icons.location_on,
                    label: 'Destination',
                    coordinates: routeInfo.destination,
                    color: AppColors.error,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: AppSpace.paddingH8V10,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.white.withAlpha(200),
            AppColors.white.withAlpha(150),
          ],
        ),
        borderRadius: AppSpace.radius8,
        border: Border.all(color: color.withAlpha(40), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: AppSpace.padding5,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          AppSpace.verticalSpacing4,
          Text(
            label,
            style: AppTextStyle.medium10.copyWith(
              color: AppColors.grey,
              letterSpacing: 0.2,
            ),
          ),
          AppSpace.verticalSpacing2,
          Text(
            value,
            style: AppTextStyle.bold12.copyWith(
              color: color,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow({
    required IconData icon,
    required String label,
    required LatLng coordinates,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: AppSpace.padding4,
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            shape: BoxShape.circle,
            border: Border.all(color: color.withAlpha(60), width: 1),
          ),
          child: Icon(icon, color: color, size: 14),
        ),
        AppSpace.horizontalSpacing8,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyle.medium12.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                ),
              ),
              AppSpace.verticalSpacing2,
              Container(
                padding: AppSpace.paddingH6V3,
                decoration: BoxDecoration(
                  color: AppColors.grey.withAlpha(30),
                  borderRadius: AppSpace.radius3,
                ),
                child: Text(
                  '${coordinates.latitude.toStringAsFixed(4)},'
                  ' ${coordinates.longitude.toStringAsFixed(4)}',
                  style: AppTextStyle.regular10.copyWith(color: AppColors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
