import 'package:dad_jokes_demo/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.background,
    cardColor: AppColors.cardColor,
    errorColor: AppColors.errorColor,
    textTheme: GoogleFonts.hammersmithOneTextTheme(
      TextTheme(
        headline1: TextStyle(
          color: AppColors.text,
        ),
        headline2: TextStyle(
          color: AppColors.text,
        ),
        headline3: TextStyle(
          color: AppColors.text,
        ),
        headline4: TextStyle(
          color: AppColors.text,
        ),
        headline5: TextStyle(
          color: AppColors.text,
        ),
        headline6: TextStyle(
          color: AppColors.text,
        ),
        overline: TextStyle(
          color: AppColors.text,
        ),
        subtitle1: TextStyle(
          color: AppColors.text,
        ),
        subtitle2: TextStyle(
          color: AppColors.text,
        ),
        bodyText2: TextStyle(
          color: AppColors.text,
        ),
        button: TextStyle(
          color: AppColors.text,
        ),
        caption: TextStyle(
          color: AppColors.text,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(24),
        backgroundColor: AppColors.accentColor,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.accentColor),
  );
}
