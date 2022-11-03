import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/Utils/app_colors.dart';

import '../../Models/login_model.dart';
import '../../Routes/routes.dart';
import '../../Services/auth_services.dart';

class AuthController extends GetxController {


  @override
  void onInit() async {
    super.onInit();
  }

  var userNameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;

  GetStorage authBox = GetStorage();
  Rx<LoginModel> loginModel = LoginModel().obs;

  var isLoading = false.obs;

  Future login(String userName, String password,BuildContext context) async {
    isLoading(true);
    try{
      update();
      var response = await AuthServices()
          .loginAPI(userName, password, context);
      if (response.token==null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.RED_COLOR,
            duration: const Duration(seconds: 2),
            content: Text(response.toString(),),
          ),
        );
      }
      if(response.token!=null){
        if (kDebugMode) {
          print(
            response.user,
          );
        }
        loginModel.value = response;
        authBox.write('AccessToken', "Bearer ${loginModel.value.token}");
        authBox.write('UserName', loginModel.value.user!.name);
        Get.offAllNamed(Routes.homeScreen);
      }
      else{

      }
    }finally{
      isLoading(false);
    }
  }

}
