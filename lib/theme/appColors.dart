import 'package:flutter/material.dart';

class AppColors {
  const AppColors();

  static const MaterialColor primary = const MaterialColor(
    0xff191919,
    const <int, Color>{
      50: Color(0xff595959),
      100: Color(0xff4c4c4c),
      200: Color(0xff3f3f3f),
      300: Color(0xff323232),
      400: Color(0xff262626),
      500: Color(0xff191919),
      600: Color(0xff181818),
      700: Color(0xff161616),
      800: Color(0xff151515),
      900: Color(0xff141414),
    },
  );

  static const MaterialColor secondary = const MaterialColor(
    0xffd0d0d0,
    const <int, Color>{
      50: Color(0xffdcdcdc),
      100: Color(0xffdadada),
      200: Color(0xffd8d8d8),
      300: Color(0xffd5d5d5),
      400: Color(0xffd2d2d2),
      500: Color(0xffd0d0d0),
      600: Color(0xffc6c6c6),
      700: Color(0xffb9b9b9),
      800: Color(0xffafafaf),
      900: Color(0xffa4a4a4),
    },
  );

  static const MaterialColor accent = const MaterialColor(
    0xfff1be0c,
    const <int, Color>{
      50: Color(0xfff9df84),
      100: Color(0xfff8d86b),
      200: Color(0xfff6d253),
      300: Color(0xfff5cc3b),
      400: Color(0xfff4c522),
      500: Color(0xfff1be0c),
      600: Color(0xffe5b40b),
      700: Color(0xffd9ab0b),
      800: Color(0xffcaa00a),
      900: Color(0xffbc9409),
    },
  );
}
