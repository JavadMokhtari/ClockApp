import 'package:flutter/material.dart';
import 'package:clock_app/constants/constants.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Timer Page",
        style: TextStyle(
          fontSize: 30,
          color: CustomColors.foreground,
        ),
      ),
    );
  }
}
