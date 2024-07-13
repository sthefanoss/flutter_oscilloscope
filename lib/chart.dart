import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<double> data;

  const Chart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 125),
      painter: ChartPainter(data),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<double> data;

  ChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff41FF00)
      ..strokeWidth = 3.0;

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
