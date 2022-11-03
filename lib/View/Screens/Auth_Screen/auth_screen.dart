import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Logic/Controllers/auth_controller.dart';
import '../../../Routes/routes.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_constants.dart';
import '../../Widgets/titled_textField.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Column(
              children: [
                const Text(
                  "My \nGallery",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: AppColors.WHITE_COLOR,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.all(20.0),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          "Login".toUpperCase(),
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        TitledTextField(
                          controller: authController.userNameController.value,
                          title: "User Name",
                          hintText: "",
                          perfix: const Icon(Icons.email_outlined),
                        ),
                        const SizedBox(height: 20),
                        TitledTextField(
                          controller: authController.passwordController.value,
                          title: "Password",
                          hintText: "",
                          perfix: const Icon(Icons.lock_open_outlined),
                          suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                        ),
                        const SizedBox(height: 50),
                        Obx(
                          () => authController.isLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (authController.userNameController
                                              .value.text.isEmpty ||
                                          authController.passwordController
                                              .value.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor:
                                                AppColors.YELLOW_COLOR,
                                            duration: Duration(seconds: 2),
                                            content: Text(
                                                "Please fill empty fields",style: TextStyle(color: AppColors.BLACK_COLOR),),
                                          ),
                                        );
                                      } else {
                                        authController.login(
                                          authController
                                              .userNameController.value.text,
                                          authController
                                              .passwordController.value.text,
                                          context,
                                        );
                                      }
                                    },
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                        AppColors.WHITE_COLOR.withOpacity(0.1),
                                      ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: AppColors.MAIN_COLOR),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.MAIN_COLOR),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.WHITE_COLOR),
                                    ),
                                    child: Text(
                                      "Submit".toUpperCase(),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
