import 'package:flutter/material.dart';

class AppValues {
  /// en lang code
  static String langCodeBase = 'ar';
  static const String langCodeEn = 'en';

  /// uk lang code
  static const String langCodeAR = 'ar';

  static Locale LocalBase = Locale(langCodeBase);
  // Locale uk
  static const Locale localeAR = Locale(langCodeAR);

  /// Locale en
  static const Locale localeEN = Locale(langCodeEn);

  /// Supported locales (en, de)
  static const List<Locale> supportedLocales = <Locale>[
    localeAR,
    localeEN,
  ];
}
