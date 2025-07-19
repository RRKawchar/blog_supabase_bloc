import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isObscure;
  final int? maxLines;
  const CustomTextFiled({
    super.key,
    this.controller,
    required this.hintText,
     this.isObscure=false,
    this.maxLines=1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(hintText: hintText),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      obscureText: isObscure,
    );
  }
}
