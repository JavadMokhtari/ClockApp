import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../widgets/bottom_navigation_bar.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CustomColors.background,
      bottomNavigationBar: ClockAppBottomNavigationBar(),
    );
  }
}
