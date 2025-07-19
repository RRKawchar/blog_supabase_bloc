import 'package:blog_app/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme{


  static final darkTheme=ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,

      iconTheme: IconThemeData(
        color: Colors.white,
      )
    ),
    inputDecorationTheme:InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(color: AppColors.focusBorderColor),
      errorBorder: _border(color: AppColors.errorColor),
    ),

    chipTheme:const ChipThemeData(
      color: WidgetStatePropertyAll(AppColors.backgroundColor),
      side: BorderSide.none
    )
  );



  static _border({Color? color})=>OutlineInputBorder(
    borderSide: BorderSide(
      color:color??AppColors.borderColor,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(10),
  );
}





