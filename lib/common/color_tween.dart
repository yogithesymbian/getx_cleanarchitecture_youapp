import 'package:flutter/material.dart';

class ColorTweenHelper {
  static Widget animatedColor({
    required Color begin,
    required Color end,
    required Duration duration,
    required Widget Function(Color color) builder,
  }) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(begin: begin, end: end),
      duration: duration,
      builder: (context, color, child) {
        if (color == null) return const SizedBox.shrink();
        return builder(color);
      },
    );
  }

  static Color dynamicTextColor(Color background) {
    final brightness = 0.299 * background.red +
        0.587 * background.green +
        0.114 * background.blue;
    return brightness > 150 ? Colors.black : Colors.white;
  }
}


/*
* usage for test direct on widget  */
// ColorTweenHelper.animatedColor(
//   begin: Colors.red,
//   end: Colors.white,
//   duration: const Duration(seconds: 3),
//   builder: (color) {
//     final textColor = ColorTweenHelper.dynamicTextColor(color);
//     return Container(
//       width: 200,
//       height: 100,
//       color: color,
//       alignment: Alignment.center,
//       child: Text(
//         "Hello",
//         style: TextStyle(
//             color: textColor, fontWeight: FontWeight.bold),
//       ),
//     );
//   },
// )