import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payhippo/_core_/views/styles/app_colors.dart';

class AppThemes {
  AppThemes._();

  static ThemeData payhippoLightTheme() {
    final textTheme = _textTheme;
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.blue0,
        primary: AppColors.blue0,
        error: const Color.fromRGBO(46, 10, 13, 1),
      ),
      textTheme: textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: textTheme.button
              ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: AppColors.black40),
        prefixIconColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return AppColors.blue0;
          }

          return AppColors.grey;
        }),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey),
        ),
      ),
      splashColor: AppColors.blue0,
    );
  }

  static final ButtonStyle primaryButtonStyle = ButtonStyle(
      textStyle: MaterialStateProperty.all(_textTheme.bodyText1!.copyWith(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      )),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.blue0.withOpacity(0.5);
        } else if (states.contains(MaterialState.pressed)) {
          return AppColors.blue0.withOpacity(0.5);
        } else {
          return AppColors.blue0;
        }
      }),
      padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 19.5, vertical: 19.5)),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))));

  static final ButtonStyle primaryLightButtonStyle = ButtonStyle(
      textStyle: MaterialStateProperty.all(const TextStyle(
        fontSize: 16,
        color: AppColors.blue0,
        fontWeight: FontWeight.w500,
      )),
      foregroundColor: MaterialStateProperty.all(AppColors.blue0),
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.blue0.withOpacity(0.05);
        } else if (states.contains(MaterialState.pressed)) {
          return AppColors.blue0.withOpacity(0.05);
        } else {
          return AppColors.blue5;
        }
      }),
      padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 19.5, vertical: 19.5)),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))));
  static TextTheme get _textTheme {
    final base = ThemeData.light().textTheme;
    return GoogleFonts.notoSansTextTheme().copyWith(
      headline4: base.headline4?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 34,
        letterSpacing: 0.4,
        height: 0.9,
      ),
      headline5: base.headline5?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 26,
        //  letterSpacing: 0.27,
      ),
      headline6: base.headline6?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        //   letterSpacing: -0.18,
      ),
      subtitle1: base.subtitle1?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        //  letterSpacing: -0.02,
      ),
      subtitle2: base.subtitle2?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        //  letterSpacing: -0.04,
      ),
      bodyText1: base.bodyText1?.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 14,
        // letterSpacing: 0.2,
      ),
      bodyText2: base.bodyText2?.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 13,
        //  letterSpacing: -0.05,
      ),
      caption: base.caption?.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 11,
        // letterSpacing: 0.2,
      ),
      overline: base.overline?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 9,
        //  letterSpacing: 0.2,
      ),
    );
  }
}
