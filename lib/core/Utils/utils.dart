// first function is which platform i have

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// this function return ture if i on ios or mac
bool isApple() {
  return defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS;
}

// this function return ture if i android
bool isMobile() {
  return defaultTargetPlatform == TargetPlatform.android;
}

// this function to get the lang of app
//! we will use for padding in ar and en

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

// get language

// String getLangCode() {
//   try {
//     //window..locale.languageCode
//     switch (PlatformDispatcher.instance.locale.languageCode) {
//       case AppValues.langCodeUk:
//         return AppValues.langCodeUk;
//       case AppValues.langCodeEn:
//         return AppValues.langCodeEn;
//       default:
//         return AppValues.langCodeBasic;
//     }
//   } catch (e) {
//     return AppValues.langCodeBasic;
//   }
// }

Future<void> futureDelayed({int milleseconds = 2000}) async {
  await Future.delayed(Duration(milliseconds: milleseconds));
}
