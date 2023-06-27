import 'package:flutter/material.dart';

class Utils {
  Utils._();

  //Mediaquery for bottom navigator bar
  static double getBottomNavigatorHeight(context) {
    return MediaQuery.of(context).size.height * 0.085;
  }
}
