import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/Utils/app_colors.dart';
import '../../Models/login_model.dart';
import '../../Models/myGallery_model.dart' as gallery_import;
import '../../Routes/routes.dart';
import '../../Services/auth_services.dart';
import '../../Services/home_services.dart';

class HomeController extends GetxController {

  var isLoading = false.obs;
  var isLoadingImage = false.obs;

  @override
  void onInit() async {
    super.onInit();
    GetStorage().read<String>('AccessToken');
    GetStorage().read<String>('UserName');
    if (kDebugMode) {
      print(GetStorage().read<String>('AccessToken'));
      print(GetStorage().read<String>('UserName'));
    }
    getMyGallery();
  }

  var myGalleryList = <String>[].obs;

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 1), () {
      getMyGallery();
    });
  }

  getMyGallery() async {
    try {
      isLoading(true);
      var myGallery = await HomeServices().getMyGallery();
      if (myGallery.status == "success") {
        myGalleryList.value = myGallery.data.images;
      }
    } finally {
      isLoading(false);
    }
  }

  uploadImage(File? image, context) async {
    try{
      isLoadingImage(true);
      var response = await HomeServices.uploadImage(image!);
      if (response["status"] == "success") {
        if (kDebugMode) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.GREEN_COLOR,
              duration: const Duration(seconds: 5),
              content: Text(
                response["message"].toString(),
                style: const TextStyle(color: AppColors.WHITE_COLOR),
              ),
            ),
          );
        }
      }
    }finally{
      isLoadingImage(false);
      onRefresh();
    }
  }

  Rx<File?> imageFile = File("").obs;
  final ImagePicker _picker = ImagePicker();

  void getGalleryImage(context) async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    imageFile.value = File(pickedFile!.path);
    uploadImage(imageFile.value, context);
  }
  void getCameraImage(context) async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    imageFile.value = File(pickedFile!.path);
    uploadImage(imageFile.value, context);
  }
}
