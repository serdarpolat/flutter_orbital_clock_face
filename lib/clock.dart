import 'dart:async';
import 'package:flutter/material.dart';
import 'package:orbital_clock_face/orbit_clock/hours_face.dart';
import 'package:orbital_clock_face/orbit_clock/seconds_face.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Size get s => MediaQuery.of(context).size;

  Timer _timer;
  DateTime dateTime;

  @override
  void initState() {
    dateTime = new DateTime.now();
    _timer = new Timer.periodic(Duration(seconds: 1), setTime);
    super.initState();
  }

  void setTime(Timer timer) {
    setState(() {
      dateTime = new DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: s.width,
        height: s.height,
        padding: EdgeInsets.all(10),
        color: Colors.grey[500],
        child: Center(
          child: Container(
            width: s.width,
            height: s.width,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                SecondsFace(),
                HoursFace(dateTime: dateTime),
                SecondsTick(dateTime: dateTime),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
