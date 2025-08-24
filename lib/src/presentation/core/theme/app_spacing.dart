import 'package:flutter/material.dart';

class AppSpace {
  // All-around padding helpers
  static const EdgeInsets padding4 = EdgeInsets.all(4);
  static const EdgeInsets padding5 = EdgeInsets.all(5);
  static const EdgeInsets padding8 = EdgeInsets.all(8);
  static const EdgeInsets padding12 = EdgeInsets.all(12);
  static const EdgeInsets padding16 = EdgeInsets.all(16);
  static const EdgeInsets padding20 = EdgeInsets.all(20);
  static const EdgeInsets padding24 = EdgeInsets.all(24);
  static const EdgeInsets padding32 = EdgeInsets.all(32);

  // Horizontal padding helpers
  static const EdgeInsets paddingH4 = EdgeInsets.symmetric(horizontal: 4);
  static const EdgeInsets paddingH6 = EdgeInsets.symmetric(horizontal: 6);
  static const EdgeInsets paddingH8 = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets paddingH10 = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets paddingH16 = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets paddingH24 = EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets paddingH28 = EdgeInsets.symmetric(horizontal: 28);
  static const EdgeInsets paddingH32 = EdgeInsets.symmetric(horizontal: 32);

  // Vertical padding helpers
  static const EdgeInsets paddingV2 = EdgeInsets.symmetric(vertical: 2);
  static const EdgeInsets paddingV3 = EdgeInsets.symmetric(vertical: 3);
  static const EdgeInsets paddingV4 = EdgeInsets.symmetric(vertical: 4);
  static const EdgeInsets paddingV6 = EdgeInsets.symmetric(vertical: 6);
  static const EdgeInsets paddingV8 = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets paddingV10 = EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsets paddingV12 = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets paddingV16 = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets paddingV20 = EdgeInsets.symmetric(vertical: 20);
  static const EdgeInsets paddingV24 = EdgeInsets.symmetric(vertical: 24);
  static const EdgeInsets paddingV32 = EdgeInsets.symmetric(vertical: 32);

  // Combined horizontal and vertical padding helpers
  static const EdgeInsets paddingH6V3 = EdgeInsets.symmetric(horizontal: 6, vertical: 3);
  static const EdgeInsets paddingH8V10 = EdgeInsets.symmetric(horizontal: 8, vertical: 10);
  static const EdgeInsets paddingH10V6 = EdgeInsets.symmetric(horizontal: 10, vertical: 6);
  static const EdgeInsets paddingH28V20 = EdgeInsets.symmetric(horizontal: 28, vertical: 20);

  // Border radius helpers
  static const BorderRadius radius3 = BorderRadius.all(Radius.circular(3));
  static const BorderRadius radius4 = BorderRadius.all(Radius.circular(4));
  static const BorderRadius radius8 = BorderRadius.all(Radius.circular(8));
  static const BorderRadius radius12 = BorderRadius.all(Radius.circular(12));
  static const BorderRadius radius16 = BorderRadius.all(Radius.circular(16));
  static const BorderRadius radius20 = BorderRadius.all(Radius.circular(20));
  static const BorderRadius radius24 = BorderRadius.all(Radius.circular(24));

  // Gap helpers for SizedBox
  static const Widget verticalSpacing2 = SizedBox(height: 2);
  static const Widget verticalSpacing4 = SizedBox(height: 4);
  static const Widget verticalSpacing8 = SizedBox(height: 8);
  static const Widget verticalSpacing12 = SizedBox(height: 12);
  static const Widget verticalSpacing16 = SizedBox(height: 16);
  static const Widget verticalSpacing24 = SizedBox(height: 24);
  static const Widget verticalSpacing32 = SizedBox(height: 32);

  // Width gap helpers
  static const Widget horizontalSpacing4 = SizedBox(width: 4);
  static const Widget horizontalSpacing8 = SizedBox(width: 8);
  static const Widget horizontalSpacing12 = SizedBox(width: 12);
  static const Widget horizontalSpacing16 = SizedBox(width: 16);
  static const Widget horizontalSpacing24 = SizedBox(width: 24);
  static const Widget horizontalSpacing32 = SizedBox(width: 32);

  // Fixed size helpers
  static const Widget size48x48 = SizedBox(width: 48, height: 48);
  static const Widget size24x24 = SizedBox(width: 24, height: 24);
  static const Widget size20x20 = SizedBox(width: 20, height: 20);
  static const Widget size40x40 = SizedBox(width: 40, height: 40);
  static const Widget size56x56 = SizedBox(width: 56, height: 56);
  
  // Height helpers
  static const Widget height1 = SizedBox(height: 1);
  static const Widget height56 = SizedBox(height: 56);
  
  // Width helpers
  static const Widget width48 = SizedBox(width: 48);
  static const Widget width24 = SizedBox(width: 24);
  static const Widget width20 = SizedBox(width: 20);
  static const Widget width40 = SizedBox(width: 40);

  // Helper method for conditional border radius
  static BorderRadius getConditionalRadius(bool isTop) {
    return BorderRadius.only(
      topLeft: Radius.circular(isTop ? 12 : 0),
      topRight: Radius.circular(isTop ? 12 : 0),
      bottomLeft: Radius.circular(!isTop ? 12 : 0),
      bottomRight: Radius.circular(!isTop ? 12 : 0),
    );
  }

  // Helper method for default button border radius
  static double getDefaultButtonRadius(double? customRadius) {
    return customRadius ?? 12.0;
  }
}
