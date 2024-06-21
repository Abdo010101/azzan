import 'package:azzan/Features/HomeFeature/presentaion/home_screen.dart';
import 'package:azzan/Features/HomeFeature/presentaion/home_screen_new.dart';
import 'package:azzan/core/Routes/app_routes.dart';
import 'package:azzan/core/Utils/app_strings.dart';
import 'package:azzan/Features/SplashFeature/presentaion/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) {
          return const SplashScreen();
        });

      case Routes.newHome:
        return MaterialPageRoute(builder: (context) {
          return HomeScreenNew();
        });
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(AppStrings.notfound),
              ),
            )));
  }
}
