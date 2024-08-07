import 'package:flutter/material.dart';

const oscilloscopeBackgroundColor = Color(0xFF142618);
const oscilloscopeActiveColor = Color(0xFF0BFC55);
const oscilloscopeDivisionsColor = Color(0xFFBDC641);

final oscilloscopeThemeData = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFBDBEC5),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFBDBEC5),
    foregroundColor: Color(0xFF48454B),
  ),
  sliderTheme: const SliderThemeData(
    activeTrackColor: Color(0xFF3F333F),
    inactiveTrackColor: Color(0xFF3F333F),
    thumbColor: Color(0xFF6D6463),
  ),
);
