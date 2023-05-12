import 'dart:async';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen>
    with TickerProviderStateMixin {
  late String _timeString;
  late AnimationController controller;

  @override
  void initState() {
    DateTime nowTime = DateTime.now();
    double controllerValue = nowTime.second.toDouble() / 60;

    _timeString = _formatDateTime(nowTime);
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
      value: controllerValue,
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String _formatDateTime(DateTime dateTime) {
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String hour = dateTime.hour.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: CircularStepProgressIndicator(
          height: 250,
          width: 250,
          totalSteps: 60,
          currentStep: DateTime.now().second.toInt(),
          selectedStepSize: 5,
          unselectedStepSize: 4.5,
          gradientColor: const LinearGradient(
            colors: [Colors.blueGrey, Colors.teal],
          ),
          unselectedColor: const Color.fromARGB(50, 120, 200, 120),
          child: Center(
            child: Text(
              _timeString,
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w100,
                letterSpacing: 10,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ),
      )),
    );
  }
}
