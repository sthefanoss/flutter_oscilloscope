import 'package:flutter/material.dart';

const oscilloscopeBackgroundColor = Color(0xFF142618);
const oscilloscopeActiveColor = Color(0xFF0BFC55);

final oscilloscopeThemeData = ThemeData(
  scaffoldBackgroundColor: const Color(0xffBAA694),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFDFE1E3),
    foregroundColor: Color(0xFF48454B),
  ),
  sliderTheme: const SliderThemeData(
    activeTrackColor: Color(0xFF3F333F),
    inactiveTrackColor: Color(0xFF3F333F),
    thumbColor: Color(0xFF6D6463),
  ),
);
