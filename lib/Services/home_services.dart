import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio_import;
import 'package:my_gallery/Logic/Controllers/home_controller.dart';
import '../Models/myGallery_model.dart';
import '../Utils/app_constants.dart';

class HomeServices {
  Future<MyGalleryModel> getMyGallery() async {
    var data = await http.get(
      Uri.parse("${AppConstants.apiUrl}my-gallery"),
      headers: {
        'Accept': 'application/json',
        // HttpHeaders.authorizationHeader: AppConstants().UserTocken
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var decodedData = jsonDecode(data.body);
    if (decodedData['status'] == "success") {
      var jsonData = data.body;
      if (kDebugMode) {
        print("My Gallery --> $jsonData");
      }
      return myGalleryModelFromJson(jsonData);
    } else {
      return throw Exception("Failed to load My Gallery");
    }
  }
  static uploadImage(
      File? image,
      ) async {
    final homeController = Get.find<HomeController>();
    dio_import.Dio dio = dio_import.Dio();
    dio_import.FormData formData = dio_import.FormData.fromMap({
      "img": homeController
          .imageFile.value!.path.isNotEmpty?await dio_import.MultipartFile.fromFile("${image!.path}",
          filename: "${image.path.split('/').last}"):image,

    });
    var response = await dio.post(
      "${AppConstants.apiUrl}upload",
      data: formData,
      options: dio_import.Options(
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: AppConstants().UserTocken
        },
      ),
    );
    var jsonData = response.data;
    if (jsonData["status"]=="success") {
      if (kDebugMode) {
        print("Upload Image Api --> $jsonData");
      }
      return jsonData;
    } else {
      return throw Exception("Failed to Upload Image");
    }
  }
}
