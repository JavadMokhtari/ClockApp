import 'package:clock_app/screens/clock_screen.dart';
import 'package:clock_app/screens/alarm_screen.dart';
import 'package:clock_app/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'constants/colors.dart';

void main(List<String> args) {
  runApp(const ClockApp());
}

class ClockApp extends StatefulWidget {
  const ClockApp({super.key});

  @override
  State<ClockApp> createState() => _ClockAppState();
}

class _ClockAppState extends State<ClockApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ClockScreen(),
    );
  }
}
