import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orbital_clock_face/orbit_clock/minute_face.dart';

class HoursFace extends StatelessWidget {
  final DateTime dateTime;

  const HoursFace({Key key, this.dateTime}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Center(
      child: Transform.rotate(
        angle: 2 * pi * dateTime.second / 60,
        child: Container(
          width: s.width,
          height: s.width,
          padding: EdgeInsets.all(40),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          alignment: Alignment.bottomCenter,
          child: Transform.rotate(
            angle: -2 * pi * dateTime.second / 60,
            child: Container(
              width: s.width - 180,
              height: s.width - 180,
              padding: EdgeInsets.all(10),
              child: Stack(
                children: [
                  Container(
                    width: s.width - 180,
                    height: s.height - 180,
                    child: CustomPaint(
                      painter: InnerClock(),
                    ),
                  ),
                  MinuteFace(dateTime: dateTime),
                  hourTick(s, dateTime: dateTime),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget hourTick(Size s, {DateTime dateTime}) => Center(
      child: Transform.rotate(
        angle: dateTime.hour >= 12
            ? 2 * pi * ((dateTime.hour - 12) / 12 + dateTime.minute / 720)
            : 2 * pi * (dateTime.hour / 12 + dateTime.minute / 720),
        child: Container(
          width: s.width - 180,
          height: s.width - 180,
          padding: EdgeInsets.all(20),
          alignment: Alignment.topCenter,
          child: Container(
            width: 16,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.yellowAccent,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
        ),
      ),
    );

class InnerClock extends CustomPainter {
  final TextPainter textPainter;
  final TextStyle textStyle;

  InnerClock()
      : textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        textStyle = TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        );

  @override
  void paint(Canvas canvas, Size size) {
    final angle = 2 * pi / 12;
    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);

    for (var i = 0; i < 12; i++) {
      canvas.save();
      canvas.translate(0, -radius + 1);

      textPainter.text = TextSpan(
        text: "${i == 0 ? 12 : i}",
        style: textStyle,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();

      canvas.rotate(angle);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
