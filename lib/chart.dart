import 'package:flutter/material.dart';
import 'package:flutter_oscilloscope/theme.dart';

class Chart extends StatelessWidget {
  final List<double> data;

  const Chart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: oscilloscopeBackgroundColor,
      child: CustomPaint(
        size: const Size(double.infinity, 125),
        foregroundPainter: ChartPainter(data),
        painter: const ChartDivisionsPainter(),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<double> data;

  ChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = oscilloscopeActiveColor
      ..strokeWidth = 2.0;

    final double width = size.width;
    final double height = size.height;
    final double stepX = width / (data.length - 1);

    final double maxData = data.reduce((a, b) => a > b ? a : b);
    final double minData = data.reduce((a, b) => a < b ? a : b);

    final double scaleY = (height) / (maxData - minData);

    for (int i = 0; i < data.length - 1; i++) {
      final double x1 = i * stepX;
      final double y1 = height - (data[i] - minData) * scaleY;
      final double x2 = (i + 1) * stepX;
      final double y2 = height - (data[i + 1] - minData) * scaleY;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ChartDivisionsPainter extends CustomPainter {
  final int verticalBars;
  final int horizontalBars;

  const ChartDivisionsPainter({this.verticalBars = 8, this.horizontalBars = 4});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = oscilloscopeDivisionsColor
      ..strokeWidth = .5;

    final double width = size.width;
    final double height = size.height;

    final double stepX = width / verticalBars;
    final double stepY = height / horizontalBars;

    for (int i = 1; i < verticalBars; i++) {
      final double x = i * stepX;
      canvas.drawLine(Offset(x, 0), Offset(x, height), paint);
    }

    for (int i = 1; i < horizontalBars; i++) {
      final double y = i * stepY;
      canvas.drawLine(Offset(0, y), Offset(width, y), paint);
    }

    final paintBorder = Paint()
      ..color = oscilloscopeDivisionsColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paintBorder);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
