import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: AppSpace.paddingH28V20,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppSpace.radius24,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withAlpha(20),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(color: AppColors.grey.withAlpha(50), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            AppSpace.verticalSpacing16,
            Text(
              AppConstants.appName,
              style: AppTextStyle.semibold20.copyWith(color: AppColors.black),
            ),
            AppSpace.verticalSpacing4,
            Text(
              AppConstants.preparingNavigationExp,
              style: AppTextStyle.regular14.copyWith(color: AppColors.black),
            ),
          ],
        ),
      ),
    );
  }
}
