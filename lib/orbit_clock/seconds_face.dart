import 'dart:math';
import 'package:flutter/material.dart';

class SecondsFace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: s.width - 50,
        height: s.width - 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: CustomPaint(
          painter: ClockDialog(),
        ),
      ),
    );
  }
}

class SecondsTick extends StatelessWidget {
  final DateTime dateTime;

  const SecondsTick({Key key, this.dateTime}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Center(
      child: Transform.rotate(
        angle: 2 * pi * dateTime.second / 60,
        child: Container(
          width: s.width,
          height: s.width,
          padding: EdgeInsets.all(45),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          alignment: Alignment.topCenter,
          child: Container(
            width: 12,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.yellowAccent,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ),
    );
  }
}

class ClockDialog extends CustomPainter {
  final Paint tickPaint;
  final TextPainter textPainter;
  final TextStyle textStyle;

  ClockDialog()
      : tickPaint = Paint(),
        textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        textStyle = TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        );

  @override
  void paint(Canvas canvas, Size size) {
    final angle = 2 * pi / 60;
    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);

    for (var i = 0; i < 60; i++) {
      tickPaint.color = i % 5 == 0 ? Colors.transparent : Colors.white;
      tickPaint.strokeWidth = i % 5 == 0 ? 0 : 7;
      tickPaint.strokeCap = StrokeCap.round;
      canvas.drawLine(Offset(0, -radius), Offset(0, -radius + 4), tickPaint);

      if (i % 5 == 0) {
        canvas.save();
        canvas.translate(0, -radius + 1);

        textPainter.text = TextSpan(
          text: "${i == 0 ? 60 : i}",
          style: textStyle,
        );

        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(-textPainter.width / 2, -textPainter.height / 2),
        );
        canvas.restore();
      }

      canvas.rotate(angle);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
