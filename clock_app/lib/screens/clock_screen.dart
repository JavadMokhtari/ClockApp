import 'dart:async';
import 'package:flutter/material.dart';
import 'package:clock_app/constants/colors.dart';
import 'package:clock_app/widgets/bottom_navigation_bar.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late String _timeString;

  @override
  void initState() {
    DateTime nowTime = DateTime.now();
    _timeString = _formatDateTime(nowTime);
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String hour = dateTime.hour.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularStepProgressIndicator(
        height: 200,
        width: 200,
        totalSteps: 60,
        currentStep: DateTime.now().second.toInt(),
        selectedStepSize: 5,
        unselectedStepSize: 4.5,
        gradientColor: GradientColors.linearGrad,
        unselectedColor: const Color.fromARGB(80, 0, 0, 0),
        child: Center(
          child: Text(
            _timeString,
            style: const TextStyle(
              fontSize: 35,
              fontFamily: "ubuntu",
              letterSpacing: 5,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
