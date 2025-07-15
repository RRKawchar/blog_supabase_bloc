import 'package:blog_app/src/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class KButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? width;
  const KButton({super.key, required this.onPressed, required this.text, this.width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColors.buttonColor,
        shadowColor: AppColors.transparentColor,
        fixedSize: Size(width??context.screenWidth, 50),
      ),
      child: Text(text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),),
    );
  }
}
