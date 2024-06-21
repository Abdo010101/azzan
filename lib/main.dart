import 'dart:developer';

import 'package:azzan/Features/HomeFeature/presentaion/cubit/home_cubit.dart';
import 'package:azzan/blocObserver.dart';
import 'package:azzan/core/Routes/app_routes_logic.dart';
import 'package:azzan/core/Network/di.dart';
import 'package:azzan/core/Network/sharred_pref.dart';
import 'package:azzan/core/Service/local_notification_service.dart';
import 'package:azzan/core/Utils/constants.dart';
import 'package:azzan/core/Utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:workmanager/workmanager.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'generated/l10n.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    //! here we must check for the button that tell i want the azzan or not
    if (task == "schedulePrayerNotifications") {
      var prayerName = inputData!['prayerName'] as String;
      final timeString = inputData['time'] as String;
      var time = DateTime.parse(timeString);

      //! here we must check for the button that tell i want the azzan or not
      //  check from homecuit.switchButtonForEachPrayer;
      LocalNotificationService.secduledNotification(
          prayerTime: time, prayerName: prayerName);
    }
    return Future.value(false);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));

  setUp();
  getIt<Preferences>().init();
  Bloc.observer = MyBlocObserver();

  await LocalNotificationService.init();
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const MyApp(), // Wrap your app
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          locale: AppValues.LocalBase,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: AppThemes.getTheme(),
          onGenerateRoute: AppRoutes.onGenerateRoute,
          navigatorKey: AppRoutes.navigatorKey,
        );
      },
      //child: const SplashScreen(),
    );
  }
}
