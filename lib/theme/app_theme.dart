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
      iconTheme: const IconThemeData(size: 32),
      primarySwatch: AppColors.shiraz,
      backgroundColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: const AppBarTheme(
        color: AppColors.white,
        foregroundColor: AppColors.matterhorn,
        elevation: 0.5,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.shiraz.shade500,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.shiraz.shade400,
        elevation: 0.5,
        type: BottomNavigationBarType.fixed,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.shiraz),
          foregroundColor: MaterialStateProperty.all(AppColors.white),
          elevation: MaterialStateProperty.all(0.5),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
          padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColors.shiraz[100];
              }
              return AppColors.white;
            },
          ),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.gray[100],
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 14,
        ),
        suffixIconColor: AppColors.gray,
        hintStyle: AppTextStyle.subtitle1.copyWith(
          color: AppColors.gray.shade300,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.gray.shade200,
        labelStyle: AppTextStyle.overline.copyWith(color: AppColors.gray),
        padding: const EdgeInsets.all(4),
      ),
    );
  }
}
