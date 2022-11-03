import 'package:flutter/material.dart';
import '../../Utils/app_colors.dart';

class TitledTextField extends StatelessWidget {
  TitledTextField({
    Key? key,
    required this.title,
    this.titleStyle,
     this.hintText,
    this.suffixIcon,
    this.perfix,
    this.controller,
    this.onPress,
    this.onChange,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
  }) : super(key: key);
  final String title;
  String? hintText;
  final TextEditingController? controller;
  Widget? suffixIcon;
  Widget? perfix;
  Function()? onPress;
  Function(String)? onChange;
  TextInputType? keyboardType;
  TextStyle? titleStyle;
  bool obscureText;
  bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: titleStyle,),
        const SizedBox(height: 8),
        TextFormField(
          enabled: enabled,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onTap: onPress,
          controller: controller,
          onChanged:onChange ,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF9F9F9),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(25)),
              suffixIcon: suffixIcon,
              hintText: hintText,
              hintStyle: TextStyle(color: AppColors.GREY_SHADE_COLOR),
              prefixIcon: perfix),
        )
      ],
    );
  }
}
