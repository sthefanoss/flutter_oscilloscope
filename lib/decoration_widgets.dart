import 'package:flutter/material.dart';
import 'package:flutter_oscilloscope/theme.dart';

class OscilloscopeChartDecoration extends StatelessWidget {
  const OscilloscopeChartDecoration({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF14131A),
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: oscilloscopeBackgroundColor,
          border: Border.all(
            color: const Color(0xFF14131A),
            width: 5,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: oscilloscopeActiveColor),
          child: child,
        ),
      ),
    );
  }
}

class OscilloscopeInputDecoration extends StatelessWidget {
  const OscilloscopeInputDecoration({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5E7),
        border: Border.all(color: const Color(0xFF2A1C1B)),
      ),
      child: child,
    );
  }
}
