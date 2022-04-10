import 'package:flutter/material.dart';
import 'package:univalle_app/theme/theme.dart';

/// Official theme for the app, containing text theme
/// and individual components theme
class AppTheme {
  /// Text theme for light mode, currently the only mode.
  /// Dark text on light surface
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

  /// Theme on light mode, currently the only mode.
  /// Defines primary colors and individual components theme.
  static ThemeData get light {
    return ThemeData(
      textTheme: lightTextTheme,

      /// Sets the default size of icons to 32
      iconTheme: const IconThemeData(size: 32),

      /// Sets the primary color to shiraz, in
      /// order to match the design
      primarySwatch: AppColors.shiraz,
      backgroundColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.white,

      /// Sets the default app bar background color to white, with dark
      /// text and 0.5 of elevation in order to match the design
      appBarTheme: AppBarTheme(
        color: AppColors.white,
        foregroundColor: AppColors.matterhorn,
        iconTheme: const IconThemeData(size: 32, color: AppColors.matterhorn),
        elevation: 0.5,
        actionsIconTheme: IconThemeData(
          size: 32,
          color: AppColors.gray.shade300,
        ),
        toolbarTextStyle: lightTextTheme.headline2,
      ),

      /// Sets the default background color, selected and
      /// unselected item color to match the design, making use of
      /// the primary color shiraz. Also, sets the type
      /// to fixed in order to avoid color changes.
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.shiraz.shade500,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.shiraz.shade400,
        elevation: 0.5,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        unselectedIconTheme: const IconThemeData(size: 28),
        selectedIconTheme: const IconThemeData(size: 24),
      ),

      /// Sets the default shape, colors, elevation and padding
      /// to match the design, making use of the primary color shiraz
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

      /// Sets the default shape and colors to match the design,
      /// using the primary color shiraz for text and its variation
      /// shiraz 100 when it is pressed
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

      /// Sets the default style of text fields to match
      /// the design. Mainly removes borders and applies a
      /// circular border radius to corners.
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

      /// Sets the default colors of chips to match the design,
      /// making use of color gray and gray 200.
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.gray.shade200,
        labelStyle: AppTextStyle.overline.copyWith(color: AppColors.gray),
        padding: const EdgeInsets.all(4),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
      ),

      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.matterhorn,
        horizontalTitleGap: 8,
      ),
    );
  }
}
