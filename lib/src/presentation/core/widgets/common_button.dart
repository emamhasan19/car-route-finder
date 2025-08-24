import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    required this.text,
    required this.onPress,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    super.key,
  });

  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final String text;
  final Function? onPress;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final bool isButtonDisabled = isLoading || isDisabled;

    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: isButtonDisabled
            ? null
            : () {
                FocusManager.instance.primaryFocus?.unfocus();
                onPress?.call();
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: textColor ?? AppColors.secondary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
          disabledForegroundColor: AppColors.secondary.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpace.getDefaultButtonRadius(borderRadius),
            ),
            side: BorderSide(
              color: borderColor ?? AppColors.transparent,
              width: borderColor != null ? 1.5 : 0,
            ),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? AppColors.secondary,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Icon(
                      icon,
                      color: textColor ?? AppColors.secondary,
                      size: 20,
                    ),
                  AppSpace.horizontalSpacing8,
                  Text(
                    text,
                    style: AppTextStyle.medium18.copyWith(
                      color: textColor ?? AppColors.secondary,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
      ),
    );
  }
}
