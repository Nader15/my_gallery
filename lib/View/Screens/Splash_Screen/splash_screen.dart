import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import '../../../Routes/routes.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashScreen> {
  late Timer timer;

  void _goNext() => GetStorage().read<String>('AccessToken') == null
      ? Get.offAllNamed(Routes.authScreen)
      : Get.offAllNamed(Routes.homeScreen);

  startDelay() {
    timer = Timer(const Duration(seconds: 5), _goNext);
  }

  @override
  void initState() {
    startDelay();
    GetStorage().read<String>('AccessToken');
    if (kDebugMode) {
      print(GetStorage().read<String>('AccessToken'));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.MAIN_COLOR,
      body: Center(
        child:   Lottie.asset(
          "assets/icons/animated_logo.json",
          height: 150,
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
