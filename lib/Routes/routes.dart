import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_gallery/View/Screens/Home_Screen/home_screen.dart';
import '../Logic/Bindings/auth_binding.dart';
import '../Logic/Bindings/home_binding.dart';
import '../View/Screens/Auth_Screen/auth_screen.dart';
import '../View/Screens/Splash_Screen/splash_screen.dart';

class AppRoutes {
  //initialRoute
  static const splashScreen = Routes.splashScreen;
  static const authScreen = Routes.authScreen;
  static const homeScreen = Routes.homeScreen;

  //getPages
  static final routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.authScreen,
      page: () => AuthScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: Routes.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBinding()
    ),
  ];
}

class Routes {
  static const splashScreen = '/splashScreen';
  static const authScreen = '/authScreen';
  static const homeScreen = '/homeScreen';
}
