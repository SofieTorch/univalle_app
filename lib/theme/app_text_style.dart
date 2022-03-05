import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:univalle_app/theme/theme.dart';

/// Defines text styles used on the app
abstract class AppTextStyle {
  static TextStyle get headline1 {
    return _headerTextStyle.copyWith(
      fontSize: 28,
      letterSpacing: 0.07,
    );
  }

  static TextStyle get headline2 {
    return _headerTextStyle.copyWith(
      fontSize: 24,
      letterSpacing: 0.12,
    );
  }

  static TextStyle get headline3 {
    return _headerTextStyle.copyWith(
      fontWeight: AppFontWeight.medium,
      letterSpacing: 0.03,
    );
  }

  static TextStyle get subtitle1 {
    return _bodyTextStyle.copyWith(
      fontWeight: AppFontWeight.semibold,
      fontSize: 18,
      letterSpacing: 0.03,
    );
  }

  static TextStyle get body {
    return _bodyTextStyle.copyWith(
      letterSpacing: 0.08,
    );
  }

  static TextStyle get button {
    return _bodyTextStyle.copyWith(
      fontWeight: AppFontWeight.bold,
      fontSize: 14,
      letterSpacing: 0.32,
    );
  }

  static TextStyle get caption {
    return _bodyTextStyle.copyWith(
      fontSize: 13,
      letterSpacing: 0.05,
    );
  }

  static TextStyle get overline {
    return _bodyTextStyle.copyWith(
      fontWeight: AppFontWeight.bold,
      fontSize: 12,
      letterSpacing: 0.18,
    );
  }

  static final _bodyTextStyle = GoogleFonts.nunitoSans(
    color: AppColors.matterhorn,
    fontSize: 16,
    fontWeight: AppFontWeight.regular,
  );

  static final _headerTextStyle = GoogleFonts.raleway(
    color: AppColors.matterhorn,
    fontSize: 20,
    fontWeight: AppFontWeight.semibold,
  );
}

/// Defines font weights used on the app
abstract class AppFontWeight {
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
