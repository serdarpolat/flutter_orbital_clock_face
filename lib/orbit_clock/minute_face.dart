import 'dart:math';
import 'package:flutter/material.dart';

class MinuteFace extends StatelessWidget {
  final DateTime dateTime;

  const MinuteFace({Key key, this.dateTime}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double angleHour = dateTime.hour >= 12
        ? 2 * pi * ((dateTime.hour - 12) / 12 + dateTime.minute / 720)
        : 2 * pi * (dateTime.hour / 12 + dateTime.minute / 720);
    return Container(
      width: s.width - 180,
      height: s.height - 180,
      child: Stack(
        children: [
          Center(
            child: Transform.rotate(
              angle: angleHour,
              child: Container(
                width: s.width - 180,
                height: s.height - 180,
                padding: EdgeInsets.all(16),
                alignment: Alignment.bottomCenter,
                child: Transform.rotate(
                  angle: -angleHour,
                  child: Container(
                    width: 140,
                    height: 140,
                    padding: EdgeInsets.all(3),
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            width: 140,
                            height: 140,
                            child: CustomPaint(
                              painter: MinuteDialog(),
                            ),
                          ),
                        ),
                        minuteTick(dateTime: dateTime),
                      ],
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget minuteTick({DateTime dateTime}) => Center(
      child: Transform.rotate(
        angle: 2 * pi * (dateTime.minute + (dateTime.second / 60)) / 60,
        child: Container(
          width: 140,
          height: 140,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8),
          child: Container(
            width: 4,
            height: 140 / 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ),
    );

class MinuteDialog extends CustomPainter {
  final Paint tickPaint;
  final TextPainter textPainter;
  final TextStyle textStyle;

  MinuteDialog()
      : tickPaint = Paint(),
        textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        textStyle = TextStyle(
          color: Colors.yellowAccent,
          fontSize: 7.0,
          fontWeight: FontWeight.w900,
        );

  @override
  void paint(Canvas canvas, Size size) {
    final angle = 2 * pi / 60;
    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);

    for (var i = 0; i < 60; i++) {
      tickPaint.color = i % 12 == 0 ? Colors.transparent : Colors.white;
      tickPaint.strokeWidth = i % 12 == 0 ? 0 : 1;
      canvas.drawLine(Offset(0, -radius), Offset(0, -radius + 3), tickPaint);

      if (i % 12 == 0) {
        canvas.save();
        canvas.translate(0, -radius + 2);

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
