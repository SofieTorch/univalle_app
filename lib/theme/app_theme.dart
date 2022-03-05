import 'package:flutter/material.dart';
import 'package:univalle_app/theme/theme.dart';

class AppTheme {
  static TextTheme get lightTextTheme {
    return TextTheme(
      headline1: AppTextStyle.headline1,
      headline2: AppTextStyle.headline2,
      headline3: AppTextStyle.headline3,
      subtitle1: AppTextStyle.subtitle1,
      bodyText1: AppTextStyle.body,
      button: AppTextStyle.button,
      caption: AppTextStyle.caption,
      overline: AppTextStyle.overline,
    );
  }

  static ThemeData get light {
    return ThemeData(
      textTheme: lightTextTheme,
      primarySwatch: AppColors.shiraz,
      backgroundColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: const AppBarTheme(
        color: AppColors.white,
        foregroundColor: AppColors.matterhorn,
        elevation: 0.5,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.shiraz,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.shiraz[400],
        elevation: 0,
      ),
      iconTheme: const IconThemeData(size: 32),
    );
  }
}
