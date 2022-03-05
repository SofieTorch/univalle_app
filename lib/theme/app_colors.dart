import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color white = Color(0xFFFDFDFD);
  static const Color matterhorn = Color(0xFF49383E);
  static const Color green = Color(0xFF6FCF97);

  static const int _shirazBase = 0xFFBA0041;

  /// Shiraz swatch color, note that only 500, 400, 300, 200 and 100
  /// are official colors from design, so be careful when using the others.
  static MaterialColor get shiraz {
    return const MaterialColor(
      _shirazBase,
      <int, Color>{
        50: Color(0xFFFCE2E8),
        100: Color(0xFFFFD7E5),
        200: Color(0xFFFF93B9),
        300: Color(0xFFFF357B),
        400: Color(0xFFE3004F),
        500: Color(_shirazBase),
        600: Color(0xFFA6003F),
        700: Color(0xFFA60D3E),
        800: Color(0xFF83001B),
        900: Color(0xFF84003A),
      },
    );
  }

  static const int _grayBase = 0xFF888888;
  static MaterialColor get gray {
    return const MaterialColor(
      _grayBase,
      <int, Color>{
        100: Color(0xFFF2F2F2),
        200: Color(0xFFE4E3E3),
        300: Color(0xFFC4C4C4),
        400: Color(0xFF9C9C9C),
        500: Color(_grayBase),
      },
    );
  }
}
