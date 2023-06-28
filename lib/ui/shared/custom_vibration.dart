import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class CustomVibration {
  CustomVibration._();

  static void lightImpact() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      HapticFeedback.lightImpact();
    } else {
      Vibration.vibrate(duration: 40);
    }
  }

  static void mediumImpact() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      HapticFeedback.mediumImpact();
    } else {
      Vibration.vibrate(duration: 45);
    }
  }

  static void heavyImpact() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      HapticFeedback.heavyImpact();
    } else {
      Vibration.vibrate(duration: 50);
    }
  }
}
