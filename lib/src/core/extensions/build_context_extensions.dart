import 'dart:math';

import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext{

  void unFocusKeyboard()=>FocusScope.of(this).unfocus();

  double get screenHeight=>MediaQuery.of(this).size.height;
  double get screenWidth=> MediaQuery.of(this).size.width;
  Size get screenSize=> MediaQuery.of(this).size;

  double get minScreenSize=>min(screenHeight, screenWidth);
  double get mazScreenSize=>max(screenHeight, screenWidth);

  TextTheme get appTextTheme => Theme.of(this).textTheme;
  Color get primaryColor=> Theme.of(this).primaryColor;

}