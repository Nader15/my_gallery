
import 'package:flutter/material.dart';
import '../../../../Utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.hint,
      this.validator,
      this.controller,
      required this.icon})
      : super(key: key);
  final String hint;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.GREY_SHADE_COLOR),
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        hintText: hint,
        // floatingLabelAlignment: FloatingLabelAlignment.center,
        filled: true,
        fillColor: AppColors.WHITE_COLOR,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.GREY_SHADE_COLOR)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.RED_COLOR)),
      ),
    );
  }
}
