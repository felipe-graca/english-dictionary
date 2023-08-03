import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class Utils {
  Utils._();

  //Mediaquery for bottom navigator bar
  static double getBottomNavigatorHeight(context) {
    return MediaQuery.of(context).size.height * 0.085;
  }

  static String get generateUid {
    final faker = Faker();
    return faker.guid.guid();
  }
}
