import 'dart:math';

import 'package:flutter/material.dart';

class Seconds extends CustomPainter {
  final Paint secondHandPaint;
  final int seconds;

  Seconds({this.seconds}) : secondHandPaint = Paint() {
    secondHandPaint.color = Colors.yellowAccent;
    secondHandPaint.style = PaintingStyle.stroke;
    secondHandPaint.strokeWidth = 12;
    secondHandPaint.strokeCap = StrokeCap.round;
  }
  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();
    canvas.translate(radius, radius);
    canvas.rotate(2 * pi * seconds / 60);

    Path path = new Path();

    path.moveTo(0, radius);
    path.lineTo(0, radius / 1.75);

    canvas.drawPath(path, secondHandPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant Seconds oldDelegate) {
    return seconds != oldDelegate.seconds;
  }
}
