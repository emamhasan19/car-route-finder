import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle _poppins({
    required FontWeight fontWeight,
    required double fontSize,
    Color? color,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  // Regular variants (FontWeight.w400)
  static TextStyle regular8 = _poppins(
    fontWeight: FontWeight.w400,
    fontSize: 8,
  );
  static TextStyle regular10 = _poppins(
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
  static TextStyle regular12 = _poppins(
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static TextStyle regular14 = _poppins(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static TextStyle regular16 = _poppins(
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static TextStyle regular18 = _poppins(
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  static TextStyle regular20 = _poppins(
    fontWeight: FontWeight.w400,
    fontSize: 20,
  );
  static TextStyle regular22 = _poppins(
    fontWeight: FontWeight.w400,
    fontSize: 22,
  );
  static TextStyle regular24 = _poppins(
    fontWeight: FontWeight.w400,
    fontSize: 24,
  );
  static TextStyle regular26 = _poppins(
    fontWeight: FontWeight.w400,
    fontSize: 26,
  );
  static TextStyle regular28 = _poppins(
    fontWeight: FontWeight.w400,
    fontSize: 28,
  );
  static TextStyle regular30 = _poppins(
    fontWeight: FontWeight.w400,
    fontSize: 30,
  );
  static TextStyle regular32 = _poppins(
    fontWeight: FontWeight.w400,
    fontSize: 32,
  );

  // Medium variants (FontWeight.w500)
  static TextStyle medium8 = _poppins(fontWeight: FontWeight.w500, fontSize: 8);
  static TextStyle medium10 = _poppins(
    fontWeight: FontWeight.w500,
    fontSize: 10,
  );
  static TextStyle medium12 = _poppins(
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  static TextStyle medium14 = _poppins(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static TextStyle medium16 = _poppins(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static TextStyle medium18 = _poppins(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static TextStyle medium20 = _poppins(
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  static TextStyle medium22 = _poppins(
    fontWeight: FontWeight.w500,
    fontSize: 22,
  );
  static TextStyle medium24 = _poppins(
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );
  static TextStyle medium26 = _poppins(
    fontWeight: FontWeight.w500,
    fontSize: 26,
  );
  static TextStyle medium28 = _poppins(
    fontWeight: FontWeight.w500,
    fontSize: 28,
  );
  static TextStyle medium30 = _poppins(
    fontWeight: FontWeight.w500,
    fontSize: 30,
  );
  static TextStyle medium32 = _poppins(
    fontWeight: FontWeight.w500,
    fontSize: 32,
  );

  // Semi Bold variants (FontWeight.w600)
  static TextStyle semibold8 = _poppins(
    fontWeight: FontWeight.w600,
    fontSize: 8,
  );
  static TextStyle semibold10 = _poppins(
    fontWeight: FontWeight.w600,
    fontSize: 10,
  );
  static TextStyle semibold12 = _poppins(
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );
  static TextStyle semibold14 = _poppins(
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static TextStyle semibold16 = _poppins(
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static TextStyle semibold18 = _poppins(
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
  static TextStyle semibold20 = _poppins(
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
  static TextStyle semibold22 = _poppins(
    fontWeight: FontWeight.w600,
    fontSize: 22,
  );
  static TextStyle semibold24 = _poppins(
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
  static TextStyle semibold26 = _poppins(
    fontWeight: FontWeight.w600,
    fontSize: 26,
  );
  static TextStyle semibold28 = _poppins(
    fontWeight: FontWeight.w600,
    fontSize: 28,
  );
  static TextStyle semibold30 = _poppins(
    fontWeight: FontWeight.w600,
    fontSize: 30,
  );
  static TextStyle semibold32 = _poppins(
    fontWeight: FontWeight.w600,
    fontSize: 32,
  );

  // Bold variants (FontWeight.w700)
  static TextStyle bold8 = _poppins(fontWeight: FontWeight.w700, fontSize: 8);
  static TextStyle bold10 = _poppins(fontWeight: FontWeight.w700, fontSize: 10);
  static TextStyle bold12 = _poppins(fontWeight: FontWeight.w700, fontSize: 12);
  static TextStyle bold14 = _poppins(fontWeight: FontWeight.w700, fontSize: 14);
  static TextStyle bold16 = _poppins(fontWeight: FontWeight.w700, fontSize: 16);
  static TextStyle bold18 = _poppins(fontWeight: FontWeight.w700, fontSize: 18);
  static TextStyle bold20 = _poppins(fontWeight: FontWeight.w700, fontSize: 20);
  static TextStyle bold22 = _poppins(fontWeight: FontWeight.w700, fontSize: 22);
  static TextStyle bold24 = _poppins(fontWeight: FontWeight.w700, fontSize: 24);
  static TextStyle bold26 = _poppins(fontWeight: FontWeight.w700, fontSize: 26);
  static TextStyle bold28 = _poppins(fontWeight: FontWeight.w700, fontSize: 28);
  static TextStyle bold30 = _poppins(fontWeight: FontWeight.w700, fontSize: 30);
  static TextStyle bold32 = _poppins(fontWeight: FontWeight.w700, fontSize: 32);
}
