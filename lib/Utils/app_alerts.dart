import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../Utils/app_colors.dart';
import '../Logic/Controllers/home_controller.dart';
import '../Routes/routes.dart';

class AppAlerts {
  Future<bool>? onWillPop() async {
    final result = await Get.defaultDialog(
      title: 'Exit'.tr,
      titleStyle: const TextStyle(color: AppColors.RED_COLOR),
      content: Text("Are you sure you want to exit the application?", textAlign: TextAlign.center),
      cancel: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(
                color: AppColors.MAIN_COLOR,
                width: 1,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            AppColors.MAIN_COLOR,
          ),
          foregroundColor: MaterialStateProperty.all(
            AppColors.BLACK_COLOR,
          ),
        ),
        onPressed: () {
          Get.back();
        },
        child: Text("No".tr),
      ),
      confirm: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: AppColors.MAIN_COLOR)
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            AppColors.WHITE_COLOR,
          ),
          foregroundColor: MaterialStateProperty.all(
            AppColors.MAIN_COLOR,
          ),
        ),
        onPressed: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
        child: Text("Yes".tr),
      ),
      confirmTextColor: AppColors.WHITE_COLOR,
    );
    if (result == null) {
      return false;
    } else {
      return result;
    }
  }
  Future<bool>? onLogOutPop() async {
    final result = await Get.defaultDialog(
      title: 'Log Out'.tr,
      titleStyle: const TextStyle(color: AppColors.RED_COLOR),
      content: Text("Are you sure that you want to Log out?", textAlign: TextAlign.center),
      cancel: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(
                color: AppColors.MAIN_COLOR,
                width: 1,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            AppColors.MAIN_COLOR,
          ),
          foregroundColor: MaterialStateProperty.all(
            AppColors.BLACK_COLOR,
          ),
        ),
        onPressed: () {
          Get.back();
        },
        child: Text("No".tr),
      ),
      confirm: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: AppColors.MAIN_COLOR)
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            AppColors.WHITE_COLOR,
          ),
          foregroundColor: MaterialStateProperty.all(
            AppColors.MAIN_COLOR,
          ),
        ),
        onPressed: () {
          GetStorage authBox = GetStorage();
          authBox.remove('AccessToken');
          authBox.remove('UserName');
          Get.offAllNamed(Routes.authScreen);
        },
        child: Text("Yes".tr),
      ),
      confirmTextColor: AppColors.WHITE_COLOR,
    );
    if (result == null) {
      return false;
    } else {
      return result;
    }
  }

  Future<bool>? getImagePop(context) async {
    final homeController = Get.find<HomeController>();
    final result = await Get.defaultDialog(
      title: ''.tr,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      titleStyle: const TextStyle(color: AppColors.RED_COLOR),
      content: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              homeController.getGalleryImage(context);
              Get.back();
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
                Colors.purple,
              ),
              foregroundColor: MaterialStateProperty.all(AppColors.WHITE_COLOR),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.image),
                SizedBox(width: 10),
                Text("Gallery")
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              homeController.getCameraImage(context);
              Get.back();
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.purple),
              foregroundColor: MaterialStateProperty.all(
                AppColors.WHITE_COLOR,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.camera_alt_rounded),
                SizedBox(width: 10),
                Text("Camera")
              ],
            ),
          ),
        ],
      ),
      cancel: null,
      confirm: null,
    );
    if (result == null) {
      return false;
    } else {
      return result;
    }
  }
}
