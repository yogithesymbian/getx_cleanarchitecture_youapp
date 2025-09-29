import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Helper {
  DateTime? currentBackPressTime;
  Duration refreshDuration = const Duration(minutes: 3);

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.snackbar("Alert", "Tap again to leave!",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
          colorText: Get.theme.primaryColor);
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String formatDateWithSlash(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  Color dynamicTextColor(Color background) {
    // brightness sederhana (average R/G/B)
    final brightness =
        (background.red + background.green + background.blue) / 3;

    return brightness > 180 ? Colors.black : Colors.white;
  }

  Color dynamicTextColorForGradient(Gradient gradient) {
    final colors = gradient.colors;
    double r = 0, g = 0, b = 0;

    for (final color in colors) {
      r += color.red.toDouble();
      g += color.green.toDouble();
      b += color.blue.toDouble();
    }

    final count = colors.length;
    r /= count;
    g /= count;
    b /= count;

    final brightness = 0.299 * r + 0.587 * g + 0.114 * b;
    return brightness > 150 ? Colors.black : Colors.white;
  }
}
