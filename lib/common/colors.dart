import 'package:flutter/material.dart';

enum AppColors with ColorValues {
  red(Color(0xffEC1A1A), "Red"),
  green(Color(0xff29BB2F), "Green"),
  white(Colors.white, "White"),
  darkText(Color(0xff2C2B2B), "darkText"),
  medTextColor(Color(0xff484747), "medTextColor"),
  secondary(Color(0xffD9CBAD), "secondary"),
  low(Color(0xffD0D0D0), "low"),
  inActive(Color(0xFF9DB2CE), "inActive"),
  cta(Color(0xFF4169E1), "cta"),
  lightActive(Color(0xFF5A5A5A), "lightActive"),
  secondaryTextColor(Color(0xFF363535), "secondaryTextColor"),
  bgColor(Color(0xFFF2F2F4), "bgColor"),
  fieldTextColor(Color(0xFF565656), "fieldTextColor"),
  primaryColor(Colors.blue, "primaryColor"),
  linkTextColor(Color(0xFFDAC79A), "linkTextColor");

  final Color color;
  final String name;

  const AppColors(this.color, this.name);

  @override
  int redCode() => color.r.round(); // double → int
  @override
  int greenCode() => color.g.round();
  @override
  int blueCode() => color.b.round();

  @override
  String toString() => "Color name is: $name";

  String hexCode() {
    final r = color.r.round().toRadixString(16).padLeft(2, '0');
    final g = color.g.round().toRadixString(16).padLeft(2, '0');
    final b = color.b.round().toRadixString(16).padLeft(2, '0');
    return "#$r$g$b";
  }
}

mixin ColorValues {
  int redCode() => -1;
  int greenCode() => -1;
  int blueCode() => -1;
}
