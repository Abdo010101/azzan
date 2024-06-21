import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class AppThemes {
  static ThemeData getTheme() =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark
          ? AppThemes.dark
          : AppThemes.light;
//! this theme for the light mode ////////////////////////////////////

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primaryColor,
    primarySwatch: AppColors.pinkAccent,
    brightness: AppColors.brightnessLight,
    dividerColor: AppColors.lightGray,
    dialogBackgroundColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.white,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.lightGray,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.black,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      centerTitle: true,
      color: AppColors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 21.0,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 32.0,
      ),
      headlineMedium: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
      ),
      headlineSmall: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      ),
      bodySmall: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        fontSize: 19.0,
      ),
      // caption: TextStyle(
      //   color: AppColors.black,
      //   fontWeight: FontWeight.w500,
      //   fontSize: 18.0,
      // ),
    ),
  );

//!  this them for dark mode ///////////////////////////////////
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.pinkAccent,
    primarySwatch: AppColors.pinkAccent,
    brightness: AppColors.brightnessDark,
    dividerColor: AppColors.darkGray,
    // backgroundColor: AppColors.darkGray,
    dialogBackgroundColor: AppColors.darkGray,
    scaffoldBackgroundColor: AppColors.black,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.black,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.white,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      centerTitle: true,
      toolbarHeight: 68,
      color: AppColors.black,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(
        color: AppColors.white,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 21.0,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 32.0,
      ),
      headlineMedium: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
      ),
      headlineSmall: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      ),
      bodySmall: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w400,
        fontSize: 19.0,
      ),
      // caption: TextStyle(
      //   color: AppColors.white,
      //   fontWeight: FontWeight.w500,
      //   fontSize: 18.0,
      // ),
    ),
  );
}
