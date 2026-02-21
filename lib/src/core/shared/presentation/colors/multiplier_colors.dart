import 'package:flutter/material.dart';

class MultiplierColors {
  //Primary
  static const Color primary = Color(0xFF7F5283);

  //Secondary
  static const Color secondary = Color(0xFFfFB515);

  //Neutral
  static const Color neutral_900 = Color(0xFF101C2D);
  static const Color neutral_800 = Color(0xFF1C2636);
  static const Color neutral_700 = Color(0xFF2F3A4C);
  static const Color neutral_600 = Color(0xFF414E62);
  static const Color neutral_500 = Color(0xFF66768E);
  static const Color neutral_400 = Color(0xFF919FB6);
  static const Color neutral_300 = Color(0xFFD8D8D8);
  static const Color neutral_200 = Color(0xFFDDE4EE);
  static const Color neutral_100 = Color(0xFFF1F4F9);
  static const Color neutral_50 = Color(0xFFF9FAFB);
  static const Color neutralWhite = Color(0xFFFFFFFF);
  static const Color neutralDark = Color(0xFF000000);

  //Alerts
  static const Color success = Color(0xFF00FF00);
  static const Color warning = Color(0xFFFF7C00);
  static const Color error = Color(0xFFEC5353);
  static const Color info = Color(0xFF00AAFF);
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
