import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/login_model.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_constants.dart';

class AuthServices {
  Future<LoginModel> loginAPI(String userName, String password, context) async {
    var data = await http.post(
      Uri.parse("${AppConstants.apiUrl}auth/login"),
      body: {
        'email': userName,
        'password': password,
      },
    );
    var jsonData = json.decode(data.body);
    var decodedData = jsonDecode(data.body);
    if (jsonData["token"] != null) {
      if (kDebugMode) {
        print(decodedData);
      }
      return LoginModel.fromJson(jsonData);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.RED_COLOR,
          duration: const Duration(seconds: 2),
          content: Text(
            jsonData["error_message"].toString(),
          ),
        ),
      );
      return throw Exception("Failed to login");
    }
  }
}
